From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 1 Jan 2011 23:00:23 +0000
Subject: [PATCH] Fix dmaengine_submit() return type
Message-ID: <20110101230023.GE25924@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

desc->tx_submit's return type is dma_cookie_t, not int.  Therefore,
dmaengine_submit() should match this return type as it's just
wrapping this detail.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 include/linux/dmaengine.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 9d8688b..830935b 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -532,7 +532,7 @@ static inline int dmaengine_resume(struct dma_chan *chan)
 	return dmaengine_device_control(chan, DMA_RESUME, 0);
 }
 
-static inline int dmaengine_submit(struct dma_async_tx_descriptor *desc)
+static inline dma_cookie_t dmaengine_submit(struct dma_async_tx_descriptor *desc)
 {
 	return desc->tx_submit(desc);
 }
