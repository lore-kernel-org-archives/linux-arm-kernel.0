From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Fri, 16 Oct 2015 10:18:06 +0300
Subject: [PATCH v2 08/14] dmaengine: edma: Do not allocate memory for
 edma_rsv_info in case of DT boot
In-Reply-To: <1444979892-31626-1-git-send-email-peter.ujfalusi@ti.com>
References: <1444979892-31626-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1444979892-31626-9-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The channel/slot reservation is not supported when booted with DT so there
is not need to allocate memory.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/edma.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index e1b0e6864f27..c1b8bb09c221 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -1926,12 +1926,6 @@ static int edma_of_parse_dt(struct device *dev, struct edma_soc_info *pdata)
 	int ret = 0;
 	struct property *prop;
 	size_t sz;
-	struct edma_rsv_info *rsv_info;
-
-	rsv_info = devm_kzalloc(dev, sizeof(struct edma_rsv_info), GFP_KERNEL);
-	if (!rsv_info)
-		return -ENOMEM;
-	pdata->rsv = rsv_info;
 
 	prop = of_find_property(dev->of_node, "ti,edma-xbar-event-map", &sz);
 	if (prop)
-- 
2.6.1
