From: axel.lin@gmail.com (Axel Lin)
Date: Sun, 19 Feb 2012 15:40:19 +0800
Subject: [PATCH 2/2] ALSA: pxa2xx-pcm: replace 0xffffffff with DMA_BIT_MASK
 macro
In-Reply-To: <1329637158.4818.4.camel@phoenix>
References: <1329637158.4818.4.camel@phoenix>
Message-ID: <1329637219.4818.5.camel@phoenix>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/arm/pxa2xx-pcm.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/arm/pxa2xx-pcm.c b/sound/arm/pxa2xx-pcm.c
index 26422a3..cbe6374 100644
--- a/sound/arm/pxa2xx-pcm.c
+++ b/sound/arm/pxa2xx-pcm.c
@@ -80,7 +80,7 @@ static struct snd_pcm_ops pxa2xx_pcm_ops = {
 	.mmap		= pxa2xx_pcm_mmap,
 };
 
-static u64 pxa2xx_pcm_dmamask = 0xffffffff;
+static u64 pxa2xx_pcm_dmamask = DMA_BIT_MASK(32);
 
 int pxa2xx_pcm_new(struct snd_card *card, struct pxa2xx_pcm_client *client,
 		   struct snd_pcm **rpcm)
@@ -100,7 +100,7 @@ int pxa2xx_pcm_new(struct snd_card *card, struct pxa2xx_pcm_client *client,
 	if (!card->dev->dma_mask)
 		card->dev->dma_mask = &pxa2xx_pcm_dmamask;
 	if (!card->dev->coherent_dma_mask)
-		card->dev->coherent_dma_mask = 0xffffffff;
+		card->dev->coherent_dma_mask = DMA_BIT_MASK(32);
 
 	if (play) {
 		int stream = SNDRV_PCM_STREAM_PLAYBACK;
-- 
1.7.5.4
