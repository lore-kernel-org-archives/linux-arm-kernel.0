From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Fri, 25 Sep 2009 19:10:44 -0400
Subject: [PATCH] [MTD] [NAND] pxa3xx_nand: adjust timing on micron flash
Message-ID: <mailman.37.1253892295.2253.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Slow down the tRp of micron flash timing.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 drivers/mtd/nand/pxa3xx_nand.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index d6c9524..2014f4f 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -264,7 +264,7 @@ static struct pxa3xx_nand_timing micron_timing = {
 	.tWH	= 15,
 	.tWP	= 25,
 	.tRH	= 15,
-	.tRP	= 25,
+	.tRP	= 30,
 	.tR	= 25000,
 	.tWHR	= 60,
 	.tAR	= 10,
-- 
1.5.6.5
