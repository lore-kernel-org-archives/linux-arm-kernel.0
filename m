From: dannym@scratchpost.org (Danny Milosavljevic)
Date: Sat, 24 Jun 2017 08:24:13 +0200
Subject: [PATCH v13 08/14] ASoC: sun4i-codec: Add FM Left, FM Right,
 FM Playback Switch.
In-Reply-To: <20170624062419.23778-1-dannym@scratchpost.org>
References: <20170624062419.23778-1-dannym@scratchpost.org>
Message-ID: <20170624062419.23778-9-dannym@scratchpost.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add FM Left, FM Right, FM Playback Switch for Allwinner A10 and Allwinner A20.

Signed-off-by: Danny Milosavljevic <dannym@scratchpost.org>
---
 sound/soc/sunxi/sun4i-codec.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index 5b6f100..234ded2 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -702,6 +702,9 @@ static const struct snd_kcontrol_new sun4i_codec_mixer_controls[] = {
 	SOC_DAPM_SINGLE("Right Mixer Left DAC Playback Switch",
 			SUN4I_CODEC_DAC_ACTL,
 			SUN4I_CODEC_DAC_ACTL_LDACRMIXS, 1, 0),
+	SOC_DAPM_DOUBLE("FM Playback Switch", SUN4I_CODEC_DAC_ACTL,
+			SUN4I_CODEC_DAC_ACTL_LFMS,
+			SUN4I_CODEC_DAC_ACTL_RFMS, 1, 0),
 	SOC_DAPM_DOUBLE("Mic1 Playback Switch", SUN4I_CODEC_DAC_ACTL,
 			SUN4I_CODEC_DAC_ACTL_MIC1LS,
 			SUN4I_CODEC_DAC_ACTL_MIC1RS, 1, 0),
@@ -770,6 +773,8 @@ static const struct snd_soc_dapm_widget sun4i_codec_codec_dapm_widgets[] = {
 	SND_SOC_DAPM_SWITCH("Power Amplifier Mute", SND_SOC_NOPM, 0, 0,
 			    &sun4i_codec_pa_mute),
 
+	SND_SOC_DAPM_INPUT("FM Right"),
+	SND_SOC_DAPM_INPUT("FM Left"),
 	SND_SOC_DAPM_INPUT("Mic1"),
 	SND_SOC_DAPM_INPUT("Mic2"),
 
@@ -790,12 +795,14 @@ static const struct snd_soc_dapm_route sun4i_codec_codec_dapm_routes[] = {
 	{ "Right Mixer", NULL, "Mixer Enable" },
 	{ "Right Mixer", "DAC Playback Switch", "Left DAC" },
 	{ "Right Mixer", "Right Mixer Left DAC Playback Switch", "Left DAC" },
+	{ "Right Mixer", "FM Playback Switch", "FM Right" },
 	{ "Right Mixer", "Mic1 Playback Switch", "MIC1 Pre-Amplifier" },
 	{ "Right Mixer", "Mic2 Playback Switch", "MIC2 Pre-Amplifier" },
 
 	/* Left Mixer Routes */
 	{ "Left Mixer", NULL, "Mixer Enable" },
 	{ "Left Mixer", "DAC Playback Switch", "Left DAC" },
+	{ "Left Mixer", "FM Playback Switch", "FM Left" },
 	{ "Left Mixer", "Mic1 Playback Switch", "MIC1 Pre-Amplifier" },
 	{ "Left Mixer", "Mic2 Playback Switch", "MIC2 Pre-Amplifier" },
 
-- 
2.1.4
