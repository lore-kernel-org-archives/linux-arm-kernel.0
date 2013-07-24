From: rizhao@nvidia.com (Richard Zhao)
Date: Wed, 24 Jul 2013 12:10:02 +0800
Subject: [PATCH 9/9] dma: tegra20-apbdma: remove legacy nvidia,
 dma-request-selector support
In-Reply-To: <1374639002-16753-1-git-send-email-rizhao@nvidia.com>
References: <1374639002-16753-1-git-send-email-rizhao@nvidia.com>
Message-ID: <1374639002-16753-10-git-send-email-rizhao@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All tegra dma client drivers have moved to generic dma binding.

Signed-off-by: Richard Zhao <rizhao@nvidia.com>
---
 drivers/dma/tegra20-apb-dma.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
index 0e12f78..a67d159 100644
--- a/drivers/dma/tegra20-apb-dma.c
+++ b/drivers/dma/tegra20-apb-dma.c
@@ -344,13 +344,6 @@ static int tegra_dma_slave_config(struct dma_chan *dc,
 
 	memcpy(&tdc->dma_sconfig, sconfig, sizeof(*sconfig));
 
-	/* If we didn't get slave_id from DT when request channel, use the one
-	 * passed here.
-	 * It makes compatible with legacy nvidia,dma-request-selector.
-	 */
-	if (tdc->slave_id == -EINVAL)
-		tdc->slave_id = sconfig->slave_id;
-
 	tdc->config_init = true;
 	return 0;
 }
@@ -1374,7 +1367,6 @@ static int tegra_dma_probe(struct platform_device *pdev)
 				&tdma->dma_dev.channels);
 		tdc->tdma = tdma;
 		tdc->id = i;
-		tdc->slave_id = -EINVAL;
 
 		tasklet_init(&tdc->tasklet, tegra_dma_tasklet,
 				(unsigned long)tdc);
-- 
1.8.1.5
