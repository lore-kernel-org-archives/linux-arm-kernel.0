From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Thu, 12 Jun 2014 15:20:41 +0200
Subject: [PATCHv4 1/5] mtd: gpmi: remove useless (void *) type casts and
 spaces between type casts and variables
In-Reply-To: <1402579245-13377-1-git-send-email-LW@KARO-electronics.de>
References: <1402579245-13377-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <1402579245-13377-2-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 drivers/mtd/nand/gpmi-nand/gpmi-nand.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
index f638cd8..31032b1 100644
--- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
@@ -1180,7 +1180,7 @@ static int gpmi_ecc_write_page(struct mtd_info *mtd, struct nand_chip *chip,
 
 		/* Handle block mark swapping. */
 		block_mark_swapping(this,
-				(void *) payload_virt, (void *) auxiliary_virt);
+				(void *)payload_virt, (void *)auxiliary_virt);
 	} else {
 		/*
 		 * If control arrives here, we're not doing block mark swapping,
@@ -1760,16 +1760,16 @@ err_out:
 static const struct of_device_id gpmi_nand_id_table[] = {
 	{
 		.compatible = "fsl,imx23-gpmi-nand",
-		.data = (void *)&gpmi_devdata_imx23,
+		.data = &gpmi_devdata_imx23,
 	}, {
 		.compatible = "fsl,imx28-gpmi-nand",
-		.data = (void *)&gpmi_devdata_imx28,
+		.data = &gpmi_devdata_imx28,
 	}, {
 		.compatible = "fsl,imx6q-gpmi-nand",
-		.data = (void *)&gpmi_devdata_imx6q,
+		.data = &gpmi_devdata_imx6q,
 	}, {
 		.compatible = "fsl,imx6sx-gpmi-nand",
-		.data = (void *)&gpmi_devdata_imx6sx,
+		.data = &gpmi_devdata_imx6sx,
 	}, {}
 };
 MODULE_DEVICE_TABLE(of, gpmi_nand_id_table);
-- 
1.7.10.4
