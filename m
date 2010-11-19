From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri, 19 Nov 2010 22:12:23 +0100
Subject: [PATCH 4/4] mtd: FSMC NAND fix obvious speling errors
Message-ID: <1290201143-15332-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix spelling in the interface file.

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 include/linux/mtd/fsmc.h |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/mtd/fsmc.h b/include/linux/mtd/fsmc.h
index 91f5e6f..4dd8114 100644
--- a/include/linux/mtd/fsmc.h
+++ b/include/linux/mtd/fsmc.h
@@ -27,7 +27,7 @@
 
 /*
  * The placement of the Command Latch Enable (CLE) and
- * Address Latch Enable (ALE) is twised around in the
+ * Address Latch Enable (ALE) is twisted around in the
  * SPEAR310 implementation.
  */
 #if defined(CONFIG_MACH_SPEAR310)
@@ -62,7 +62,7 @@ struct fsmc_nor_bank_regs {
 
 /* ctrl_tim register definitions */
 
-struct fsms_nand_bank_regs {
+struct fsmc_nand_bank_regs {
 	u32 pc;
 	u32 sts;
 	u32 comm;
@@ -78,7 +78,7 @@ struct fsms_nand_bank_regs {
 struct fsmc_regs {
 	struct fsmc_nor_bank_regs nor_bank_regs[FSMC_MAX_NOR_BANKS];
 	u8 reserved_1[0x40 - 0x20];
-	struct fsms_nand_bank_regs bank_regs[FSMC_MAX_NAND_BANKS];
+	struct fsmc_nand_bank_regs bank_regs[FSMC_MAX_NAND_BANKS];
 	u8 reserved_2[0xfe0 - 0xc0];
 	u32 peripid0;			/* 0xfe0 */
 	u32 peripid1;			/* 0xfe4 */
-- 
1.7.3.2
