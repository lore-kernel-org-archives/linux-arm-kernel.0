From: tiny.windzz@gmail.com (Yangtao Li)
Date: Tue,  6 Nov 2018 09:33:55 -0500
Subject: [PATCH] ARM: OMAP1: clock: Change to use DEFINE_SHOW_ATTRIBUTE macro
Message-ID: <20181106143355.8340-1-tiny.windzz@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 arch/arm/mach-omap1/clock.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap1/clock.c b/arch/arm/mach-omap1/clock.c
index fa512413a471..c8c6fe88b2d6 100644
--- a/arch/arm/mach-omap1/clock.c
+++ b/arch/arm/mach-omap1/clock.c
@@ -968,7 +968,7 @@ late_initcall(omap_clk_enable_autoidle_all);
 
 static struct dentry *clk_debugfs_root;
 
-static int clk_dbg_show_summary(struct seq_file *s, void *unused)
+static int debug_clock_show(struct seq_file *s, void *unused)
 {
 	struct clk *c;
 	struct clk *pa;
@@ -988,17 +988,7 @@ static int clk_dbg_show_summary(struct seq_file *s, void *unused)
 	return 0;
 }
 
-static int clk_dbg_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, clk_dbg_show_summary, inode->i_private);
-}
-
-static const struct file_operations debug_clock_fops = {
-	.open           = clk_dbg_open,
-	.read           = seq_read,
-	.llseek         = seq_lseek,
-	.release        = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(debug_clock);
 
 static int clk_debugfs_register_one(struct clk *c)
 {
-- 
2.17.0
