From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sat,  7 Jan 2012 11:49:29 +0100
Subject: [PATCH 2/3] mtd/atmel_nand: add on_flash_bbt to enable the use of On
 Flash BBT
In-Reply-To: <1325933370-17475-1-git-send-email-plagnioj@jcrosoft.com>
References: <1325933370-17475-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1325933370-17475-2-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

from the board

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: linux-mtd at lists.infradead.org
---
 drivers/mtd/nand/atmel_nand.c |    2 +-
 include/linux/atmel_nand.h    |    1 +
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/mtd/nand/atmel_nand.c b/drivers/mtd/nand/atmel_nand.c
index c267113..d7ff628 100644
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
diff --git a/include/linux/atmel_nand.h b/include/linux/atmel_nand.h
index f6d4193..57b651b 100644
--- a/include/linux/atmel_nand.h
+++ b/include/linux/atmel_nand.h
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
