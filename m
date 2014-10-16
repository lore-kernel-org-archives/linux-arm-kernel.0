From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 16 Oct 2014 11:00:59 +0200
Subject: [PATCH 07/11] dmaengine: omap: Remove chancnt affectations
In-Reply-To: <1413450063-23829-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1413450063-23829-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1413450063-23829-8-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

chanctnt is already filled by dma_async_device_register, which uses the channel
list to know how much channels there is.

Since it's already filled, we can safely remove it from the drivers' probe
function.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/dma/omap-dma.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
index 4cf7d9a950d7..b1e8c7317c0c 100644
--- a/drivers/dma/omap-dma.c
+++ b/drivers/dma/omap-dma.c
@@ -1069,8 +1069,6 @@ static int omap_dma_chan_init(struct omap_dmadev *od, int dma_sig)
 	vchan_init(&c->vc, &od->ddev);
 	INIT_LIST_HEAD(&c->node);
 
-	od->ddev.chancnt++;
-
 	return 0;
 }
 
-- 
2.1.1
