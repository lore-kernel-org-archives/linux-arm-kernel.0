From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon,  7 Dec 2015 23:26:01 +0100
Subject: [PATCH 06/23] mtd: nand: kill unused ->ecclayout field in
 platform_nand_chip struct
In-Reply-To: <1449527178-5930-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1449527178-5930-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1449527178-5930-7-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This field is not set in any board file and can thus be dropped.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/nand/plat_nand.c | 1 -
 include/linux/mtd/nand.h     | 2 --
 2 files changed, 3 deletions(-)

diff --git a/drivers/mtd/nand/plat_nand.c b/drivers/mtd/nand/plat_nand.c
index 06ac6c6..71aaa09 100644
--- a/drivers/mtd/nand/plat_nand.c
+++ b/drivers/mtd/nand/plat_nand.c
@@ -74,7 +74,6 @@ static int plat_nand_probe(struct platform_device *pdev)
 	data->chip.bbt_options |= pdata->chip.bbt_options;
 
 	data->chip.ecc.hwctl = pdata->ctrl.hwcontrol;
-	data->chip.ecc.layout = pdata->chip.ecclayout;
 	data->chip.ecc.mode = NAND_ECC_SOFT;
 
 	platform_set_drvdata(pdev, data);
diff --git a/include/linux/mtd/nand.h b/include/linux/mtd/nand.h
index fad634e..cbedcb0 100644
--- a/include/linux/mtd/nand.h
+++ b/include/linux/mtd/nand.h
@@ -866,7 +866,6 @@ extern int nand_do_read(struct mtd_info *mtd, loff_t from, size_t len,
  * @chip_delay:		R/B delay value in us
  * @options:		Option flags, e.g. 16bit buswidth
  * @bbt_options:	BBT option flags, e.g. NAND_BBT_USE_FLASH
- * @ecclayout:		ECC layout info structure
  * @part_probe_types:	NULL-terminated array of probe types
  */
 struct platform_nand_chip {
@@ -874,7 +873,6 @@ struct platform_nand_chip {
 	int chip_offset;
 	int nr_partitions;
 	struct mtd_partition *partitions;
-	struct nand_ecclayout *ecclayout;
 	int chip_delay;
 	unsigned int options;
 	unsigned int bbt_options;
-- 
2.1.4
