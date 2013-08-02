From: jason@lakedaemon.net (Jason Cooper)
Date: Fri,  2 Aug 2013 15:51:11 +0000
Subject: [RFC PATCH V2 4/9] s/.name/.compatible/
In-Reply-To: <cover.1375457714.git.jason@lakedaemon.net>
References: <cover.1375457714.git.jason@lakedaemon.net>
Message-ID: <1e66851fa0a7c137afbb39a27c77d5a585b466f6.1375457714.git.jason@lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jason Cooper <jason@lakedaemon.net>
---
 board-raumfeld.c | 18 +++++++++---------
 board.h          |  2 +-
 main.c           |  2 +-
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/board-raumfeld.c b/board-raumfeld.c
index fe51bcb..e5d4702 100644
--- a/board-raumfeld.c
+++ b/board-raumfeld.c
@@ -21,19 +21,19 @@ static struct board boards[] = {
 		.machid		= 2413,
 		.system_rev	= 0,
 		.dtb		= &_binary_input_raumfeld_controller_0_dtb_start,
-		.name		= "Raumfeld Controller, revision 0",
+		.compatible	= "Raumfeld Controller, revision 0",
 	},
 	{
 		.machid		= 2413,
 		.system_rev	= 1,
 		.dtb		= &_binary_input_raumfeld_controller_1_dtb_start,
-		.name		= "Raumfeld Controller, revision 1",
+		.compatible	= "Raumfeld Controller, revision 1",
 	},
 	{
 		.machid		= 2413,
 		.system_rev	= 2,
 		.dtb		= &_binary_input_raumfeld_controller_2_dtb_start,
-		.name		= "Raumfeld Controller, revision 2",
+		.compatible	= "Raumfeld Controller, revision 2",
 	},
 
 	/* Controller */
@@ -41,19 +41,19 @@ static struct board boards[] = {
 		.machid		= 2414,
 		.system_rev	= 0,
 		.dtb		= &_binary_input_raumfeld_connector_0_dtb_start,
-		.name		= "Raumfeld Connector, revision 0",
+		.compatible	= "Raumfeld Connector, revision 0",
 	},
 	{
 		.machid		= 2414,
 		.system_rev	= 1,
 		.dtb		= &_binary_input_raumfeld_connector_1_dtb_start,
-		.name		= "Raumfeld Connector, revision 1",
+		.compatible	= "Raumfeld Connector, revision 1",
 	},
 	{
 		.machid		= 2414,
 		.system_rev	= 2,
 		.dtb		= &_binary_input_raumfeld_connector_2_dtb_start,
-		.name		= "Raumfeld Connector, revision 2",
+		.compatible	= "Raumfeld Connector, revision 2",
 	},
 
 	/* Speaker */
@@ -61,19 +61,19 @@ static struct board boards[] = {
 		.machid		= 2415,
 		.system_rev	= 0,
 		.dtb		= &_binary_input_raumfeld_speaker_0_dtb_start,
-		.name		= "Raumfeld Speaker, revision 0",
+		.compatible	= "Raumfeld Speaker, revision 0",
 	},
 	{
 		.machid		= 2415,
 		.system_rev	= 1,
 		.dtb		= &_binary_input_raumfeld_speaker_1_dtb_start,
-		.name		= "Raumfeld Speaker, revision 1",
+		.compatible	= "Raumfeld Speaker, revision 1",
 	},
 	{
 		.machid		= 2415,
 		.system_rev	= 2,
 		.dtb		= &_binary_input_raumfeld_speaker_2_dtb_start,
-		.name		= "Raumfeld Speaker, revision 2",
+		.compatible	= "Raumfeld Speaker, revision 2",
 	},
 	{ 0, 0, NULL, NULL }	/* sentinel */
 };
diff --git a/board.h b/board.h
index ec2b79e..5146db0 100644
--- a/board.h
+++ b/board.h
@@ -5,7 +5,7 @@ struct board {
 	__u32		machid;
 	__u32		system_rev;
 	void		*dtb;
-	const char	*name;
+	const char	*compatible;
 };
 
 struct board *match_board(__u32 machid, const struct tag *);
diff --git a/main.c b/main.c
index 65ec9a7..8673703 100644
--- a/main.c
+++ b/main.c
@@ -20,7 +20,7 @@ void main(__u32 dummy, __u32 machid, const struct tag *tags)
 	board = match_board(machid, tags);
 
 	putstr("Detected board: ");
-	putstr(board->name);
+	putstr(board->compatible);
 	putstr("\n");
 
 	putstr("Booting into Linux kernel ...\n");
-- 
1.8.3.2
