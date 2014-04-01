From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Tue, 1 Apr 2014 16:06:15 +0300
Subject: [PATCH v2 14/14] dma: edma: Print the direction value as well when it
 is not supported
In-Reply-To: <1396357575-30585-1-git-send-email-peter.ujfalusi@ti.com>
References: <1396357575-30585-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1396357575-30585-15-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In case of not supported direction it is better to print the direction also.
It is unlikely, but in such an event it helps with the debugging.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/edma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index 2413237840f8..912bf0190f45 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -430,7 +430,7 @@ static struct dma_async_tx_descriptor *edma_prep_slave_sg(
 		dev_width = echan->cfg.dst_addr_width;
 		burst = echan->cfg.dst_maxburst;
 	} else {
-		dev_err(dev, "%s: bad direction?\n", __func__);
+		dev_err(dev, "%s: bad direction: %d\n", __func__, direction);
 		return NULL;
 	}
 
@@ -523,7 +523,7 @@ static struct dma_async_tx_descriptor *edma_prep_dma_cyclic(
 		dev_width = echan->cfg.dst_addr_width;
 		burst = echan->cfg.dst_maxburst;
 	} else {
-		dev_err(dev, "%s: bad direction?\n", __func__);
+		dev_err(dev, "%s: bad direction: %d\n", __func__, direction);
 		return NULL;
 	}
 
-- 
1.9.1
