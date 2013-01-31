From: voice.shen@atmel.com (Bo Shen)
Date: Thu, 31 Jan 2013 11:53:38 +0800
Subject: [PATCH 2/4] ASoC: atmel_ssc_dai: remove error set private data
In-Reply-To: <1359604420-15171-1-git-send-email-voice.shen@atmel.com>
References: <1359604420-15171-1-git-send-email-voice.shen@atmel.com>
Message-ID: <1359604420-15171-3-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ssc private data has been set in ssc driver, this cause the error
private data set to ssc, remove it

Signed-off-by: Bo Shen <voice.shen@atmel.com>
---
 sound/soc/atmel/atmel_ssc_dai.c |   10 ----------
 1 file changed, 10 deletions(-)

diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
index 1c76634..2763aea 100644
--- a/sound/soc/atmel/atmel_ssc_dai.c
+++ b/sound/soc/atmel/atmel_ssc_dai.c
@@ -679,15 +679,6 @@ static int atmel_ssc_resume(struct snd_soc_dai *cpu_dai)
 #  define atmel_ssc_resume	NULL
 #endif /* CONFIG_PM */
 
-static int atmel_ssc_probe(struct snd_soc_dai *dai)
-{
-	struct atmel_ssc_info *ssc_p = &ssc_info[dai->id];
-
-	snd_soc_dai_set_drvdata(dai, ssc_p);
-
-	return 0;
-}
-
 #define ATMEL_SSC_RATES (SNDRV_PCM_RATE_8000_96000)
 
 #define ATMEL_SSC_FORMATS (SNDRV_PCM_FMTBIT_S8     | SNDRV_PCM_FMTBIT_S16_LE |\
@@ -703,7 +694,6 @@ static const struct snd_soc_dai_ops atmel_ssc_dai_ops = {
 };
 
 static struct snd_soc_dai_driver atmel_ssc_dai = {
-		.probe = atmel_ssc_probe,
 		.suspend = atmel_ssc_suspend,
 		.resume = atmel_ssc_resume,
 		.playback = {
-- 
1.7.9.5
