From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Wed, 20 Jul 2016 11:50:30 +0300
Subject: [PATCH v2 4/6] dmaengine: omap-dma: Add more debug information when
 freeing channel
In-Reply-To: <20160720085032.2955-1-peter.ujfalusi@ti.com>
References: <20160720085032.2955-1-peter.ujfalusi@ti.com>
Message-ID: <20160720085032.2955-5-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Print the same information the driver prints when allocating the channel
resources regarding to the sDMA channel.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/omap-dma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
index 6a97350ea76d..072fff7164dd 100644
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
2.9.2
