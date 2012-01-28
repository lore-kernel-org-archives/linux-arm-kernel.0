From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sat, 28 Jan 2012 06:10:40 +0100
Subject: [FOR 3.3 PATCH 2/6] mtd/atmel_nand: add on_flash_bbt to enable the
 use of On Flash BBT
In-Reply-To: <1327727444-23908-1-git-send-email-plagnioj@jcrosoft.com>
References: <1327727444-23908-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1327727444-23908-2-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

from the board

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: linux-mtd at lists.infradead.org
---
 drivers/mtd/nand/atmel_nand.c       |    2 +-
 include/linux/platform_data/atmel.h |    1 +
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/mtd/nand/atmel_nand.c b/drivers/mtd/nand/atmel_nand.c
index 0d955e1..d3bde9b 100644
--- a/drivers/mtd/nand/atmel_nand.c
+++ b/drivers/mtd/nand/atmel_nand.c
@@ -525,7 +525,7 @@ static int __init atmel_nand_probe(struct platform_device *pdev)
 		}
 	}
 
-	if (on_flash_bbt) {
+	if (host->board->on_flash_bbt || on_flash_bbt) {
 		printk(KERN_INFO "atmel_nand: Use On Flash BBT\n");
 		nand_chip->bbt_options |= NAND_BBT_USE_FLASH;
 	}
diff --git a/include/linux/platform_data/atmel.h b/include/linux/platform_data/atmel.h
index 7b8a445..d056263 100644
--- a/include/linux/platform_data/atmel.h
+++ b/include/linux/platform_data/atmel.h
@@ -19,6 +19,7 @@ struct atmel_nand_data {
 	u8		cle;			/* address line number connected to CLE */
 	u8		bus_width_16;		/* buswidth is 16 bit */
 	u8		ecc_mode;		/* ecc mode */
+	u8		on_flash_bbt;		/* bbt on flash */
 	struct mtd_partition *parts;
 	unsigned int	num_parts;
 };
-- 
1.7.7
