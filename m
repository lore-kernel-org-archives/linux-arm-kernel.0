From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 16 Oct 2013 21:58:44 +0530
Subject: [PATCH 26/28] async_tx: use DMA_COMPLETE for dma completion status
In-Reply-To: <1381940926-25564-1-git-send-email-vinod.koul@intel.com>
References: <1381940926-25564-1-git-send-email-vinod.koul@intel.com>
Message-ID: <1381940926-25564-27-git-send-email-vinod.koul@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 crypto/async_tx/async_tx.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/crypto/async_tx/async_tx.c b/crypto/async_tx/async_tx.c
index 7be3424..39ea479 100644
--- a/crypto/async_tx/async_tx.c
+++ b/crypto/async_tx/async_tx.c
@@ -128,7 +128,7 @@ async_tx_channel_switch(struct dma_async_tx_descriptor *depend_tx,
 		}
 		device->device_issue_pending(chan);
 	} else {
-		if (dma_wait_for_async_tx(depend_tx) != DMA_SUCCESS)
+		if (dma_wait_for_async_tx(depend_tx) != DMA_COMPLETE)
 			panic("%s: DMA error waiting for depend_tx\n",
 			      __func__);
 		tx->tx_submit(tx);
@@ -280,7 +280,7 @@ void async_tx_quiesce(struct dma_async_tx_descriptor **tx)
 		 * we are referring to the correct operation
 		 */
 		BUG_ON(async_tx_test_ack(*tx));
-		if (dma_wait_for_async_tx(*tx) != DMA_SUCCESS)
+		if (dma_wait_for_async_tx(*tx) != DMA_COMPLETE)
 			panic("%s: DMA error waiting for transaction\n",
 			      __func__);
 		async_tx_ack(*tx);
-- 
1.7.0.4
