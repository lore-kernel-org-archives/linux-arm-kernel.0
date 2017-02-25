From: codrut.cristian.grosu@gmail.com (Codrut Grosu)
Date: Sat, 25 Feb 2017 23:26:56 +0200
Subject: [PATCH] ASoC: pxa: Remove unneeded else after return statement
Message-ID: <1488058016-14991-1-git-send-email-codrut.cristian.grosu@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This was reported by checkpatch.pl

Signed-off-by: Codrut Grosu <codrut.cristian.grosu@gmail.com>
---
 sound/soc/pxa/pxa2xx-ac97.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/pxa/pxa2xx-ac97.c b/sound/soc/pxa/pxa2xx-ac97.c
index 2e2fb18..f49bf02 100644
--- a/sound/soc/pxa/pxa2xx-ac97.c
+++ b/sound/soc/pxa/pxa2xx-ac97.c
@@ -140,9 +140,8 @@ static int pxa2xx_ac97_mic_startup(struct snd_pcm_substream *substream,
 {
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 		return -ENODEV;
-	else
-		snd_soc_dai_set_dma_data(cpu_dai, substream,
-					 &pxa2xx_ac97_pcm_mic_mono_in);
+	snd_soc_dai_set_dma_data(cpu_dai, substream,
+				 &pxa2xx_ac97_pcm_mic_mono_in);

 	return 0;
 }
--
1.9.1
