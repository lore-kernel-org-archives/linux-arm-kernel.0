From: dannym@scratchpost.org (Danny Milosavljevic)
Date: Sat, 24 Jun 2017 08:24:19 +0200
Subject: [PATCH v13 14/14] ASoC: sun4i-codec: Add Capture Volume.
In-Reply-To: <20170624062419.23778-1-dannym@scratchpost.org>
References: <20170624062419.23778-1-dannym@scratchpost.org>
Message-ID: <20170624062419.23778-15-dannym@scratchpost.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Capture Volume for Allwinner A10 and Allwinner A20.

Signed-off-by: Danny Milosavljevic <dannym@scratchpost.org>
---
 sound/soc/sunxi/sun4i-codec.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index 65a4685..a596249 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -675,6 +675,7 @@ static DECLARE_TLV_DB_RANGE(sun4i_codec_micin_preamp_gain_scale,
 static DECLARE_TLV_DB_RANGE(sun7i_codec_micin_preamp_gain_scale,
 			    0, 0, TLV_DB_SCALE_ITEM(0, 0, 0),
 			    1, 7, TLV_DB_SCALE_ITEM(2400, 300, 0));
+static DECLARE_TLV_DB_SCALE(sun4i_codec_adc_gain_scale, -450, 150, 0);
 
 static const char * const sun4i_codec_capture_source[] = {
 	"Line",
@@ -725,6 +726,10 @@ static const struct snd_kcontrol_new sun4i_codec_controls[] = {
 	SOC_SINGLE_TLV("Mic Playback Volume", SUN4I_CODEC_DAC_ACTL,
 		       SUN4I_CODEC_DAC_ACTL_MICG, 7, 0,
 		       sun4i_codec_micin_loopback_gain_scale),
+	/* ADC */
+	SOC_SINGLE_TLV("Capture Volume", SUN4I_CODEC_ADC_ACTL,
+		       SUN4I_CODEC_ADC_ACTL_VADCG, 4, 0,
+		       sun4i_codec_adc_gain_scale),
 };
 
 static const struct snd_kcontrol_new sun4i_codec_extra_controls[] = {
-- 
2.1.4
