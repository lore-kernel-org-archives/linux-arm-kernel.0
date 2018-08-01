From: colin.king@canonical.com (Colin King)
Date: Wed,  1 Aug 2018 11:47:40 +0100
Subject: [PATCH 7/9] ASoC: stm32: remove redundant pointers 'priv' and 'rtd'
In-Reply-To: <20180801104742.4328-1-colin.king@canonical.com>
References: <20180801104742.4328-1-colin.king@canonical.com>
Message-ID: <20180801104742.4328-8-colin.king@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Colin Ian King <colin.king@canonical.com>

Pointer 'priv' is assigned and not used, removing this allows
the removal of pointer 'rtd'.

Cleans up clang warning:
warning: variable 'priv' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/stm/stm32_adfsdm.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/sound/soc/stm/stm32_adfsdm.c b/sound/soc/stm/stm32_adfsdm.c
index 0e9373064032..706ff005234f 100644
--- a/sound/soc/stm/stm32_adfsdm.c
+++ b/sound/soc/stm/stm32_adfsdm.c
@@ -269,16 +269,10 @@ static int stm32_adfsdm_pcm_new(struct snd_soc_pcm_runtime *rtd)
 static void stm32_adfsdm_pcm_free(struct snd_pcm *pcm)
 {
 	struct snd_pcm_substream *substream;
-	struct snd_soc_pcm_runtime *rtd;
-	struct stm32_adfsdm_priv *priv;
 
 	substream = pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream;
-	if (substream) {
-		rtd = substream->private_data;
-		priv = snd_soc_dai_get_drvdata(rtd->cpu_dai);
-
+	if (substream)
 		snd_pcm_lib_preallocate_free_for_all(pcm);
-	}
 }
 
 static struct snd_soc_component_driver stm32_adfsdm_soc_platform = {
-- 
2.17.1
