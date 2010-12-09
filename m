From: subaparts@yandex.ru (Alexander)
Date: Thu, 09 Dec 2010 03:43:49 +0300
Subject: [PATCH] ASoC: EP93xx: sampling rate range extended
In-Reply-To: <20101208124637.GD16418@rakim.wolfsonmicro.main>
References: <1291809693.31916.2.camel@r60e>
	<20101208124637.GD16418@rakim.wolfsonmicro.main>
Message-ID: <1291855429.31916.90.camel@r60e>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alexander Sverdlin <subaparts@yandex.ru>

Changes to both I2S and PCM code:
- Rates list extended up to 96kHz, it's tested on EDB9302 and works for both capture and
  playback.

Signed-off-by: Alexander Sverdlin <subaparts@yandex.ru>
---
 sound/soc/ep93xx/ep93xx-i2s.c |    4 ++--
 sound/soc/ep93xx/ep93xx-pcm.c |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/ep93xx/ep93xx-i2s.c b/sound/soc/ep93xx/ep93xx-i2s.c
index 4f48733..9ac93f6 100644
--- a/sound/soc/ep93xx/ep93xx-i2s.c
+++ b/sound/soc/ep93xx/ep93xx-i2s.c
@@ -352,13 +352,13 @@ static struct snd_soc_dai_driver ep93xx_i2s_dai = {
 	.playback	= {
 		.channels_min	= 2,
 		.channels_max	= 2,
-		.rates		= SNDRV_PCM_RATE_8000_48000,
+		.rates		= SNDRV_PCM_RATE_8000_96000,
 		.formats	= EP93XX_I2S_FORMATS,
 	},
 	.capture	= {
 		 .channels_min	= 2,
 		 .channels_max	= 2,
-		 .rates		= SNDRV_PCM_RATE_8000_48000,
+		 .rates		= SNDRV_PCM_RATE_8000_96000,
 		 .formats	= EP93XX_I2S_FORMATS,
 	},
 	.ops		= &ep93xx_i2s_dai_ops,
diff --git a/sound/soc/ep93xx/ep93xx-pcm.c b/sound/soc/ep93xx/ep93xx-pcm.c
index 2f121dd..0667077 100644
--- a/sound/soc/ep93xx/ep93xx-pcm.c
+++ b/sound/soc/ep93xx/ep93xx-pcm.c
@@ -35,9 +35,9 @@ static const struct snd_pcm_hardware ep93xx_pcm_hardware = {
 				   SNDRV_PCM_INFO_INTERLEAVED	|
 				   SNDRV_PCM_INFO_BLOCK_TRANSFER),
 				   
-	.rates			= SNDRV_PCM_RATE_8000_48000,
+	.rates			= SNDRV_PCM_RATE_8000_96000,
 	.rate_min		= SNDRV_PCM_RATE_8000,
-	.rate_max		= SNDRV_PCM_RATE_48000,
+	.rate_max		= SNDRV_PCM_RATE_96000,
 	
 	.formats		= (SNDRV_PCM_FMTBIT_S16_LE |
 				   SNDRV_PCM_FMTBIT_S24_LE |
