From: moinejf@free.fr (Jean-Francois Moine)
Date: Tue, 26 Nov 2013 10:41:40 +0100
Subject: [PATCH] ASoC: kirkwood: Fix invalid SPDIF format
Message-ID: <20131126104140.16e3eb87@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removes the 32 bits format which is not supported by S/PDIF
output.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 sound/soc/kirkwood/kirkwood-i2s.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/sound/soc/kirkwood/kirkwood-i2s.c b/sound/soc/kirkwood/kirkwood-i2s.c
index b27f826..0b18f65 100644
--- a/sound/soc/kirkwood/kirkwood-i2s.c
+++ b/sound/soc/kirkwood/kirkwood-i2s.c
@@ -33,6 +33,10 @@
 	 SNDRV_PCM_FMTBIT_S24_LE | \
 	 SNDRV_PCM_FMTBIT_S32_LE)
 
+#define KIRKWOOD_SPDIF_FORMATS \
+	(SNDRV_PCM_FMTBIT_S16_LE | \
+	 SNDRV_PCM_FMTBIT_S24_LE)
+
 static int kirkwood_i2s_set_fmt(struct snd_soc_dai *cpu_dai,
 		unsigned int fmt)
 {
@@ -449,14 +453,14 @@ static struct snd_soc_dai_driver kirkwood_i2s_dai[2] = {
 		.channels_max = 2,
 		.rates = SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 |
 				SNDRV_PCM_RATE_96000,
-		.formats = KIRKWOOD_I2S_FORMATS,
+		.formats = KIRKWOOD_SPDIF_FORMATS,
 	},
 	.capture = {
 		.channels_min = 1,
 		.channels_max = 2,
 		.rates = SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 |
 				SNDRV_PCM_RATE_96000,
-		.formats = KIRKWOOD_I2S_FORMATS,
+		.formats = KIRKWOOD_SPDIF_FORMATS,
 	},
 	.ops = &kirkwood_i2s_dai_ops,
     },
@@ -493,7 +497,7 @@ static struct snd_soc_dai_driver kirkwood_i2s_dai_extclk[2] = {
 		.rates = SNDRV_PCM_RATE_8000_192000 |
 			 SNDRV_PCM_RATE_CONTINUOUS |
 			 SNDRV_PCM_RATE_KNOT,
-		.formats = KIRKWOOD_I2S_FORMATS,
+		.formats = KIRKWOOD_SPDIF_FORMATS,
 	},
 	.capture = {
 		.channels_min = 1,
@@ -501,7 +505,7 @@ static struct snd_soc_dai_driver kirkwood_i2s_dai_extclk[2] = {
 		.rates = SNDRV_PCM_RATE_8000_192000 |
 			 SNDRV_PCM_RATE_CONTINUOUS |
 			 SNDRV_PCM_RATE_KNOT,
-		.formats = KIRKWOOD_I2S_FORMATS,
+		.formats = KIRKWOOD_SPDIF_FORMATS,
 	},
 	.ops = &kirkwood_i2s_dai_ops,
     },

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
