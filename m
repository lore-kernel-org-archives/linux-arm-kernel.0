From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 16 Oct 2013 21:58:42 +0530
Subject: [PATCH 24/28] dmaengine: tegra: use DMA_COMPLETE for dma completion
 status
In-Reply-To: <1381940926-25564-1-git-send-email-vinod.koul@intel.com>
References: <1381940926-25564-1-git-send-email-vinod.koul@intel.com>
Message-ID: <1381940926-25564-25-git-send-email-vinod.koul@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
CC: Stephen Warren <swarren@wwwdotorg.org>
---
 drivers/dma/tegra20-apb-dma.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
index 67a6752..73654e3 100644
--- a/drivers/dma/tegra20-apb-dma.c
+++ b/drivers/dma/tegra20-apb-dma.c
@@ -570,7 +570,7 @@ static void handle_once_dma_done(struct tegra_dma_channel *tdc,
 
 	list_del(&sgreq->node);
 	if (sgreq->last_sg) {
-		dma_desc->dma_status = DMA_SUCCESS;
+		dma_desc->dma_status = DMA_COMPLETE;
 		dma_cookie_complete(&dma_desc->txd);
 		if (!dma_desc->cb_count)
 			list_add_tail(&dma_desc->cb_node, &tdc->cb_desc);
@@ -768,7 +768,7 @@ static enum dma_status tegra_dma_tx_status(struct dma_chan *dc,
 	unsigned int residual;
 
 	ret = dma_cookie_status(dc, cookie, txstate);
-	if (ret == DMA_SUCCESS)
+	if (ret == DMA_COMPLETE)
 		return ret;
 
 	spin_lock_irqsave(&tdc->lock, flags);
-- 
1.7.0.4
