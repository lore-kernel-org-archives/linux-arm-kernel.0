From: peter.griffin@linaro.org (Peter Griffin)
Date: Tue,  7 Jun 2016 18:38:39 +0100
Subject: [PATCH 6/8] dmaengine: sun6i-dma: Only calculate residue if state
 exists.
In-Reply-To: <1465321121-22238-1-git-send-email-peter.griffin@linaro.org>
References: <1465321121-22238-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1465321121-22238-7-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no point in calculating the residue if state does not
exist to store the value.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 drivers/dma/sun6i-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
index 5065ca4..3835fcd 100644
--- a/drivers/dma/sun6i-dma.c
+++ b/drivers/dma/sun6i-dma.c
@@ -865,7 +865,7 @@ static enum dma_status sun6i_dma_tx_status(struct dma_chan *chan,
 	size_t bytes = 0;
 
 	ret = dma_cookie_status(chan, cookie, state);
-	if (ret == DMA_COMPLETE)
+	if (ret == DMA_COMPLETE || !state)
 		return ret;
 
 	spin_lock_irqsave(&vchan->vc.lock, flags);
-- 
1.9.1
