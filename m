From: zonque@gmail.com (Daniel Mack)
Date: Wed,  7 Aug 2013 12:19:26 +0200
Subject: [PATCH 08/12] dma: mmp_pdma: remove duplicate assignment
In-Reply-To: <1375870770-14263-1-git-send-email-zonque@gmail.com>
References: <1375870770-14263-1-git-send-email-zonque@gmail.com>
Message-ID: <1375870770-14263-9-git-send-email-zonque@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DMA_SLAVE is currently set twice.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 drivers/dma/mmp_pdma.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/dma/mmp_pdma.c b/drivers/dma/mmp_pdma.c
index 2d48f31..1c2c00b 100644
--- a/drivers/dma/mmp_pdma.c
+++ b/drivers/dma/mmp_pdma.c
@@ -852,7 +852,6 @@ static int mmp_pdma_probe(struct platform_device *op)
 
 	dma_cap_set(DMA_SLAVE, pdev->device.cap_mask);
 	dma_cap_set(DMA_MEMCPY, pdev->device.cap_mask);
-	dma_cap_set(DMA_SLAVE, pdev->device.cap_mask);
 	pdev->device.dev = &op->dev;
 	pdev->device.device_alloc_chan_resources = mmp_pdma_alloc_chan_resources;
 	pdev->device.device_free_chan_resources = mmp_pdma_free_chan_resources;
-- 
1.8.3.1
