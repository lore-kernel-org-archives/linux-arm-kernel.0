From: tiny.windzz@gmail.com (Yangtao Li)
Date: Tue,  6 Nov 2018 09:35:16 -0500
Subject: [PATCH] ARM: OMAP: PM: Change to use DEFINE_SHOW_ATTRIBUTE macro
Message-ID: <20181106143516.8394-1-tiny.windzz@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 arch/arm/mach-omap1/pm.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap1/pm.c b/arch/arm/mach-omap1/pm.c
index 3e1de14805e4..998075d3ef86 100644
--- a/arch/arm/mach-omap1/pm.c
+++ b/arch/arm/mach-omap1/pm.c
@@ -532,18 +532,7 @@ static int omap_pm_debug_show(struct seq_file *m, void *v)
 	return 0;
 }
 
-static int omap_pm_debug_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, omap_pm_debug_show,
-				&inode->i_private);
-}
-
-static const struct file_operations omap_pm_debug_fops = {
-	.open		= omap_pm_debug_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(omap_pm_debug);
 
 static void omap_pm_init_debugfs(void)
 {
-- 
2.17.0
