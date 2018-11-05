From: tiny.windzz@gmail.com (Yangtao Li)
Date: Mon,  5 Nov 2018 09:32:34 -0500
Subject: [PATCH] ARM: mm: dump: Change to use DEFINE_SHOW_ATTRIBUTE macro
Message-ID: <20181105143234.6015-1-tiny.windzz@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 arch/arm/mm/ptdump_debugfs.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/arch/arm/mm/ptdump_debugfs.c b/arch/arm/mm/ptdump_debugfs.c
index be8d87be4b93..201cd467a739 100644
--- a/arch/arm/mm/ptdump_debugfs.c
+++ b/arch/arm/mm/ptdump_debugfs.c
@@ -12,17 +12,7 @@ static int ptdump_show(struct seq_file *m, void *v)
 	return 0;
 }
 
-static int ptdump_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, ptdump_show, inode->i_private);
-}
-
-static const struct file_operations ptdump_fops = {
-	.open		= ptdump_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(ptdump);
 
 int ptdump_debugfs_register(struct ptdump_info *info, const char *name)
 {
-- 
2.17.0
