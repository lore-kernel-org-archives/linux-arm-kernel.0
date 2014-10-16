From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 16 Oct 2014 11:00:54 +0200
Subject: [PATCH 02/11] dmaengine: bcm2835: Remove chancnt affectations
In-Reply-To: <1413450063-23829-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1413450063-23829-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1413450063-23829-3-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

chanctnt is already filled by dma_async_device_register, which uses the channel
list to know how much channels there is.

Since it's already filled, we can safely remove it from the drivers' probe
function.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/dma/bcm2835-dma.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
index 68007974961a..def66fbbb7f3 100644
--- a/drivers/dma/bcm2835-dma.c
+++ b/drivers/dma/bcm2835-dma.c
@@ -525,8 +525,6 @@ static int bcm2835_dma_chan_init(struct bcm2835_dmadev *d, int chan_id, int irq)
 	vchan_init(&c->vc, &d->ddev);
 	INIT_LIST_HEAD(&c->node);
 
-	d->ddev.chancnt++;
-
 	c->chan_base = BCM2835_DMA_CHANIO(d->base, chan_id);
 	c->ch = chan_id;
 	c->irq_number = irq;
-- 
2.1.1
