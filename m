From: zonque@gmail.com (Daniel Mack)
Date: Wed, 21 Aug 2013 14:08:58 +0200
Subject: [PATCH v5 5/5] dma: mmp_pdma: set DMA_PRIVATE
In-Reply-To: <1377086938-29145-1-git-send-email-zonque@gmail.com>
References: <1377086938-29145-1-git-send-email-zonque@gmail.com>
Message-ID: <1377086938-29145-6-git-send-email-zonque@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the driver now has its own xlate function and makes use of the
dma_get_slave_channel(), we need to manually set the DMA_PRIVATE flags.

Drivers which rely on of_dma_simple_xlate() do implicitly the same by
going through __dma_request_channel().

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 drivers/dma/mmp_pdma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/mmp_pdma.c b/drivers/dma/mmp_pdma.c
index efb583f..3efde2d 100644
--- a/drivers/dma/mmp_pdma.c
+++ b/drivers/dma/mmp_pdma.c
@@ -1068,6 +1068,7 @@ static int mmp_pdma_probe(struct platform_device *op)
 	dma_cap_set(DMA_SLAVE, pdev->device.cap_mask);
 	dma_cap_set(DMA_MEMCPY, pdev->device.cap_mask);
 	dma_cap_set(DMA_CYCLIC, pdev->device.cap_mask);
+	dma_cap_set(DMA_PRIVATE, pdev->device.cap_mask);
 	pdev->device.dev = &op->dev;
 	pdev->device.device_alloc_chan_resources = mmp_pdma_alloc_chan_resources;
 	pdev->device.device_free_chan_resources = mmp_pdma_free_chan_resources;
-- 
1.8.3.1
