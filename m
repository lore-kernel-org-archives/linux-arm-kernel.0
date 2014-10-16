From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 16 Oct 2014 12:17:01 +0200
Subject: [PATCH v2 02/53] dmaengine: Make channel allocation callbacks optional
In-Reply-To: <1413454672-27400-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1413454672-27400-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1413454672-27400-3-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nowadays, some drivers don't have anything in there channel allocation
callbacks anymore.

Remove the BUG_ON if those callbacks aren't implemented, in order to allow
drivers to not implement them.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/dma/dmaengine.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index d5d30ed863ce..cfcb181b1184 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -817,8 +817,6 @@ int dma_async_device_register(struct dma_device *device)
 	BUG_ON(dma_has_cap(DMA_INTERLEAVE, device->cap_mask) &&
 		!device->device_prep_interleaved_dma);
 
-	BUG_ON(!device->device_alloc_chan_resources);
-	BUG_ON(!device->device_free_chan_resources);
 	BUG_ON(!device->device_tx_status);
 	BUG_ON(!device->device_issue_pending);
 	BUG_ON(!device->dev);
-- 
2.1.1
