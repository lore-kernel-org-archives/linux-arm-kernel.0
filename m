From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 16 Oct 2013 21:58:40 +0530
Subject: [PATCH 22/28] dmaengine: sh: use DMA_COMPLETE for dma completion
 status
In-Reply-To: <1381940926-25564-1-git-send-email-vinod.koul@intel.com>
References: <1381940926-25564-1-git-send-email-vinod.koul@intel.com>
Message-ID: <1381940926-25564-23-git-send-email-vinod.koul@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
CC: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---
 drivers/dma/sh/shdma-base.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/dma/sh/shdma-base.c b/drivers/dma/sh/shdma-base.c
index d94ab59..2e7b394 100644
--- a/drivers/dma/sh/shdma-base.c
+++ b/drivers/dma/sh/shdma-base.c
@@ -724,7 +724,7 @@ static enum dma_status shdma_tx_status(struct dma_chan *chan,
 	 * If we don't find cookie on the queue, it has been aborted and we have
 	 * to report error
 	 */
-	if (status != DMA_SUCCESS) {
+	if (status != DMA_COMPLETE) {
 		struct shdma_desc *sdesc;
 		status = DMA_ERROR;
 		list_for_each_entry(sdesc, &schan->ld_queue, node)
-- 
1.7.0.4
