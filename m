From: jeffy.chen@rock-chips.com (Jeffy Chen)
Date: Mon, 18 Sep 2017 09:44:39 +0800
Subject: [PATCH v2 1/3] Asoc: rockchip: Add dapm route for HDMI
Message-ID: <20170918014441.17572-1-jeffy.chen@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add dapm route for DP codec.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

Changes in v2:
Separate HDMI/DMIC patches.

 sound/soc/rockchip/rk3399_gru_sound.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/rockchip/rk3399_gru_sound.c b/sound/soc/rockchip/rk3399_gru_sound.c
index 0513fe480353..b050510be65f 100644
--- a/sound/soc/rockchip/rk3399_gru_sound.c
+++ b/sound/soc/rockchip/rk3399_gru_sound.c
@@ -47,6 +47,7 @@ static const struct snd_soc_dapm_widget rockchip_dapm_widgets[] = {
 	SND_SOC_DAPM_SPK("Speakers", NULL),
 	SND_SOC_DAPM_MIC("Headset Mic", NULL),
 	SND_SOC_DAPM_MIC("Int Mic", NULL),
+	SND_SOC_DAPM_LINE("HDMI", NULL),
 };
 
 static const struct snd_soc_dapm_route rockchip_dapm_routes[] = {
@@ -59,6 +60,7 @@ static const struct snd_soc_dapm_route rockchip_dapm_routes[] = {
 	{"Headphones", NULL, "HPL"},
 	{"Headphones", NULL, "HPR"},
 	{"Speakers", NULL, "Speaker"},
+	{"HDMI", NULL, "TX"},
 };
 
 static const struct snd_kcontrol_new rockchip_controls[] = {
@@ -66,6 +68,7 @@ static const struct snd_kcontrol_new rockchip_controls[] = {
 	SOC_DAPM_PIN_SWITCH("Speakers"),
 	SOC_DAPM_PIN_SWITCH("Headset Mic"),
 	SOC_DAPM_PIN_SWITCH("Int Mic"),
+	SOC_DAPM_PIN_SWITCH("HDMI"),
 };
 
 static int rockchip_sound_max98357a_hw_params(struct snd_pcm_substream *substream,
-- 
2.11.0
