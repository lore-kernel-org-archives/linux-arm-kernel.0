From: mcuos.com@gmail.com (Wan ZongShun)
Date: Sat, 05 Jun 2010 17:37:21 +0800
Subject: [PATCH] MTD/pxa: use __devexit, __devinit  and __devexit_p for pxa3xx
	nand
Message-ID: <4C0A1AD1.5090008@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is to use __devexit, __devinit  and __devexit_p for pxa3xx nand driver.

Signed-off-by: Wan ZongShun <mcuos.com@gmail.com>

---
 drivers/mtd/nand/pxa3xx_nand.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index e02fa4f..7ba1853 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -1206,7 +1206,7 @@ static void pxa3xx_nand_init_mtd(struct mtd_info *mtd,
 	this->chip_delay = 25;
 }

-static int pxa3xx_nand_probe(struct platform_device *pdev)
+static int __devinit pxa3xx_nand_probe(struct platform_device *pdev)
 {
 	struct pxa3xx_nand_platform_data *pdata;
 	struct pxa3xx_nand_info *info;
@@ -1354,7 +1354,7 @@ fail_free_mtd:
 	return ret;
 }

-static int pxa3xx_nand_remove(struct platform_device *pdev)
+static int __devexit pxa3xx_nand_remove(struct platform_device *pdev)
 {
 	struct mtd_info *mtd = platform_get_drvdata(pdev);
 	struct pxa3xx_nand_info *info = mtd->priv;
@@ -1419,7 +1419,7 @@ static struct platform_driver pxa3xx_nand_driver = {
 		.name	= "pxa3xx-nand",
 	},
 	.probe		= pxa3xx_nand_probe,
-	.remove		= pxa3xx_nand_remove,
+	.remove		= __devexit_p(pxa3xx_nand_remove),
 	.suspend	= pxa3xx_nand_suspend,
 	.resume		= pxa3xx_nand_resume,
 };
-- 
1.6.3.3
