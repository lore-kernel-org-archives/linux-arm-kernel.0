From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 29 Jun 2011 18:41:16 +0200
Subject: [PATCH] MTD: atmel_nand: fix wrong use of 0 as NULL
Message-ID: <1309365676-19210-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixing this error:
atmel_nand.c:718:20: warning: Using plain integer as NULL pointer

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/mtd/nand/atmel_nand.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mtd/nand/atmel_nand.c b/drivers/mtd/nand/atmel_nand.c
index b300705..bbdf062 100644
--- a/drivers/mtd/nand/atmel_nand.c
+++ b/drivers/mtd/nand/atmel_nand.c
@@ -593,7 +593,7 @@ static int __init atmel_nand_probe(struct platform_device *pdev)
 
 		dma_cap_zero(mask);
 		dma_cap_set(DMA_MEMCPY, mask);
-		host->dma_chan = dma_request_channel(mask, 0, NULL);
+		host->dma_chan = dma_request_channel(mask, NULL, NULL);
 		if (!host->dma_chan) {
 			dev_err(host->dev, "Failed to request DMA channel\n");
 			use_dma = 0;
-- 
1.7.3
