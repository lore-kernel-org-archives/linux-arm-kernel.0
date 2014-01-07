From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Tue, 7 Jan 2014 21:38:32 +0800
Subject: [PATCH -next] mtd: nuc900_nand: remove redundant return value check
 of platform_get_resource()
Message-ID: <CAPgLHd_RMOPLP2f4nA1vqNNddocMUX7f-gE29TTkuJZPUm=SWw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Remove unneeded error handling on the result of a call
to platform_get_resource() when the value is passed to
devm_ioremap_resource().

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/mtd/nand/nuc900_nand.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/mtd/nand/nuc900_nand.c b/drivers/mtd/nand/nuc900_nand.c
index 661fd14..9ee09a8 100644
--- a/drivers/mtd/nand/nuc900_nand.c
+++ b/drivers/mtd/nand/nuc900_nand.c
@@ -268,9 +268,6 @@ static int nuc900_nand_probe(struct platform_device *pdev)
 	chip->ecc.mode		= NAND_ECC_SOFT;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -ENXIO;
-
 	nuc900_nand->reg = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(nuc900_nand->reg))
 		return PTR_ERR(nuc900_nand->reg);
