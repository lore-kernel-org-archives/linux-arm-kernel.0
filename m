From: b32955@freescale.com (Huang Shijie)
Date: Fri, 18 Nov 2011 16:38:02 +0800
Subject: [PATCH] IMX/DMA : set the DMA direction in the sdma_control()
Message-ID: <1321605482-6616-1-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Set the right DMA direction in the sdma_control(), else
we will get the wrong log when enable the DYNAMIC_DEBUG.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 drivers/dma/imx-sdma.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index f993955..37b8f84 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -1102,6 +1102,7 @@ static int sdma_control(struct dma_chan *chan, enum dma_ctrl_cmd cmd,
 			sdmac->watermark_level = dmaengine_cfg->dst_maxburst;
 			sdmac->word_size = dmaengine_cfg->dst_addr_width;
 		}
+		sdmac->direction = dmaengine_cfg->direction;
 		return sdma_config_channel(sdmac);
 	default:
 		return -ENOSYS;
-- 
1.7.3.2
