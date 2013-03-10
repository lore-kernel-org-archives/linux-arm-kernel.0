From: mpa@pengutronix.de (Markus Pargmann)
Date: Sun, 10 Mar 2013 19:33:02 +0100
Subject: [PATCH 01/10] imx-ssi: Fix AC97 rates
In-Reply-To: <1362940391-8338-1-git-send-email-mpa@pengutronix.de>
References: <1362940391-8338-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1362940391-8338-2-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sascha Hauer <s.hauer@pengutronix.de>

This device supports multiple rates as described in later AC97
standards. This patch allows playback of different sample frequencies
without conversion.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 sound/soc/fsl/imx-ssi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/imx-ssi.c b/sound/soc/fsl/imx-ssi.c
index 55464a5..7ee0147 100644
--- a/sound/soc/fsl/imx-ssi.c
+++ b/sound/soc/fsl/imx-ssi.c
@@ -400,7 +400,7 @@ static struct snd_soc_dai_driver imx_ac97_dai = {
 		.stream_name = "AC97 Playback",
 		.channels_min = 2,
 		.channels_max = 2,
-		.rates = SNDRV_PCM_RATE_48000,
+		.rates = SNDRV_PCM_RATE_8000_48000,
 		.formats = SNDRV_PCM_FMTBIT_S16_LE,
 	},
 	.capture = {
-- 
1.8.1.5
