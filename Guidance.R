library(DBI)
library(RMySQL)
library(dplyr)

# Set up the connection parameters
config <- list(
  host = "host",
  user = "root",
  dbname = "your_database",
  port = your_port,
  password = "your_password"
)

# Establish the connection
conn <- dbConnect(RMySQL::MySQL(),
                  user = config$user,
                  password = config$password,
                  dbname = config$dbname,
                  host = config$host,
                  port = config$port)

# Execute SQL queries on the connected database/schema
dbListTables(conn)

copy_to(conn, 
        storms,
        overwrite = TRUE)

# Examples ----------------------------------------------------------------

dbWriteTable(conn, "storms", storms, overwrite = TRUE) # Append a dataframe
dbGetQuery(conn, "SELECT * FROM storms") 
dbGetQuery(conn, "SELECT * FROM storms WHERE year > 1975")

## You can also create your own table.
dbSendQuery(conn, "CREATE TABLE example_table(column_1 TEXT, column_2 INTEGER);")
dbSendQuery(conn, "INSERT INTO example_table VALUES('Row_1', 1)")
dbGetQuery(conn, "SELECT * FROM example_table")

# Close the connection
dbDisconnect(conn)
