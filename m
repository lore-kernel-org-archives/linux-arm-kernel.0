From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 16 Oct 2013 21:58:33 +0530
Subject: [PATCH 15/28] dmaengine: k3dma: use DMA_COMPLETE for dma completion
 status
In-Reply-To: <1381940926-25564-1-git-send-email-vinod.koul@intel.com>
References: <1381940926-25564-1-git-send-email-vinod.koul@intel.com>
Message-ID: <1381940926-25564-16-git-send-email-vinod.koul@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
CC: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 drivers/dma/k3dma.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/dma/k3dma.c b/drivers/dma/k3dma.c
index da43062..e260754 100644
--- a/drivers/dma/k3dma.c
+++ b/drivers/dma/k3dma.c
@@ -344,7 +344,7 @@ static enum dma_status k3_dma_tx_status(struct dma_chan *chan,
 	size_t bytes = 0;
 
 	ret = dma_cookie_status(&c->vc.chan, cookie, state);
-	if (ret == DMA_SUCCESS)
+	if (ret == DMA_COMPLETE)
 		return ret;
 
 	spin_lock_irqsave(&c->vc.lock, flags);
-- 
1.7.0.4
