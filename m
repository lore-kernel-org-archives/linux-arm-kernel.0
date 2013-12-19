From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 19 Dec 2013 15:55:06 +0000
Subject: [PATCH 09/11] ASoC: ux500_pcm: Take out pointless dev_dbg() call
In-Reply-To: <1387468508-12286-1-git-send-email-lee.jones@linaro.org>
References: <1387468508-12286-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1387468508-12286-10-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 sound/soc/ux500/ux500_pcm.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/sound/soc/ux500/ux500_pcm.c b/sound/soc/ux500/ux500_pcm.c
index 8b53f22..3d1c342 100644
--- a/sound/soc/ux500/ux500_pcm.c
+++ b/sound/soc/ux500/ux500_pcm.c
@@ -65,14 +65,10 @@ static struct dma_chan *ux500_pcm_request_chan(struct snd_soc_pcm_runtime *rtd,
 	struct snd_pcm_substream *substream)
 {
 	struct snd_soc_dai *dai = rtd->cpu_dai;
-	struct device *dev = dai->dev;
 	u16 per_data_width, mem_data_width;
 	struct stedma40_chan_cfg *dma_cfg;
 	struct ux500_msp_dma_params *dma_params;
 
-	dev_dbg(dev, "%s: MSP %d (%s): Enter.\n", __func__, dai->id,
-		snd_pcm_stream_str(substream));
-
 	dma_params = snd_soc_dai_get_dma_data(dai, substream);
 	dma_cfg = dma_params->dma_cfg;
 
-- 
1.8.3.2
