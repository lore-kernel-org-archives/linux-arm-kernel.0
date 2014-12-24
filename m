From: jay.xu@rock-chips.com (Jianqun Xu)
Date: Wed, 24 Dec 2014 17:37:02 +0800
Subject: [PATCH v2 3/3] ASoC: rockchip: i2s: fix maxburst of dma data to 4
In-Reply-To: <1419413822-11539-1-git-send-email-jay.xu@rock-chips.com>
References: <1419325709-15374-1-git-send-email-jay.xu@rock-chips.com>
 <1419413822-11539-1-git-send-email-jay.xu@rock-chips.com>
Message-ID: <1419413822-11539-4-git-send-email-jay.xu@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since RK3288 DMAC's burst length only support max to 4, here
set maxburst of playback and capture dma data to 4.

Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
---
changes since v1:
- new patch since v1

 sound/soc/rockchip/rockchip_i2s.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/rockchip_i2s.c
index 1cd7efc..59aeec4 100644
--- a/sound/soc/rockchip/rockchip_i2s.c
+++ b/sound/soc/rockchip/rockchip_i2s.c
@@ -458,11 +458,11 @@ static int rockchip_i2s_probe(struct platform_device *pdev)
 
 	i2s->playback_dma_data.addr = res->start + I2S_TXDR;
 	i2s->playback_dma_data.addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
-	i2s->playback_dma_data.maxburst = 16;
+	i2s->playback_dma_data.maxburst = 4;
 
 	i2s->capture_dma_data.addr = res->start + I2S_RXDR;
 	i2s->capture_dma_data.addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
-	i2s->capture_dma_data.maxburst = 16;
+	i2s->capture_dma_data.maxburst = 4;
 
 	i2s->dev = &pdev->dev;
 	dev_set_drvdata(&pdev->dev, i2s);
-- 
1.9.1
