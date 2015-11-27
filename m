From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Fri, 27 Nov 2015 10:29:37 +0200
Subject: [RFC 1/6] dmaengine: core: Allow NULL mask pointer in
 __dma_device_satisfies_mask()
In-Reply-To: <1448612982-28141-1-git-send-email-peter.ujfalusi@ti.com>
References: <1448612982-28141-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1448612982-28141-2-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Treat as true condition the case when the mask is NULL.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/dmaengine.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index daf54a39bcc7..52c3eee48e2e 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -184,6 +184,9 @@ __dma_device_satisfies_mask(struct dma_device *device,
 {
 	dma_cap_mask_t has;
 
+	if (!want)
+		return true;
+
 	bitmap_and(has.bits, want->bits, device->cap_mask.bits,
 		DMA_TX_TYPE_END);
 	return bitmap_equal(want->bits, has.bits, DMA_TX_TYPE_END);
-- 
2.6.3
