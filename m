From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 26 May 2011 14:31:32 +0800
Subject: [PATCH 2/3] dmaengine: mxs-dma: set up max_segment_number
In-Reply-To: <1306391493-29425-1-git-send-email-shawn.guo@linaro.org>
References: <1306391493-29425-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1306391493-29425-2-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It calls dmaengine API dma_set_max_seg_number to set
device_dma_parameters max_segment_number.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/dma/mxs-dma.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/dma/mxs-dma.c b/drivers/dma/mxs-dma.c
index 88aad4f..875d8f6 100644
--- a/drivers/dma/mxs-dma.c
+++ b/drivers/dma/mxs-dma.c
@@ -670,6 +670,7 @@ static int __init mxs_dma_probe(struct platform_device *pdev)
 	/* mxs_dma gets 65535 bytes maximum sg size */
 	mxs_dma->dma_device.dev->dma_parms = &mxs_dma->dma_parms;
 	dma_set_max_seg_size(mxs_dma->dma_device.dev, MAX_XFER_BYTES);
+	dma_set_max_seg_number(mxs_dma->dma_device.dev, NUM_CCW);
 
 	mxs_dma->dma_device.device_alloc_chan_resources = mxs_dma_alloc_chan_resources;
 	mxs_dma->dma_device.device_free_chan_resources = mxs_dma_free_chan_resources;
-- 
1.7.4.1
