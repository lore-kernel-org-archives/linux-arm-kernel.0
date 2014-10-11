From: vinod.koul@intel.com (Vinod Koul)
Date: Sat, 11 Oct 2014 21:10:30 +0530
Subject: [PATCH 02/12] dmaengine: coh901318: use dmaengine_terminate_all() API
In-Reply-To: <1413041973-28146-1-git-send-email-vinod.koul@intel.com>
References: <1413041973-28146-1-git-send-email-vinod.koul@intel.com>
Message-ID: <1413042040-28222-2-git-send-email-vinod.koul@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The drivers should use dmaengine_terminate_all() API instead of accessing
the device_control which will be deprecated soon

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 drivers/dma/coh901318.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/dma/coh901318.c b/drivers/dma/coh901318.c
index 3c6716e..e88588d 100644
--- a/drivers/dma/coh901318.c
+++ b/drivers/dma/coh901318.c
@@ -2156,7 +2156,7 @@ coh901318_free_chan_resources(struct dma_chan *chan)
 
 	spin_unlock_irqrestore(&cohc->lock, flags);
 
-	chan->device->device_control(chan, DMA_TERMINATE_ALL, 0);
+	dmaengine_terminate_all(chan);
 }
 
 
-- 
1.7.0.4
