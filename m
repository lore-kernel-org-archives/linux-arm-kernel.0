From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 10 Sep 2015 11:37:42 +0300
Subject: [PATCH 13/21] dmaengine: edma: Use devm_kcalloc when possible
In-Reply-To: <1441874270-2399-1-git-send-email-peter.ujfalusi@ti.com>
References: <1441874270-2399-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1441874270-2399-14-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When allocating a memory for number of items it is better (looks better)
to use devm_kcalloc.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/edma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index bed09ce22ff2..0b46d4263ec6 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -2034,7 +2034,7 @@ static int edma_setup_from_hw(struct device *dev, struct edma_soc_info *pdata,
 	 * priority. So Q0 is the highest priority queue and the last queue has
 	 * the lowest priority.
 	 */
-	queue_priority_map = devm_kzalloc(dev, (ecc->num_tc + 1) * sizeof(s8),
+	queue_priority_map = devm_kcalloc(dev, ecc->num_tc + 1, sizeof(s8),
 					  GFP_KERNEL);
 	if (!queue_priority_map)
 		return -ENOMEM;
@@ -2065,7 +2065,7 @@ static int edma_xbar_event_map(struct device *dev, struct edma_soc_info *pdata,
 	u32 shift, offset, mux;
 	int ret, i;
 
-	xbar_chans = devm_kzalloc(dev, (nelm + 2) * sizeof(s16), GFP_KERNEL);
+	xbar_chans = devm_kcalloc(dev, nelm + 2, sizeof(s16), GFP_KERNEL);
 	if (!xbar_chans)
 		return -ENOMEM;
 
-- 
2.5.1
