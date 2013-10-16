From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 16 Oct 2013 21:58:20 +0530
Subject: [PATCH 02/28] dmaengine: amba-pl08x: use DMA_COMPLETE for dma
 completion status
In-Reply-To: <1381940926-25564-1-git-send-email-vinod.koul@intel.com>
References: <1381940926-25564-1-git-send-email-vinod.koul@intel.com>
Message-ID: <1381940926-25564-3-git-send-email-vinod.koul@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
CC: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/dma/amba-pl08x.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 9b50257..4ee6533 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -1252,7 +1252,7 @@ static enum dma_status pl08x_dma_tx_status(struct dma_chan *chan,
 	size_t bytes = 0;
 
 	ret = dma_cookie_status(chan, cookie, txstate);
-	if (ret == DMA_SUCCESS)
+	if (ret == DMA_COMPLETE)
 		return ret;
 
 	/*
@@ -1267,7 +1267,7 @@ static enum dma_status pl08x_dma_tx_status(struct dma_chan *chan,
 
 	spin_lock_irqsave(&plchan->vc.lock, flags);
 	ret = dma_cookie_status(chan, cookie, txstate);
-	if (ret != DMA_SUCCESS) {
+	if (ret != DMA_COMPLETE) {
 		vd = vchan_find_desc(&plchan->vc, cookie);
 		if (vd) {
 			/* On the issued list, so hasn't been processed yet */
-- 
1.7.0.4
