From: dolinux.peng@gmail.com (Peng Donglin)
Date: Wed, 13 Jun 2018 09:11:56 +0800
Subject: [PATCH 2/2] ARM64: dump: Convert to use DEFINE_SHOW_ATTRIBUTE macro
In-Reply-To: <b55024472e101a33b3d6b098aa2ce23c5b5dd6f7.1528819790.git.dolinux.peng@gmail.com>
References: <b55024472e101a33b3d6b098aa2ce23c5b5dd6f7.1528819790.git.dolinux.peng@gmail.com>
Message-ID: <7f70740d2e9f21d273e0c6bdef6fca2b511a285e.1528819790.git.dolinux.peng@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Peng Donglin <dolinux.peng@gmail.com>
---
 arch/arm64/mm/ptdump_debugfs.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/arch/arm64/mm/ptdump_debugfs.c b/arch/arm64/mm/ptdump_debugfs.c
index 02b18f8..24d786f 100644
--- a/arch/arm64/mm/ptdump_debugfs.c
+++ b/arch/arm64/mm/ptdump_debugfs.c
@@ -10,18 +10,7 @@ static int ptdump_show(struct seq_file *m, void *v)
 	ptdump_walk_pgd(m, info);
 	return 0;
 }
-
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
2.7.4
