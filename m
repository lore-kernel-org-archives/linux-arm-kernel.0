From: joelf@ti.com (Joel Fernandes)
Date: Mon, 5 Aug 2013 11:14:48 -0500
Subject: [PATCH v3 03/12] dma: edma: remove limits on number of slots
In-Reply-To: <1375719297-12871-1-git-send-email-joelf@ti.com>
References: <1375719297-12871-1-git-send-email-joelf@ti.com>
Message-ID: <1375719297-12871-4-git-send-email-joelf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With this series, this check is no longer required and
we shouldn't need to reject drivers DMA'ing more than the
MAX number of slots.

Signed-off-by: Joel Fernandes <joelf@ti.com>
---
 drivers/dma/edma.c |    6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index 7b0853c..b6d609c 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -247,12 +247,6 @@ static struct dma_async_tx_descriptor *edma_prep_slave_sg(
 		return NULL;
 	}
 
-	if (sg_len > MAX_NR_SG) {
-		dev_err(dev, "Exceeded max SG segments %d > %d\n",
-			sg_len, MAX_NR_SG);
-		return NULL;
-	}
-
 	edesc = kzalloc(sizeof(*edesc) + sg_len *
 		sizeof(edesc->pset[0]), GFP_ATOMIC);
 	if (!edesc) {
-- 
1.7.9.5
