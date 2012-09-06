From: gcembed@gmail.com (=?UTF-8?B?R2HDq3RhbiBDYXJsaWVy?=)
Date: Thu, 06 Sep 2012 08:13:23 +0200
Subject: [PATCH Resend] ASoC: imx-mc13783: use defines instead of numerical
 address of register
Message-ID: <50483F03.8070307@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Forgot to cc Mark Brown, sorry.

This uses already defined name of registers and makes code more readable.

Signed-off-by: Ga?tan Carlier <gcembed@gmail.com>
---
  sound/soc/codecs/mc13783.c |   58 
+++++++++++++++++++++++--------------------
  1 files changed, 31 insertions(+), 27 deletions(-)

diff --git a/sound/soc/codecs/mc13783.c b/sound/soc/codecs/mc13783.c
index 8f726c0..bbfa553 100644
--- a/sound/soc/codecs/mc13783.c
+++ b/sound/soc/codecs/mc13783.c
@@ -426,16 +426,16 @@ static int mc13783_set_tdm_slot_sync(struct 
snd_soc_dai *dai,
  }
   static const struct snd_kcontrol_new mc1l_amp_ctl =
-	SOC_DAPM_SINGLE("Switch", 38, 7, 1, 0);
+	SOC_DAPM_SINGLE("Switch", MC13783_AUDIO_TX, 7, 1, 0);
   static const struct snd_kcontrol_new mc1r_amp_ctl =
-	SOC_DAPM_SINGLE("Switch", 38, 5, 1, 0);
+	SOC_DAPM_SINGLE("Switch", MC13783_AUDIO_TX, 5, 1, 0);
   static const struct snd_kcontrol_new mc2_amp_ctl =
-	SOC_DAPM_SINGLE("Switch", 38, 9, 1, 0);
+	SOC_DAPM_SINGLE("Switch", MC13783_AUDIO_TX, 9, 1, 0);
   static const struct snd_kcontrol_new atx_amp_ctl =
-	SOC_DAPM_SINGLE("Switch", 38, 11, 1, 0);
+	SOC_DAPM_SINGLE("Switch", MC13783_AUDIO_TX, 11, 1, 0);
    /* Virtual mux. The chip does the input selection automatically
@@ -461,22 +461,22 @@ static const struct snd_kcontrol_new right_input_mux =
  	SOC_DAPM_ENUM_VIRT("Route", adcr_enum);
   static const struct snd_kcontrol_new samp_ctl =
-	SOC_DAPM_SINGLE("Switch", 36, 3, 1, 0);
+	SOC_DAPM_SINGLE("Switch", MC13783_AUDIO_RX0, 3, 1, 0);
   static const struct snd_kcontrol_new lamp_ctl =
-	SOC_DAPM_SINGLE("Switch", 36, 5, 1, 0);
+	SOC_DAPM_SINGLE("Switch", MC13783_AUDIO_RX0, 5, 1, 0);
   static const struct snd_kcontrol_new hlamp_ctl =
-	SOC_DAPM_SINGLE("Switch", 36, 10, 1, 0);
+	SOC_DAPM_SINGLE("Switch", MC13783_AUDIO_RX0, 10, 1, 0);
   static const struct snd_kcontrol_new hramp_ctl =
-	SOC_DAPM_SINGLE("Switch", 36, 9, 1, 0);
+	SOC_DAPM_SINGLE("Switch", MC13783_AUDIO_RX0, 9, 1, 0);
   static const struct snd_kcontrol_new llamp_ctl =
-	SOC_DAPM_SINGLE("Switch", 36, 16, 1, 0);
+	SOC_DAPM_SINGLE("Switch", MC13783_AUDIO_RX0, 16, 1, 0);
   static const struct snd_kcontrol_new lramp_ctl =
-	SOC_DAPM_SINGLE("Switch", 36, 15, 1, 0);
+	SOC_DAPM_SINGLE("Switch", MC13783_AUDIO_RX0, 15, 1, 0);
   static const struct snd_soc_dapm_widget mc13783_dapm_widgets[] = {
  /* Input */
