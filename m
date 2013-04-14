From: mpa@pengutronix.de (Markus Pargmann)
Date: Sun, 14 Apr 2013 13:42:46 +0200
Subject: [PATCH v3 02/15] ASoC: dmaengine-pcm: Replace of specific helper
 function
In-Reply-To: <1365939779-4507-1-git-send-email-mpa@pengutronix.de>
References: <1365939779-4507-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1365939779-4507-3-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Pargmann <mpa@pengutrnoix.de>

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 sound/soc/soc-generic-dmaengine-pcm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
index d5467ff..2e25402 100644
--- a/sound/soc/soc-generic-dmaengine-pcm.c
+++ b/sound/soc/soc-generic-dmaengine-pcm.c
@@ -221,9 +221,9 @@ int snd_dmaengine_pcm_register(struct device *dev,
 	if (flags & SND_DMAENGINE_PCM_FLAG_COMPAT)
 		pcm->compat = true;
 
-	if (!(flags & SND_DMAENGINE_PCM_FLAG_NO_DT) && dev->of_node) {
+	if (!(flags & SND_DMAENGINE_PCM_FLAG_NO_DT)) {
 		for (i = SNDRV_PCM_STREAM_PLAYBACK; i <= SNDRV_PCM_STREAM_CAPTURE; i++) {
-			pcm->chan[i] = of_dma_request_slave_channel(dev->of_node,
+			pcm->chan[i] = dma_request_slave_channel(dev,
 					dmaengine_pcm_dma_channel_names[i]);
 		}
 	}
-- 
1.8.1.5
