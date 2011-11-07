From: zonque@gmail.com (Daniel Mack)
Date: Mon,  7 Nov 2011 16:43:29 +0100
Subject: [PATCH 2/4] mtd: pxa3xx_nand: remove unused variable 'mtd'
In-Reply-To: <1320680611-29448-1-git-send-email-zonque@gmail.com>
References: <1320680611-29448-1-git-send-email-zonque@gmail.com>
Message-ID: <1320680611-29448-3-git-send-email-zonque@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Axel Lin <axel.lin@gmail.com>

Remove unused variable 'mtd' to eliminate below warning.

  CC      drivers/mtd/nand/pxa3xx_nand.o
drivers/mtd/nand/pxa3xx_nand.c: In function 'pxa3xx_nand_suspend':
drivers/mtd/nand/pxa3xx_nand.c:1167: warning: unused variable 'mtd'
drivers/mtd/nand/pxa3xx_nand.c: In function 'pxa3xx_nand_resume':
drivers/mtd/nand/pxa3xx_nand.c:1180: warning: unused variable 'mtd'

Signed-off-by: Axel Lin <axel.lin@gmail.com>
Signed-off-by: Artem Bityutskiy <Artem.Bityutskiy@nokia.com>
---
 drivers/mtd/nand/pxa3xx_nand.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index f7040ea..e11f926 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -1164,7 +1164,6 @@ static int pxa3xx_nand_probe(struct platform_device *pdev)
 static int pxa3xx_nand_suspend(struct platform_device *pdev, pm_message_t state)
 {
 	struct pxa3xx_nand_info *info = platform_get_drvdata(pdev);
-	struct mtd_info *mtd = info->mtd;
 
 	if (info->state) {
 		dev_err(&pdev->dev, "driver busy, state = %d\n", info->state);
@@ -1177,7 +1176,6 @@ static int pxa3xx_nand_suspend(struct platform_device *pdev, pm_message_t state)
 static int pxa3xx_nand_resume(struct platform_device *pdev)
 {
 	struct pxa3xx_nand_info *info = platform_get_drvdata(pdev);
-	struct mtd_info *mtd = info->mtd;
 
 	nand_writel(info, NDTR0CS0, info->ndtr0cs0);
 	nand_writel(info, NDTR1CS0, info->ndtr1cs0);
-- 
1.7.6.4
