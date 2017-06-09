From: dannym@scratchpost.org (Danny Milosavljevic)
Date: Fri,  9 Jun 2017 08:22:16 +0200
Subject: [PATCH v11 12/12] sun4i-codec: Add routes for playback switches, Mic2,
 Capture Select.
In-Reply-To: <20170609062216.26807-1-dannym@scratchpost.org>
References: <20170609062216.26807-1-dannym@scratchpost.org>
Message-ID: <20170609062216.26807-13-dannym@scratchpost.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Danny Milosavljevic <dannym@scratchpost.org>
---
 sound/soc/sunxi/sun4i-codec.c | 51 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 48 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index a9e10dce..315d79a3 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -905,12 +905,20 @@ static const struct snd_soc_dapm_route sun4i_codec_codec_dapm_routes[] = {
 
 	/* Right Mixer Routes */
 	{ "Right Mixer", NULL, "Mixer Enable" },
-	{ "Right Mixer", "Left DAC Playback Switch", "Left DAC" },
-	{ "Right Mixer", "Right DAC Playback Switch", "Right DAC" },
+	{ "Right Mixer", "Right Mixer Left DAC Playback Switch", "Left DAC" },
+	{ "Right Mixer", "DAC Playback Switch", "Right DAC" },
+	{ "Right Mixer", "Mic1 Playback Switch", "MIC1 Pre-Amplifier" },
+	{ "Right Mixer", "Mic2 Playback Switch", "MIC2 Pre-Amplifier" },
+	{ "Right Mixer", "Line Playback Switch", "Line Right" },
+	{ "Right Mixer", "FM Playback Switch", "FM Right" },
 
 	/* Left Mixer Routes */
 	{ "Left Mixer", NULL, "Mixer Enable" },
-	{ "Left Mixer", "Left DAC Playback Switch", "Left DAC" },
+	{ "Left Mixer", "DAC Playback Switch", "Left DAC" },
+	{ "Left Mixer", "Mic1 Playback Switch", "MIC1 Pre-Amplifier" },
+	{ "Left Mixer", "Mic2 Playback Switch", "MIC2 Pre-Amplifier" },
+	{ "Left Mixer", "Line Playback Switch", "Line Left" },
+	{ "Left Mixer", "FM Playback Switch", "FM Left" },
 
 	/* Power Amplifier Routes */
 	{ "Power Amplifier", "Mixer Playback Switch", "Left Mixer" },
@@ -928,11 +936,48 @@ static const struct snd_soc_dapm_route sun4i_codec_codec_dapm_routes[] = {
 	{ "Right ADC", NULL, "MIC1 Pre-Amplifier" },
 	{ "MIC1 Pre-Amplifier", NULL, "Mic1"},
 	{ "Mic1", NULL, "VMIC" },
+	/* see also Left Mixer Routes, Right Mixer Routes */
+
+	/* Mic2 Routes */
+	{ "Left ADC", NULL, "MIC2 Pre-Amplifier" },
+	{ "Right ADC", NULL, "MIC2 Pre-Amplifier" },
+	{ "MIC2 Pre-Amplifier", NULL, "Mic2"},
+	{ "Mic2", NULL, "VMIC" },
+	/* see also Left Mixer Routes, Right Mixer Routes */
+
+	/* Line, FM Routes */
+	/* see also Left Mixer Routes, Right Mixer Routes */
 
 	/* LNRDF Routes */
 	{ "Differential Line Capture Switch", "Differential", "Line Left" },
 	{ "Differential Line Capture Switch", "Differential", "Line Right" },
 
+	/* Right ADC Input Routes */
+	{ "Right Capture Select", "Line", "Line Right" },
+	{ "Right Capture Select", "Line", "Differential Line Capture Switch" },
+	{ "Right Capture Select", "FM", "FM Right" },
+	{ "Right Capture Select", "Mic1", "MIC1 Pre-Amplifier" },
+	{ "Right Capture Select", "Mic2", "MIC2 Pre-Amplifier" },
+	{ "Right Capture Select", "Mic1,Mic2", "MIC2 Pre-Amplifier" },
+	{ "Right Capture Select", "Mic1+Mic2", "MIC2 Pre-Amplifier" },
+	{ "Right Capture Select", "Mic1+Mic2", "MIC1 Pre-Amplifier" },
+	{ "Right Capture Select", "Output Mixer", "Right Mixer" },
+	{ "Right Capture Select", "Line,Mic1", "MIC1 Pre-Amplifier" },
+	{ "Right ADC", NULL, "Right Capture Select" },
+
+	/* Left ADC Input Routes */
+	{ "Left Capture Select", "Line", "Line Left" },
+	{ "Left Capture Select", "Line", "Differential Line Capture Switch" },
+	{ "Left Capture Select", "FM", "FM Left" },
+	{ "Left Capture Select", "Mic1", "MIC1 Pre-Amplifier" },
+	{ "Left Capture Select", "Mic2", "MIC2 Pre-Amplifier" },
+	{ "Left Capture Select", "Mic1,Mic2", "MIC1 Pre-Amplifier" },
+	{ "Left Capture Select", "Mic1+Mic2", "MIC1 Pre-Amplifier" },
+	{ "Left Capture Select", "Mic1+Mic2", "MIC2 Pre-Amplifier" },
+	{ "Left Capture Select", "Output Mixer", "Left Mixer" },
+	{ "Left Capture Select", "Line,Mic1", "Line Left" },
+	{ "Left Capture Select", "Line,Mic1", "Differential Line Capture Switch" },
+	{ "Left ADC", NULL, "Left Capture Select" },
 };
 
 struct sun4i_codec_quirks {