@@ -487,13 +487,13 @@ static const struct snd_soc_dapm_widget 
mc13783_dapm_widgets[] = {
  	SND_SOC_DAPM_INPUT("RXINL"),
  	SND_SOC_DAPM_INPUT("TXIN"),
  -	SND_SOC_DAPM_SUPPLY("MC1 Bias", 38, 0, 0, NULL, 0),
-	SND_SOC_DAPM_SUPPLY("MC2 Bias", 38, 1, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("MC1 Bias", MC13783_AUDIO_TX, 0, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("MC2 Bias", MC13783_AUDIO_TX, 1, 0, NULL, 0),
  -	SND_SOC_DAPM_SWITCH("MC1L Amp", 38, 7, 0, &mc1l_amp_ctl),
-	SND_SOC_DAPM_SWITCH("MC1R Amp", 38, 5, 0, &mc1r_amp_ctl),
-	SND_SOC_DAPM_SWITCH("MC2 Amp", 38, 9, 0, &mc2_amp_ctl),
-	SND_SOC_DAPM_SWITCH("TXIN Amp", 38, 11, 0, &atx_amp_ctl),
+	SND_SOC_DAPM_SWITCH("MC1L Amp", MC13783_AUDIO_TX, 7, 0, &mc1l_amp_ctl),
+	SND_SOC_DAPM_SWITCH("MC1R Amp", MC13783_AUDIO_TX, 5, 0, &mc1r_amp_ctl),
+	SND_SOC_DAPM_SWITCH("MC2 Amp", MC13783_AUDIO_TX, 9, 0, &mc2_amp_ctl),
+	SND_SOC_DAPM_SWITCH("TXIN Amp", MC13783_AUDIO_TX, 11, 0, &atx_amp_ctl),
   	SND_SOC_DAPM_VIRT_MUX("PGA Left Input Mux", SND_SOC_NOPM, 0, 0,
  			      &left_input_mux),
@@ -503,12 +503,12 @@ static const struct snd_soc_dapm_widget 
mc13783_dapm_widgets[] = {
  	SND_SOC_DAPM_PGA("PGA Left Input", SND_SOC_NOPM, 0, 0, NULL, 0),
  	SND_SOC_DAPM_PGA("PGA Right Input", SND_SOC_NOPM, 0, 0, NULL, 0),
  -	SND_SOC_DAPM_ADC("ADC", "Capture", 40, 11, 0),
-	SND_SOC_DAPM_SUPPLY("ADC_Reset", 40, 15, 0, NULL, 0),
+	SND_SOC_DAPM_ADC("ADC", "Capture", MC13783_AUDIO_CODEC, 11, 0),
+	SND_SOC_DAPM_SUPPLY("ADC_Reset", MC13783_AUDIO_CODEC, 15, 0, NULL, 0),
   /* Output */
-	SND_SOC_DAPM_SUPPLY("DAC_E", 41, 11, 0, NULL, 0),
-	SND_SOC_DAPM_SUPPLY("DAC_Reset", 41, 15, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("DAC_E", MC13783_AUDIO_DAC, 11, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("DAC_Reset", MC13783_AUDIO_DAC, 15, 0, NULL, 0),
  	SND_SOC_DAPM_OUTPUT("RXOUTL"),
  	SND_SOC_DAPM_OUTPUT("RXOUTR"),
  	SND_SOC_DAPM_OUTPUT("HSL"),
@@ -516,14 +516,18 @@ static const struct snd_soc_dapm_widget 
mc13783_dapm_widgets[] = {
  	SND_SOC_DAPM_OUTPUT("LSP"),
  	SND_SOC_DAPM_OUTPUT("SP"),
  -	SND_SOC_DAPM_SWITCH("Speaker Amp", 36, 3, 0, &samp_ctl),
+	SND_SOC_DAPM_SWITCH("Speaker Amp", MC13783_AUDIO_RX0, 3, 0, &samp_ctl),
  	SND_SOC_DAPM_SWITCH("Loudspeaker Amp", SND_SOC_NOPM, 0, 0, &lamp_ctl),
-	SND_SOC_DAPM_SWITCH("Headset Amp Left", 36, 10, 0, &hlamp_ctl),
-	SND_SOC_DAPM_SWITCH("Headset Amp Right", 36, 9, 0, &hramp_ctl),
-	SND_SOC_DAPM_SWITCH("Line out Amp Left", 36, 16, 0, &llamp_ctl),
-	SND_SOC_DAPM_SWITCH("Line out Amp Right", 36, 15, 0, &lramp_ctl),
-	SND_SOC_DAPM_DAC("DAC", "Playback", 36, 22, 0),
-	SND_SOC_DAPM_PGA("DAC PGA", 37, 5, 0, NULL, 0),
+	SND_SOC_DAPM_SWITCH("Headset Amp Left", MC13783_AUDIO_RX0, 10, 0,
+			&hlamp_ctl),
+	SND_SOC_DAPM_SWITCH("Headset Amp Right", MC13783_AUDIO_RX0, 9, 0,
+			&hramp_ctl),
+	SND_SOC_DAPM_SWITCH("Line out Amp Left", MC13783_AUDIO_RX0, 16, 0,
+			&llamp_ctl),
+	SND_SOC_DAPM_SWITCH("Line out Amp Right", MC13783_AUDIO_RX0, 15, 0,
+			&lramp_ctl),
+	SND_SOC_DAPM_DAC("DAC", "Playback", MC13783_AUDIO_RX0, 22, 0),
+	SND_SOC_DAPM_PGA("DAC PGA", MC13783_AUDIO_RX1, 5, 0, NULL, 0),
  };
   static struct snd_soc_dapm_route mc13783_routes[] = {
-- 
1.7.7.4
