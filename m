From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 14 Dec 2011 15:47:46 +0800
Subject: [PATCH 5/5] ASoC: mxs: correct 'direction' of device_prep_dma_cyclic
In-Reply-To: <1323791286-29574-1-git-send-email-shawn.guo@linaro.org>
References: <1323791286-29574-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1323848866-19768-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The commit 49920bc (dmaengine: add new enum dma_transfer_direction)
changes the type of parameter 'direction' of device_prep_dma_cyclic
from dma_data_direction to dma_transfer_direction.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 sound/soc/mxs/mxs-pcm.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/mxs/mxs-pcm.c b/sound/soc/mxs/mxs-pcm.c
index 0e12f4e..105f42a 100644
--- a/sound/soc/mxs/mxs-pcm.c
+++ b/sound/soc/mxs/mxs-pcm.c
@@ -136,7 +136,7 @@ static int snd_mxs_pcm_hw_params(struct snd_pcm_substream *substream,
 			iprtd->period_bytes * iprtd->periods,
 			iprtd->period_bytes,
 			substream->stream == SNDRV_PCM_STREAM_PLAYBACK ?
-			DMA_TO_DEVICE : DMA_FROM_DEVICE);
+			DMA_MEM_TO_DEV : DMA_DEV_TO_MEM);
 	if (!iprtd->desc) {
 		dev_err(&chan->dev->device, "cannot prepare slave dma\n");
 		return -EINVAL;
-- 
1.7.4.1
