From: broonie@kernel.org (Mark Brown)
Date: Tue, 19 Sep 2017 14:46:36 +0100
Subject: Applied "ASoC: rockchip: Add dapm route for HDMI" to the asoc tree
In-Reply-To: <20170918014441.17572-1-jeffy.chen@rock-chips.com>
Message-ID: <E1duIrE-0008H7-7j@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: rockchip: Add dapm route for HDMI

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From e7251484f3bc3bd9203a2c39555ca7d53e988cf6 Mon Sep 17 00:00:00 2001
From: Jeffy Chen <jeffy.chen@rock-chips.com>
Date: Mon, 18 Sep 2017 19:17:59 +0800
Subject: [PATCH] ASoC: rockchip: Add dapm route for HDMI

Add dapm route for DP codec.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/rockchip/rk3399_gru_sound.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/rockchip/rk3399_gru_sound.c b/sound/soc/rockchip/rk3399_gru_sound.c
index 1ca269ee0b7e..6463ea86a33a 100644
--- a/sound/soc/rockchip/rk3399_gru_sound.c
+++ b/sound/soc/rockchip/rk3399_gru_sound.c
@@ -47,6 +47,7 @@ static const struct snd_soc_dapm_widget rockchip_dapm_widgets[] = {
 	SND_SOC_DAPM_SPK("Speakers", NULL),
 	SND_SOC_DAPM_MIC("Headset Mic", NULL),
 	SND_SOC_DAPM_MIC("Int Mic", NULL),
+	SND_SOC_DAPM_LINE("HDMI", NULL),
 };
 
 static const struct snd_soc_dapm_route rockchip_dapm_routes[] = {
@@ -60,6 +61,7 @@ static const struct snd_soc_dapm_route rockchip_dapm_routes[] = {
 	{"Headphones", NULL, "HPL"},
 	{"Headphones", NULL, "HPR"},
 	{"Speakers", NULL, "Speaker"},
+	{"HDMI", NULL, "TX"},
 };
 
 static const struct snd_kcontrol_new rockchip_controls[] = {
@@ -67,6 +69,7 @@ static const struct snd_kcontrol_new rockchip_controls[] = {
 	SOC_DAPM_PIN_SWITCH("Speakers"),
 	SOC_DAPM_PIN_SWITCH("Headset Mic"),
 	SOC_DAPM_PIN_SWITCH("Int Mic"),
+	SOC_DAPM_PIN_SWITCH("HDMI"),
 };
 
 static int rockchip_sound_max98357a_hw_params(struct snd_pcm_substream *substream,
-- 
2.14.1
