From: dannym@scratchpost.org (Danny Milosavljevic)
Date: Fri,  9 Jun 2017 08:22:12 +0200
Subject: [PATCH v11 08/12] sun4i-codec: Merge sun4i_codec_left_mixer_controls
 and sun4i_codec_right_mixer_controls into sun4i_codec_mixer_controls.
In-Reply-To: <20170609062216.26807-1-dannym@scratchpost.org>
References: <20170609062216.26807-1-dannym@scratchpost.org>
Message-ID: <20170609062216.26807-9-dannym@scratchpost.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Danny Milosavljevic <dannym@scratchpost.org>
---
 sound/soc/sunxi/sun4i-codec.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index d453af65..07ed4fd4 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -759,15 +759,12 @@ static const struct snd_kcontrol_new sun7i_codec_extra_controls[] = {
 		       sun7i_codec_micin_preamp_gain_scale),
 };
 
-static const struct snd_kcontrol_new sun4i_codec_left_mixer_controls[] = {
-	SOC_DAPM_SINGLE("Left DAC Playback Switch", SUN4I_CODEC_DAC_ACTL,
-			SUN4I_CODEC_DAC_ACTL_LDACLMIXS, 1, 0),
-};
-
-static const struct snd_kcontrol_new sun4i_codec_right_mixer_controls[] = {
-	SOC_DAPM_SINGLE("Right DAC Playback Switch", SUN4I_CODEC_DAC_ACTL,
+static const struct snd_kcontrol_new sun4i_codec_mixer_controls[] = {
+	SOC_DAPM_DOUBLE("DAC Playback Switch",
+			SUN4I_CODEC_DAC_ACTL,
+			SUN4I_CODEC_DAC_ACTL_LDACLMIXS,
 			SUN4I_CODEC_DAC_ACTL_RDACRMIXS, 1, 0),
-	SOC_DAPM_SINGLE("Left DAC Playback Switch", SUN4I_CODEC_DAC_ACTL,
+	SOC_DAPM_SINGLE("Right Mixer Left DAC Playback Switch", SUN4I_CODEC_DAC_ACTL,
 			SUN4I_CODEC_DAC_ACTL_LDACRMIXS, 1, 0),
 };
 
@@ -803,11 +800,11 @@ static const struct snd_soc_dapm_widget sun4i_codec_codec_dapm_widgets[] = {
 
 	/* Mixers */
 	SND_SOC_DAPM_MIXER("Left Mixer", SND_SOC_NOPM, 0, 0,
-			   sun4i_codec_left_mixer_controls,
-			   ARRAY_SIZE(sun4i_codec_left_mixer_controls)),
+			   sun4i_codec_mixer_controls,
+			   ARRAY_SIZE(sun4i_codec_mixer_controls)),
 	SND_SOC_DAPM_MIXER("Right Mixer", SND_SOC_NOPM, 0, 0,
-			   sun4i_codec_right_mixer_controls,
-			   ARRAY_SIZE(sun4i_codec_right_mixer_controls)),
+			   sun4i_codec_mixer_controls,
+			   ARRAY_SIZE(sun4i_codec_mixer_controls)),
 
 	/* Global Mixer Enable */
 	SND_SOC_DAPM_SUPPLY("Mixer Enable", SUN4I_CODEC_DAC_ACTL,
