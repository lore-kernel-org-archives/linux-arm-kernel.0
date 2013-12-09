From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Mon,  9 Dec 2013 18:36:26 -0300
Subject: [PATCH] Partially revert "mtd: nand: pxa3xx: Introduce 'marvell,
 armada370-nand' compatible string"
Message-ID: <1386624986-404-1-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This reverts c0f3b8643a6fa2461d70760ec49d21d2b031d611.

The "armada370-nand" compatible support is not complete, and it was mistake
to add it. Revert it and pospone the support until the infrastructure is
in place.

Cc: stable at vger.kernel.org
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
Note this won't apply to v3.12 as it is, although fixing it should be easy.

 drivers/mtd/nand/pxa3xx_nand.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index 3d143fe..ebcf693 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -333,10 +333,6 @@ static struct of_device_id pxa3xx_nand_dt_ids[] = {
 		.compatible = "marvell,pxa3xx-nand",
 		.data       = (void *)PXA3XX_NAND_VARIANT_PXA,
 	},
-	{
-		.compatible = "marvell,armada370-nand",
-		.data       = (void *)PXA3XX_NAND_VARIANT_ARMADA370,
-	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, pxa3xx_nand_dt_ids);
-- 
1.8.1.5
