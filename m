From: mylene.josserand@free-electrons.com (=?UTF-8?q?Myl=C3=A8ne=20Josserand?=)
Date: Tue, 17 Jan 2017 15:02:21 +0100
Subject: [PATCH v2 01/10] ASoC: sun4i-i2s: Increase DMA max burst to 8
In-Reply-To: <20170117140230.23142-1-mylene.josserand@free-electrons.com>
References: <20170117140230.23142-1-mylene.josserand@free-electrons.com>
Message-ID: <20170117140230.23142-2-mylene.josserand@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As done previously for sun4i-codec, the DMA maxburst of 4
is not supported by every SoCs so the DMA controller engine
returns "unsupported value".

As a maxburst of 8 is supported by all variants, this patch
increases it to 8.

For more details, see commit from Chen-Yu Tsai:
commit 730e2dd0cbc7 ("ASoC: sun4i-codec: Increase DMA max burst to 8")

Signed-off-by: Myl?ne Josserand <mylene.josserand@free-electrons.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index f24d19526603..4237323ef594 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -694,10 +694,10 @@ static int sun4i_i2s_probe(struct platform_device *pdev)
 	}
 	
 	i2s->playback_dma_data.addr = res->start + SUN4I_I2S_FIFO_TX_REG;
-	i2s->playback_dma_data.maxburst = 4;
+	i2s->playback_dma_data.maxburst = 8;
 
 	i2s->capture_dma_data.addr = res->start + SUN4I_I2S_FIFO_RX_REG;
-	i2s->capture_dma_data.maxburst = 4;
+	i2s->capture_dma_data.maxburst = 8;
 
 	pm_runtime_enable(&pdev->dev);
 	if (!pm_runtime_enabled(&pdev->dev)) {
-- 
2.11.0
