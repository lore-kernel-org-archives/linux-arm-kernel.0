From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 14 Jul 2016 15:42:40 +0300
Subject: [PATCH 5/7] dmaengine: omap-dma: Add more debug information when
 freeing channel
In-Reply-To: <20160714124242.7579-1-peter.ujfalusi@ti.com>
References: <20160714124242.7579-1-peter.ujfalusi@ti.com>
Message-ID: <20160714124242.7579-6-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Print the same information the driver prints when allocating the channel
resources regarding to the sDMA channel.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/omap-dma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
index c026642fc66a..bbad82985083 100644
--- a/drivers/dma/omap-dma.c
+++ b/drivers/dma/omap-dma.c
@@ -568,7 +568,8 @@ static void omap_dma_free_chan_resources(struct dma_chan *chan)
 	vchan_free_chan_resources(&c->vc);
 	omap_free_dma(c->dma_ch);
 
-	dev_dbg(od->ddev.dev, "freeing channel for %u\n", c->dma_sig);
+	dev_dbg(od->ddev.dev, "freeing channel %u used for %u\n", c->dma_ch,
+		c->dma_sig);
 	c->dma_sig = 0;
 }
 
-- 
2.9.1
