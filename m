From: computersforpeace@gmail.com (Brian Norris)
Date: Tue, 31 May 2011 16:31:25 -0700
Subject: [PATCH 6/8] mtd: nand: rename CREATE_EMPTY bbt flag with proper prefix
In-Reply-To: <1306884687-1824-1-git-send-email-computersforpeace@gmail.com>
References: <1306884687-1824-1-git-send-email-computersforpeace@gmail.com>
Message-ID: <1306884687-1824-7-git-send-email-computersforpeace@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to our new prefix rules, we should rename NAND_CREATE_EMPTY_BBT
with a NAND_BBT prefix, i.e., NAND_BBT_CREATE_EMPTY.

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
---
 drivers/mtd/nand/nand_bbt.c |    2 +-
 include/linux/mtd/bbm.h     |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/nand_bbt.c b/drivers/mtd/nand/nand_bbt.c
index 2e4e259..9af703d 100644
--- a/drivers/mtd/nand/nand_bbt.c
+++ b/drivers/mtd/nand/nand_bbt.c
@@ -970,7 +970,7 @@ static int check_create(struct mtd_info *mtd, uint8_t *buf, struct nand_bbt_desc
 			continue;
 
 		/* Create the table in memory by scanning the chip(s) */
-		if (!(this->bbt_options & NAND_CREATE_EMPTY_BBT))
+		if (!(this->bbt_options & NAND_BBT_CREATE_EMPTY))
 			create_bbt(mtd, buf, bd, chipsel);
 
 		td->version[i] = 1;
diff --git a/include/linux/mtd/bbm.h b/include/linux/mtd/bbm.h
index 3cf4a8a..0fa030a 100644
--- a/include/linux/mtd/bbm.h
+++ b/include/linux/mtd/bbm.h
@@ -92,7 +92,7 @@ struct nand_bbt_descr {
  * layout or if this information is already purged. Must be used in conjunction
  * with NAND_BBT_CREATE.
  */
-#define NAND_CREATE_EMPTY_BBT	0x01000000
+#define NAND_BBT_CREATE_EMPTY	0x01000000
 /* Search good / bad pattern through all pages of a block */
 #define NAND_BBT_SCANALLPAGES	0x00000400
 /* Scan block empty during good / bad block scan */
-- 
1.7.0.4
