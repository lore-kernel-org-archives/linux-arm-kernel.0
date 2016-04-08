From: zajec5@gmail.com (=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?=)
Date: Fri,  8 Apr 2016 12:23:47 +0200
Subject: [PATCH 4/8] mtd: nand: nuc900: set ECC algorithm explicitly
In-Reply-To: <1460111031-8706-1-git-send-email-zajec5@gmail.com>
References: <1460111031-8706-1-git-send-email-zajec5@gmail.com>
Message-ID: <1460111031-8706-5-git-send-email-zajec5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is part of process deprecating NAND_ECC_SOFT_BCH (and switching to
enum nand_ecc_algo).

Signed-off-by: Rafa? Mi?ecki <zajec5@gmail.com>
---
 drivers/mtd/nand/nuc900_nand.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/nand/nuc900_nand.c b/drivers/mtd/nand/nuc900_nand.c
index dbc5b57..8f64011 100644
--- a/drivers/mtd/nand/nuc900_nand.c
+++ b/drivers/mtd/nand/nuc900_nand.c
@@ -261,6 +261,7 @@ static int nuc900_nand_probe(struct platform_device *pdev)
 	chip->chip_delay	= 50;
 	chip->options		= 0;
 	chip->ecc.mode		= NAND_ECC_SOFT;
+	chip->ecc.algo		= NAND_ECC_HAMMING;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	nuc900_nand->reg = devm_ioremap_resource(&pdev->dev, res);
-- 
1.8.4.5
