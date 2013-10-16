From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 16 Oct 2013 21:58:30 +0530
Subject: [PATCH 12/28] dmaengine: intel_mid_dma: use DMA_COMPLETE for dma
 completion status
In-Reply-To: <1381940926-25564-1-git-send-email-vinod.koul@intel.com>
References: <1381940926-25564-1-git-send-email-vinod.koul@intel.com>
Message-ID: <1381940926-25564-13-git-send-email-vinod.koul@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 drivers/dma/intel_mid_dma.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/intel_mid_dma.c b/drivers/dma/intel_mid_dma.c
index a975ebe..1aab813 100644
--- a/drivers/dma/intel_mid_dma.c
+++ b/drivers/dma/intel_mid_dma.c
@@ -309,7 +309,7 @@ static void midc_descriptor_complete(struct intel_mid_dma_chan *midc,
 		callback_txd(param_txd);
 	}
 	if (midc->raw_tfr) {
-		desc->status = DMA_SUCCESS;
+		desc->status = DMA_COMPLETE;
 		if (desc->lli != NULL) {
 			pci_pool_free(desc->lli_pool, desc->lli,
 						desc->lli_phys);
@@ -481,7 +481,7 @@ static enum dma_status intel_mid_dma_tx_status(struct dma_chan *chan,
 	enum dma_status ret;
 
 	ret = dma_cookie_status(chan, cookie, txstate);
-	if (ret != DMA_SUCCESS) {
+	if (ret != DMA_COMPLETE) {
 		spin_lock_bh(&midc->lock);
 		midc_scan_descriptors(to_middma_device(chan->device), midc);
 		spin_unlock_bh(&midc->lock);
-- 
1.7.0.4
