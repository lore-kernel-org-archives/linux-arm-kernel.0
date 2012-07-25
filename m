From: padma.v@samsung.com (Padmavathi Venna)
Date: Wed, 25 Jul 2012 17:39:30 +0530
Subject: [PATCH 2/2] ASOC: SAMSUNG: Add dma_prop variable in s3c_dma_params
In-Reply-To: <1343218170-30483-1-git-send-email-padma.v@samsung.com>
References: <1343218170-30483-1-git-send-email-padma.v@samsung.com>
Message-ID: <1343218170-30483-3-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In DT based implementation, the DMA channel number need to be parsed as
a property from device tree. So add dma_prop variable in s3c_dma_params
to get the i2s DMA channel number.

Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
---
 sound/soc/samsung/dma.c |    1 +
 sound/soc/samsung/dma.h |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sound/soc/samsung/dma.c b/sound/soc/samsung/dma.c
index f3ebc38..28a7c37 100644
--- a/sound/soc/samsung/dma.c
+++ b/sound/soc/samsung/dma.c
@@ -170,6 +170,7 @@ static int dma_hw_params(struct snd_pcm_substream *substream,
 		req.cap = (samsung_dma_has_circular() ?
 			DMA_CYCLIC : DMA_SLAVE);
 		req.client = prtd->params->client;
+		req.dt_dmach_prop = prtd->params->dma_prop;
 		config.direction =
 			(substream->stream == SNDRV_PCM_STREAM_PLAYBACK
 			? DMA_MEM_TO_DEV : DMA_DEV_TO_MEM);
diff --git a/sound/soc/samsung/dma.h b/sound/soc/samsung/dma.h
index 7d1ead7..2e60415 100644
--- a/sound/soc/samsung/dma.h
+++ b/sound/soc/samsung/dma.h
@@ -19,6 +19,7 @@ struct s3c_dma_params {
 	int dma_size;			/* Size of the DMA transfer */
 	unsigned ch;
 	struct samsung_dma_ops *ops;
+	struct property *dma_prop;
 };
 
 #endif
-- 
1.7.4.4
