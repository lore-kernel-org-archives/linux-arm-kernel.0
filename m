From: moinejf@free.fr (Jean-Francois Moine)
Date: Wed, 27 Nov 2013 21:10:24 +0100
Subject: [PATCH] ASoC: kirkwood: Fix the CPU DAI rates
Message-ID: <20131127211024.52e5ae1b@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the rates declared in the CPU DAI parameters:
- SNDRV_PCM_RATE_KNOT and the discrete rates SNDRV_PCM_RATE_xxx should
  not be used with SNDRV_PCM_RATE_CONTINUOUS,
- SNDRV_PCM_RATE_CONTINUOUS asks for rate_min and rate_max,
- the device may do streaming down to 5512Hz.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 sound/soc/kirkwood/kirkwood-i2s.c | 24 +++++++++++-----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/sound/soc/kirkwood/kirkwood-i2s.c b/sound/soc/kirkwood/kirkwood-i2s.c
index 0b18f65..3920a5e 100644
--- a/sound/soc/kirkwood/kirkwood-i2s.c
+++ b/sound/soc/kirkwood/kirkwood-i2s.c
@@ -473,17 +473,17 @@ static struct snd_soc_dai_driver kirkwood_i2s_dai_extclk[2] = {
 	.playback = {
 		.channels_min = 1,
 		.channels_max = 2,
-		.rates = SNDRV_PCM_RATE_8000_192000 |
-			 SNDRV_PCM_RATE_CONTINUOUS |
-			 SNDRV_PCM_RATE_KNOT,
+		.rates = SNDRV_PCM_RATE_CONTINUOUS,
+		.rate_min = 5512,
+		.rate_max = 192000,
 		.formats = KIRKWOOD_I2S_FORMATS,
 	},
 	.capture = {
 		.channels_min = 1,
 		.channels_max = 2,
-		.rates = SNDRV_PCM_RATE_8000_192000 |
-			 SNDRV_PCM_RATE_CONTINUOUS |
-			 SNDRV_PCM_RATE_KNOT,
+		.rates = SNDRV_PCM_RATE_CONTINUOUS,
+		.rate_min = 5512,
+		.rate_max = 192000,
 		.formats = KIRKWOOD_I2S_FORMATS,
 	},
 	.ops = &kirkwood_i2s_dai_ops,
@@ -494,17 +494,17 @@ static struct snd_soc_dai_driver kirkwood_i2s_dai_extclk[2] = {
 	.playback = {
 		.channels_min = 1,
 		.channels_max = 2,
-		.rates = SNDRV_PCM_RATE_8000_192000 |
-			 SNDRV_PCM_RATE_CONTINUOUS |
-			 SNDRV_PCM_RATE_KNOT,
+		.rates = SNDRV_PCM_RATE_CONTINUOUS,
+		.rate_min = 5512,
+		.rate_max = 192000,
 		.formats = KIRKWOOD_SPDIF_FORMATS,
 	},
 	.capture = {
 		.channels_min = 1,
 		.channels_max = 2,
-		.rates = SNDRV_PCM_RATE_8000_192000 |
-			 SNDRV_PCM_RATE_CONTINUOUS |
-			 SNDRV_PCM_RATE_KNOT,
+		.rates = SNDRV_PCM_RATE_CONTINUOUS,
+		.rate_min = 5512,
+		.rate_max = 192000,
 		.formats = KIRKWOOD_SPDIF_FORMATS,
 	},
 	.ops = &kirkwood_i2s_dai_ops,


-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
