From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue,  1 Dec 2015 12:06:46 +0100
Subject: [PATCH 1/2] ASoC: sunxi: Remove useless comments and variable
Message-ID: <1448968007-10128-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The comment is misleading on how we should support external power amps, and
the variable is not used and generates a warning.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 sound/soc/sunxi/sun4i-codec.c | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index 30c9e9260491..516c7c2b479a 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -109,11 +109,6 @@ struct sun4i_codec {
 
 static void sun4i_codec_start_playback(struct sun4i_codec *scodec)
 {
-	/*
-	 * FIXME: according to the BSP, we might need to drive a PA
-	 *        GPIO high here on some boards
-	 */
-
 	/* Flush TX FIFO */
 	regmap_update_bits(scodec->regmap, SUN4I_CODEC_DAC_FIFOC,
 			   BIT(SUN4I_CODEC_DAC_FIFOC_FIFO_FLUSH),
@@ -127,11 +122,6 @@ static void sun4i_codec_start_playback(struct sun4i_codec *scodec)
 
 static void sun4i_codec_stop_playback(struct sun4i_codec *scodec)
 {
-	/*
-	 * FIXME: according to the BSP, we might need to drive a PA
-	 *        GPIO low here on some boards
-	 */
-
 	/* Disable DAC DRQ */
 	regmap_update_bits(scodec->regmap, SUN4I_CODEC_DAC_FIFOC,
 			   BIT(SUN4I_CODEC_DAC_FIFOC_DAC_DRQ_EN),
@@ -140,11 +130,6 @@ static void sun4i_codec_stop_playback(struct sun4i_codec *scodec)
 
 static void sun4i_codec_start_capture(struct sun4i_codec *scodec)
 {
-	/*
-	 * FIXME: according to the BSP, we might need to drive a PA
-	 *        GPIO high here on some boards
-	 */
-
 	/* Enable ADC DRQ */
 	regmap_update_bits(scodec->regmap, SUN4I_CODEC_ADC_FIFOC,
 			   BIT(SUN4I_CODEC_ADC_FIFOC_ADC_DRQ_EN),
@@ -153,11 +138,6 @@ static void sun4i_codec_start_capture(struct sun4i_codec *scodec)
 
 static void sun4i_codec_stop_capture(struct sun4i_codec *scodec)
 {
-	/*
-	 * FIXME: according to the BSP, we might need to drive a PA
-	 *        GPIO low here on some boards
-	 */
-
 	/* Disable ADC DRQ */
 	regmap_update_bits(scodec->regmap, SUN4I_CODEC_ADC_FIFOC,
 			   BIT(SUN4I_CODEC_ADC_FIFOC_ADC_DRQ_EN), 0);
@@ -358,8 +338,6 @@ static int sun4i_codec_hw_params_capture(struct sun4i_codec *scodec,
 					 struct snd_pcm_hw_params *params,
 					 unsigned int hwrate)
 {
-	u32 val;
-
 	/* Set ADC sample rate */
 	regmap_update_bits(scodec->regmap, SUN4I_CODEC_ADC_FIFOC,
 			   7 << SUN4I_CODEC_ADC_FIFOC_ADC_FS,
-- 
2.6.3
