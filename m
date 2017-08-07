From: broonie@kernel.org (Mark Brown)
Date: Mon, 07 Aug 2017 12:52:00 +0100
Subject: Applied "ASoC: sunxi: make snd_soc_codec_driver structures as const"
 to the asoc tree
In-Reply-To: <1501776020-3328-3-git-send-email-bhumirks@gmail.com>
Message-ID: <E1degZk-0006mz-U3@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: sunxi: make snd_soc_codec_driver structures as const

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

>From 92ff5d085ecc8255600551055262bf98a8f3f1d0 Mon Sep 17 00:00:00 2001
From: Bhumika Goyal <bhumirks@gmail.com>
Date: Thu, 3 Aug 2017 21:30:20 +0530
Subject: [PATCH] ASoC: sunxi: make snd_soc_codec_driver structures as const

Declare snd_soc_codec_driver structures as const as they are either
passed as an argument to the function snd_soc_register_codec or stored as
reference in field codec of type sun4i_codec_quirks. Both the fucntion
argument and the codec field are of type const, so declare the
structures with this property as const.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sunxi/sun4i-codec.c | 6 +++---
 sound/soc/sunxi/sun8i-codec.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index 73d054f466c2..c668b8b08b38 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -762,7 +762,7 @@ static const struct snd_soc_dapm_route sun4i_codec_codec_dapm_routes[] = {
 	{ "Mic1", NULL, "VMIC" },
 };
 
-static struct snd_soc_codec_driver sun4i_codec_codec = {
+static const struct snd_soc_codec_driver sun4i_codec_codec = {
 	.component_driver = {
 		.controls		= sun4i_codec_controls,
 		.num_controls		= ARRAY_SIZE(sun4i_codec_controls),
@@ -1068,7 +1068,7 @@ static const struct snd_soc_dapm_route sun6i_codec_codec_dapm_routes[] = {
 	{ "Right ADC", NULL, "Right ADC Mixer" },
 };
 
-static struct snd_soc_codec_driver sun6i_codec_codec = {
+static const struct snd_soc_codec_driver sun6i_codec_codec = {
 	.component_driver = {
 		.controls		= sun6i_codec_codec_widgets,
 		.num_controls		= ARRAY_SIZE(sun6i_codec_codec_widgets),
@@ -1096,7 +1096,7 @@ static const struct snd_soc_dapm_widget sun8i_a23_codec_codec_widgets[] = {
 
 };
 
-static struct snd_soc_codec_driver sun8i_a23_codec_codec = {
+static const struct snd_soc_codec_driver sun8i_a23_codec_codec = {
 	.component_driver = {
 		.controls		= sun8i_a23_codec_codec_controls,
 		.num_controls		= ARRAY_SIZE(sun8i_a23_codec_codec_controls),
diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-codec.c
index 253ae0b5a4d4..abfb710df7cb 100644
--- a/sound/soc/sunxi/sun8i-codec.c
+++ b/sound/soc/sunxi/sun8i-codec.c
@@ -360,7 +360,7 @@ static struct snd_soc_dai_driver sun8i_codec_dai = {
 	.ops = &sun8i_codec_dai_ops,
 };
 
-static struct snd_soc_codec_driver sun8i_soc_codec = {
+static const struct snd_soc_codec_driver sun8i_soc_codec = {
 	.component_driver = {
 		.dapm_widgets		= sun8i_codec_dapm_widgets,
 		.num_dapm_widgets	= ARRAY_SIZE(sun8i_codec_dapm_widgets),
-- 
2.13.3
