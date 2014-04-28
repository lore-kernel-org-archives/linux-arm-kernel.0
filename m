From: joelf@ti.com (Joel Fernandes)
Date: Mon, 28 Apr 2014 15:48:48 -0500
Subject: [PATCH 2/2] dmaengine: edma: update DMA memcpy to use new param
 element
In-Reply-To: <1398718128-22647-1-git-send-email-joelf@ti.com>
References: <1398718128-22647-1-git-send-email-joelf@ti.com>
Message-ID: <1398718128-22647-2-git-send-email-joelf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

edma param struct is now within an edma_pset struct introduced in Thomas
Gleixner's edma tx status series. Update memcpy function for the same.

Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Joel Fernandes <joelf@ti.com>
---
 drivers/dma/edma.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index 8926078..ec9c410 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -582,8 +582,8 @@ struct dma_async_tx_descriptor *edma_prep_dma_memcpy(
 	 * on completion of every TR, and enable transfer-completion
 	 * interrupt on completion of the whole transfer.
 	 */
-	edesc->pset[0].opt |= ITCCHEN;
-	edesc->pset[0].opt |= TCINTEN;
+	edesc->pset[0].param.opt |= ITCCHEN;
+	edesc->pset[0].param.opt |= TCINTEN;
 
 	return vchan_tx_prep(&echan->vchan, &edesc->vdesc, tx_flags);
 }
-- 
1.7.9.5
