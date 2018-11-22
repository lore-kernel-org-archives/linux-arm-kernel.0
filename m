From: tiny.windzz@gmail.com (Yangtao Li)
Date: Thu, 22 Nov 2018 07:59:41 -0500
Subject: [PATCH] soc: sunxi: Change to use DEFINE_SHOW_ATTRIBUTE macro
Message-ID: <20181122125941.24615-1-tiny.windzz@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/soc/sunxi/sunxi_sram.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/soc/sunxi/sunxi_sram.c b/drivers/soc/sunxi/sunxi_sram.c
index b4b0f3480bd3..71e3ee4a3f19 100644
--- a/drivers/soc/sunxi/sunxi_sram.c
+++ b/drivers/soc/sunxi/sunxi_sram.c
@@ -155,17 +155,7 @@ static int sunxi_sram_show(struct seq_file *s, void *data)
 	return 0;
 }
 
-static int sunxi_sram_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, sunxi_sram_show, inode->i_private);
-}
-
-static const struct file_operations sunxi_sram_fops = {
-	.open = sunxi_sram_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(sunxi_sram);
 
 static inline struct sunxi_sram_desc *to_sram_desc(const struct sunxi_sram_data *data)
 {
-- 
2.17.0
