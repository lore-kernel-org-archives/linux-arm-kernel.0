From: tiny.windzz@gmail.com (Yangtao Li)
Date: Thu, 22 Nov 2018 09:05:19 -0500
Subject: [PATCH] firmware: ti_sci: Change to use DEFINE_SHOW_ATTRIBUTE macro
Message-ID: <20181122140519.25166-1-tiny.windzz@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/firmware/ti_sci.c | 21 ++-------------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 69ed1464175c..3fbbb61012c4 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -146,25 +146,8 @@ static int ti_sci_debug_show(struct seq_file *s, void *unused)
 	return 0;
 }
 
-/**
- * ti_sci_debug_open() - debug file open
- * @inode:	inode pointer
- * @file:	file pointer
- *
- * Return: result of single_open
- */
-static int ti_sci_debug_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, ti_sci_debug_show, inode->i_private);
-}
-
-/* log file operations */
-static const struct file_operations ti_sci_debug_fops = {
-	.open = ti_sci_debug_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
+/* Provide the log file operations interface*/
+DEFINE_SHOW_ATTRIBUTE(ti_sci_debug);
 
 /**
  * ti_sci_debugfs_create() - Create log debug file
-- 
2.17.0
