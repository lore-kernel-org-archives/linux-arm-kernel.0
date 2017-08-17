From: broonie@kernel.org (Mark Brown)
Date: Thu, 17 Aug 2017 18:12:52 +0100
Subject: Applied "ASoC: codecs: make snd_soc_dai_driver and
 snd_soc_component_driver const" to the asoc tree
In-Reply-To: <1502903709-7411-3-git-send-email-bhumirks@gmail.com>
Message-ID: <E1diOLk-0008IC-Go@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: codecs: make snd_soc_dai_driver and snd_soc_component_driver const

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

>From 6e37f933ed1ade3201dd609d103c0ef79c0ef6b0 Mon Sep 17 00:00:00 2001
From: Bhumika Goyal <bhumirks@gmail.com>
Date: Wed, 16 Aug 2017 22:45:09 +0530
Subject: [PATCH] ASoC: codecs: make snd_soc_dai_driver and
 snd_soc_component_driver const

Make these two structure variables const as they are either used in a
copy operation or passed to devm_snd_soc_register_component having the
corresponding argument as const.
Done using Coccinelle.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/hdmi-codec.c | 2 +-
 sound/soc/codecs/lm4857.c     | 2 +-
 sound/soc/codecs/max9768.c    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index f288404f0a61..d73d2c1ed823 100644
--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -692,7 +692,7 @@ static int hdmi_codec_pcm_new(struct snd_soc_pcm_runtime *rtd,
 	return snd_ctl_add(rtd->card->snd_card, kctl);
 }
 
-static struct snd_soc_dai_driver hdmi_i2s_dai = {
+static const struct snd_soc_dai_driver hdmi_i2s_dai = {
 	.name = "i2s-hifi",
 	.id = DAI_ID_I2S,
 	.playback = {
diff --git a/sound/soc/codecs/lm4857.c b/sound/soc/codecs/lm4857.c
index 558de1053f73..1e964079642a 100644
--- a/sound/soc/codecs/lm4857.c
+++ b/sound/soc/codecs/lm4857.c
@@ -100,7 +100,7 @@ static const struct snd_soc_dapm_route lm4857_routes[] = {
 	{ "EP", "Earpiece", "Mode" },
 };
 
-static struct snd_soc_component_driver lm4857_component_driver = {
+static const struct snd_soc_component_driver lm4857_component_driver = {
 	.controls = lm4857_controls,
 	.num_controls = ARRAY_SIZE(lm4857_controls),
 	.dapm_widgets = lm4857_dapm_widgets,
diff --git a/sound/soc/codecs/max9768.c b/sound/soc/codecs/max9768.c
index 5b82e26cd5d1..7017c0389e73 100644
--- a/sound/soc/codecs/max9768.c
+++ b/sound/soc/codecs/max9768.c
@@ -151,7 +151,7 @@ static int max9768_probe(struct snd_soc_component *component)
 	return 0;
 }
 
-static struct snd_soc_component_driver max9768_component_driver = {
+static const struct snd_soc_component_driver max9768_component_driver = {
 	.probe = max9768_probe,
 	.controls = max9768_volume,
 	.num_controls = ARRAY_SIZE(max9768_volume),
-- 
2.13.3
