From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 20 Jan 2011 05:50:35 +0800
Subject: [PATCH 1/6] dmaengine: imx-sdma: remove IMX_DMA_SG_LOOP handling in
	sdma_prep_slave_sg()
In-Reply-To: <1295473840-17295-1-git-send-email-shawn.guo@freescale.com>
References: <1295473840-17295-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <1295473840-17295-2-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a leftover from the time that the driver did not have
sdma_prep_dma_cyclic callback and implemented sound dma as a looped
sg chain.  And it can be removed now.

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
 drivers/dma/imx-sdma.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 5456480..45413b7 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -931,12 +931,6 @@ static struct dma_async_tx_descriptor *sdma_prep_slave_sg(
 
 		param = BD_DONE | BD_EXTD | BD_CONT;
 
-		if (sdmac->flags & IMX_DMA_SG_LOOP) {
-			param |= BD_INTR;
-			if (i + 1 == sg_len)
-				param |= BD_WRAP;
-		}
-
 		if (i + 1 == sg_len)
 			param |= BD_INTR;
 
-- 
1.7.1
