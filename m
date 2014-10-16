From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 16 Oct 2014 11:00:57 +0200
Subject: [PATCH 05/11] dmaengine: k3: Remove chancnt affectations
In-Reply-To: <1413450063-23829-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1413450063-23829-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1413450063-23829-6-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

chanctnt is already filled by dma_async_device_register, which uses the channel
list to know how much channels there is.

Since it's already filled, we can safely remove it from the drivers' probe
function.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/dma/k3dma.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/dma/k3dma.c b/drivers/dma/k3dma.c
index a1f911aaf220..58219aa649fd 100644
--- a/drivers/dma/k3dma.c
+++ b/drivers/dma/k3dma.c
@@ -722,7 +722,6 @@ static int k3_dma_probe(struct platform_device *op)
 	d->slave.device_issue_pending = k3_dma_issue_pending;
 	d->slave.device_control = k3_dma_control;
 	d->slave.copy_align = DMA_ALIGN;
-	d->slave.chancnt = d->dma_requests;
 
 	/* init virtual channel */
 	d->chans = devm_kzalloc(&op->dev,
-- 
2.1.1
