From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 16 Oct 2013 21:58:23 +0530
Subject: [PATCH 05/28] dmaengine: cppi41: use DMA_COMPLETE for dma completion
 status
In-Reply-To: <1381940926-25564-1-git-send-email-vinod.koul@intel.com>
References: <1381940926-25564-1-git-send-email-vinod.koul@intel.com>
Message-ID: <1381940926-25564-6-git-send-email-vinod.koul@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
CC: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/dma/cppi41.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/dma/cppi41.c b/drivers/dma/cppi41.c
index 167c022..278b305 100644
--- a/drivers/dma/cppi41.c
+++ b/drivers/dma/cppi41.c
@@ -353,7 +353,7 @@ static enum dma_status cppi41_dma_tx_status(struct dma_chan *chan,
 
 	/* lock */
 	ret = dma_cookie_status(chan, cookie, txstate);
-	if (txstate && ret == DMA_SUCCESS)
+	if (txstate && ret == DMA_COMPLETE)
 		txstate->residue = c->residue;
 	/* unlock */
 
-- 
1.7.0.4
