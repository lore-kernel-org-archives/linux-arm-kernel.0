From: dannym@scratchpost.org (Danny Milosavljevic)
Date: Thu, 22 Sep 2016 09:13:11 +0200
Subject: [PATCH v5 1/3] ASoC: sun4i-codec: Rename sun4i_codec_widgets for
 consistency
In-Reply-To: <20160922071313.12891-1-dannym@scratchpost.org>
References: <20160922071313.12891-1-dannym@scratchpost.org>
Message-ID: <20160922071313.12891-2-dannym@scratchpost.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ASoC: sun4i-codec: Rename "sun4i_codec_widgets" to "sun4i_codec_controls" for
consistency with the struct field name.

Signed-off-by: Danny Milosavljevic <dannym@scratchpost.org>
---
 sound/soc/sunxi/sun4i-codec.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index 0e19c50..c2c0583 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -509,7 +509,7 @@ static const struct snd_kcontrol_new sun4i_codec_pa_mute =
 
 static DECLARE_TLV_DB_SCALE(sun4i_codec_pa_volume_scale, -6300, 100, 1);
 
-static const struct snd_kcontrol_new sun4i_codec_widgets[] = {
+static const struct snd_kcontrol_new sun4i_codec_controls[] = {
 	SOC_SINGLE_TLV("Power Amplifier Volume", SUN4I_CODEC_DAC_ACTL,
 		       SUN4I_CODEC_DAC_ACTL_PA_VOL, 0x3F, 0,
 		       sun4i_codec_pa_volume_scale),
@@ -629,8 +629,8 @@ static const struct snd_soc_dapm_route sun4i_codec_codec_dapm_routes[] = {
 
 static struct snd_soc_codec_driver sun4i_codec_codec = {
 	.component_driver = {
-		.controls		= sun4i_codec_widgets,
-		.num_controls		= ARRAY_SIZE(sun4i_codec_widgets),
+		.controls		= sun4i_codec_controls,
+		.num_controls		= ARRAY_SIZE(sun4i_codec_controls),
 		.dapm_widgets		= sun4i_codec_codec_dapm_widgets,
 		.num_dapm_widgets	= ARRAY_SIZE(sun4i_codec_codec_dapm_widgets),
 		.dapm_routes		= sun4i_codec_codec_dapm_routes,
