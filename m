From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 16 Oct 2014 11:00:56 +0200
Subject: [PATCH 04/11] dmaengine: fsldma: Remove chancnt affectations
In-Reply-To: <1413450063-23829-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1413450063-23829-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1413450063-23829-5-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

chanctnt is already filled by dma_async_device_register, which uses the channel
list to know how much channels there is.

Since it's already filled, we can safely remove it from the drivers' probe
function.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/dma/fsldma.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index d5d6885ab341..75ae6405a5ee 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -1332,7 +1332,6 @@ static int fsl_dma_chan_probe(struct fsldma_device *fdev,
 
 	/* Add the channel to DMA device channel list */
 	list_add_tail(&chan->common.device_node, &fdev->common.channels);
-	fdev->common.chancnt++;
 
 	dev_info(fdev->dev, "#%d (%s), irq %d\n", chan->id, compatible,
 		 chan->irq != NO_IRQ ? chan->irq : fdev->irq);
-- 
2.1.1
