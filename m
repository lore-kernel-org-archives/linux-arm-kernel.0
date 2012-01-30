From: b32955@freescale.com (Huang Shijie)
Date: Mon, 30 Jan 2012 12:36:14 +0800
Subject: [PATCH] mtd/gpmi : add BBT support
Message-ID: <1327898174-13656-1-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add the BBT support to the gpmi nand driver.
Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 drivers/mtd/nand/gpmi-nand/gpmi-nand.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
index 493ec2f..4fbb341 100644
--- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
@@ -1493,6 +1493,7 @@ static int __devinit gpmi_nfc_init(struct gpmi_nand_data *this)
 	chip->ecc.mode		= NAND_ECC_HW;
 	chip->ecc.size		= 1;
 	chip->ecc.layout	= &gpmi_hw_ecclayout;
+	chip->bbt_options	= NAND_BBT_USE_FLASH | NAND_BBT_NO_OOB;
 
 	/* Allocate a temporary DMA buffer for reading ID in the nand_scan() */
 	this->bch_geometry.payload_size = 1024;
-- 
1.7.0.4
