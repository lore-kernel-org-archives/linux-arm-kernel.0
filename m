From: tiny.windzz@gmail.com (Yangtao Li)
Date: Fri, 23 Nov 2018 10:06:00 -0500
Subject: [PATCH] clk: nomadik: Change to use DEFINE_SHOW_ATTRIBUTE macro
Message-ID: <20181123150600.27445-1-tiny.windzz@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/clk/clk-nomadik.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/clk-nomadik.c b/drivers/clk/clk-nomadik.c
index 84a24875c629..e331634d34df 100644
--- a/drivers/clk/clk-nomadik.c
+++ b/drivers/clk/clk-nomadik.c
@@ -479,17 +479,7 @@ static int nomadik_src_clk_show(struct seq_file *s, void *what)
 	return 0;
 }
 
-static int nomadik_src_clk_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, nomadik_src_clk_show, NULL);
-}
-
-static const struct file_operations nomadik_src_clk_debugfs_ops = {
-	.open           = nomadik_src_clk_open,
-	.read           = seq_read,
-        .llseek         = seq_lseek,
-	.release        = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(nomadik_src_clk_debugfs);
 
 static int __init nomadik_src_clk_init_debugfs(void)
 {
@@ -499,7 +489,7 @@ static int __init nomadik_src_clk_init_debugfs(void)
 	src_pcksr0_boot = readl(src_base + SRC_PCKSR0);
 	src_pcksr1_boot = readl(src_base + SRC_PCKSR1);
 	debugfs_create_file("nomadik-src-clk", S_IFREG | S_IRUGO,
-			    NULL, NULL, &nomadik_src_clk_debugfs_ops);
+			    NULL, NULL, &nomadik_src_clk_debugfs_fops);
 	return 0;
 }
 device_initcall(nomadik_src_clk_init_debugfs);
-- 
2.17.0
