DROP TABLE IF EXISTS player CASCADE;
DROP TABLE IF EXISTS team CASCADE;
DROP TABLE IF EXISTS batting CASCADE;
DROP TABLE IF EXISTS pitching CASCADE;
DROP TABLE IF EXISTS fielding CASCADE;
DROP TABLE IF EXISTS all_star CASCADE;
DROP TABLE IF EXISTS hall_of_fame CASCADE;
DROP TABLE IF EXISTS award CASCADE;
DROP TABLE IF EXISTS player_team_xref;


CREATE TABLE player (
playerID text PRIMARY KEY,
birthYear integer,
birthMonth integer,
birthDay integer,
birthCountry text,
birthState text,
birthCity text,
nameFirst text,
nameLast text,
nameGiven text,
weight integer,
height integer,
bats text,
throws text,
debut date,
finalGame date);

CREATE TABLE team (
year integer,
lg text,
teamID text,
div text,
rank integer,
G integer,
GHome integer,
W integer,
L integer,
DivWin text,
WCWin text,
LgWin text,
WSWin text,
R integer,
AB integer,
H integer,
TwoB integer,
ThreeB integer,
HR integer,
BB integer,
K integer,
SB integer,
CS integer,
HBP integer,
SF integer,
RA integer,
ER integer,
ERA double precision,
CG integer,
shutouts integer,
saves integer,
IPOuts integer,
HA integer,
HRA integer,
BBA integer,
KA integer,
E integer,
DP integer,
FP decimal(5, 4),
name text);

CREATE TABLE batting (
playerID text REFERENCES player(playerID),
year integer
stint integer,
teamID text,
lg text,
games integer,
AB integer,
R integer,
H integer,
TwoB integer,
ThreeB integer,
HR integer,
RBI integer,
SB integer,
CS integer,
BB integer,
K integer,
IBB integer,
HBP integer,
SH integer,
SF integer,
GIDP integer);

CREATE TABLE pitching (
playerID text REFERENCES player(playerID),
year integer,
stint integer,
team text,
lg text,
W integer,
L integer,
G integer,
GS integer,
CG integer,
shutouts integer,
saves integer,
IPOuts integer,
H integer,
ER integer,
HR integer,
BB integer,
K integer,
BAOpp numeric(4, 3),
ERA double precision,
IBB integer,
WP integer,
HBP double precision,
BK integer,
BFP integer,
GF integer,
R integer,
SH integer,
SF integer,
GIDP integer);

CREATE TABLE fielding (
playerID text REFERENCES player(playerID),
year integer,
stint integer,
team text,
lg text,
Pos text,
G integer,
GS integer,
InnOuts integer,
PO integer,
A integer,
E integer,
DP integer,
PB integer,
WP integer,
SB integer,
CS integer);

CREATE TABLE all_star (
playerID text REFERENCES player(playerID),
year integer,
team text,
lg text,
startingPos text);

CREATE TABLE hall_of_fame (
playerID text REFERENCES player(playerID),
year integer,
inducted text,
category text);

CREATE TABLE award (
playerID text REFERENCES player(playerID),
award text,
year text,
lg text);


CREATE TABLE player_team_xref(
team_name text REFERENCES team(name),
playerID text REFERENCES player(playerID)
);

INSERT into player_team_xref (team_name, playerID)
SELECT t.name, p.playerID from pitching as p, team as t
WHERE t.teamid = p.team;

INSERT into player_team_xref (team_name, playerID)
SELECT t.name, f.playerID from fielding as f, team as t
WHERE t.teamid = f.team;

INSERT into player_team_xref (team_name, playerID)
SELECT t.name, b.playerID from batting as b, team as t
WHERE t.teamid = b.teamid;


\copy player from 'C:\Users\garre\My Documents\CSCI 403\project9\baseballdatabank-master\core\Players.csv' WITH CSV HEADER;

\copy team from 'C:\Users\garre\My Documents\CSCI 403\project9\baseballdatabank-master\core\Team.csv' WITH CSV HEADER;

\copy batting from 'C:\Users\garre\My Documents\CSCI 403\project9\baseballdatabank-master\core\Batting.csv' WITH CSV HEADER;

\copy pitching from 'C:\Users\garre\My Documents\CSCI 403\project9\baseballdatabank-master\core\Pitching.csv' WITH CSV HEADER;

\copy fielding from 'C:\Users\garre\My Documents\CSCI 403\project9\baseballdatabank-master\core\Fielding1.csv' WITH CSV HEADER;

\copy all_star from 'C:\Users\garre\My Documents\CSCI 403\project9\baseballdatabank-master\core\Allstar.csv' WITH CSV HEADER;

\copy hall_of_fame from 'C:\Users\garre\My Documents\CSCI 403\project9\baseballdatabank-master\core\HallOfFame1.csv' WITH CSV HEADER;

\copy award from 'C:\Users\garre\My Documents\CSCI 403\project9\baseballdatabank-master\core\Awards.csv' WITH CSV HEADER;