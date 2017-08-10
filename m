From: broonie@kernel.org (Mark Brown)
Date: Thu, 10 Aug 2017 16:42:15 +0100
Subject: Applied "ASoC: codecs: add const to snd_soc_codec_driver structures"
 to the asoc tree
In-Reply-To: <1501776020-3328-2-git-send-email-bhumirks@gmail.com>
Message-ID: <E1dfpbD-0001iz-3j@finisterre>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: codecs: add const to snd_soc_codec_driver structures

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

>From a180ba45b1cf630b3bd5912ce235b2ee16606b8e Mon Sep 17 00:00:00 2001
From: Bhumika Goyal <bhumirks@gmail.com>
Date: Thu, 3 Aug 2017 21:30:19 +0530
Subject: [PATCH] ASoC: codecs: add const to snd_soc_codec_driver structures

Declare snd_soc_codec_driver structures as const as they are only passed
as an argument to the function snd_soc_register_codec. This argument is
of type const, so declare the structures with this property as const.
In file codecs/sn95031.c, snd_soc_codec_driver structure is also used in
a copy operation along with getting passed to snd_soc_register_codec.
So, it can be made const too.
Done using Coccinelle:

@match disable optional_qualifier@
identifier s;
position p;
@@
static struct snd_soc_codec_driver s at p={...};

@good1@
identifier match.s;
position p;
@@
snd_soc_register_codec(...,&s at p,...)

@bad@
identifier match.s;
position p!={match.p,good1.p};
@@
s at p

@depends on !bad disable optional_qualifier@
identifier match.s;
@@
static
+const
struct snd_soc_codec_driver s={...};

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/88pm860x-codec.c      | 2 +-
 sound/soc/codecs/ab8500-codec.c        | 2 +-
 sound/soc/codecs/ac97.c                | 2 +-
 sound/soc/codecs/ad1836.c              | 2 +-
 sound/soc/codecs/ad193x.c              | 2 +-
 sound/soc/codecs/ad1980.c              | 2 +-
 sound/soc/codecs/ad73311.c             | 2 +-
 sound/soc/codecs/adau1373.c            | 2 +-
 sound/soc/codecs/adau1701.c            | 2 +-
 sound/soc/codecs/adau1977.c            | 2 +-
 sound/soc/codecs/adav80x.c             | 2 +-
 sound/soc/codecs/ads117x.c             | 2 +-
 sound/soc/codecs/ak4104.c              | 2 +-
 sound/soc/codecs/ak4535.c              | 2 +-
 sound/soc/codecs/ak4554.c              | 2 +-
 sound/soc/codecs/ak4613.c              | 2 +-
 sound/soc/codecs/ak4641.c              | 2 +-
 sound/soc/codecs/ak4642.c              | 2 +-
 sound/soc/codecs/ak4671.c              | 2 +-
 sound/soc/codecs/ak5386.c              | 2 +-
 sound/soc/codecs/alc5623.c             | 2 +-
 sound/soc/codecs/bt-sco.c              | 2 +-
 sound/soc/codecs/cq93vc.c              | 2 +-
 sound/soc/codecs/cs35l33.c             | 2 +-
 sound/soc/codecs/cs35l34.c             | 2 +-
 sound/soc/codecs/cs35l35.c             | 2 +-
 sound/soc/codecs/cs4271.c              | 2 +-
 sound/soc/codecs/cs42l51.c             | 2 +-
 sound/soc/codecs/cs4349.c              | 2 +-
 sound/soc/codecs/cs47l24.c             | 2 +-
 sound/soc/codecs/cs53l30.c             | 2 +-
 sound/soc/codecs/cx20442.c             | 2 +-
 sound/soc/codecs/da7210.c              | 2 +-
 sound/soc/codecs/da7213.c              | 2 +-
 sound/soc/codecs/da7218.c              | 2 +-
 sound/soc/codecs/da7219.c              | 2 +-
 sound/soc/codecs/da732x.c              | 2 +-
 sound/soc/codecs/da9055.c              | 2 +-
 sound/soc/codecs/dmic.c                | 2 +-
 sound/soc/codecs/es7134.c              | 2 +-
 sound/soc/codecs/es8316.c              | 2 +-
 sound/soc/codecs/es8328.c              | 2 +-
 sound/soc/codecs/hdac_hdmi.c           | 2 +-
 sound/soc/codecs/hdmi-codec.c          | 2 +-
 sound/soc/codecs/ics43432.c            | 2 +-
 sound/soc/codecs/inno_rk3036.c         | 2 +-
 sound/soc/codecs/isabelle.c            | 2 +-
 sound/soc/codecs/jz4740.c              | 2 +-
 sound/soc/codecs/lm49453.c             | 2 +-
 sound/soc/codecs/max98088.c            | 2 +-
 sound/soc/codecs/max98090.c            | 2 +-
 sound/soc/codecs/max98095.c            | 2 +-
 sound/soc/codecs/max98357a.c           | 2 +-
 sound/soc/codecs/max9850.c             | 2 +-
 sound/soc/codecs/max9860.c             | 2 +-
 sound/soc/codecs/max9867.c             | 2 +-
 sound/soc/codecs/max98926.c            | 2 +-
 sound/soc/codecs/mc13783.c             | 2 +-
 sound/soc/codecs/ml26124.c             | 2 +-
 sound/soc/codecs/msm8916-wcd-analog.c  | 2 +-
 sound/soc/codecs/msm8916-wcd-digital.c | 2 +-
 sound/soc/codecs/nau8540.c             | 2 +-
 sound/soc/codecs/nau8810.c             | 2 +-
 sound/soc/codecs/nau8824.c             | 2 +-
 sound/soc/codecs/nau8825.c             | 2 +-
 sound/soc/codecs/pcm1681.c             | 2 +-
 sound/soc/codecs/pcm179x.c             | 2 +-
 sound/soc/codecs/pcm3008.c             | 2 +-
 sound/soc/codecs/pcm512x.c             | 2 +-
 sound/soc/codecs/rt274.c               | 2 +-
 sound/soc/codecs/rt286.c               | 2 +-
 sound/soc/codecs/rt298.c               | 2 +-
 sound/soc/codecs/rt5514.c              | 2 +-
 sound/soc/codecs/rt5616.c              | 2 +-
 sound/soc/codecs/rt5631.c              | 2 +-
 sound/soc/codecs/rt5640.c              | 2 +-
 sound/soc/codecs/rt5645.c              | 2 +-
 sound/soc/codecs/rt5651.c              | 2 +-
 sound/soc/codecs/rt5659.c              | 2 +-
 sound/soc/codecs/rt5660.c              | 2 +-
 sound/soc/codecs/rt5663.c              | 2 +-
 sound/soc/codecs/rt5665.c              | 2 +-
 sound/soc/codecs/rt5670.c              | 2 +-
 sound/soc/codecs/rt5677.c              | 2 +-
 sound/soc/codecs/sgtl5000.c            | 2 +-
 sound/soc/codecs/si476x.c              | 2 +-
 sound/soc/codecs/sirf-audio-codec.c    | 2 +-
 sound/soc/codecs/sn95031.c             | 2 +-
 sound/soc/codecs/spdif_receiver.c      | 2 +-
 sound/soc/codecs/spdif_transmitter.c   | 2 +-
 sound/soc/codecs/ssm2518.c             | 2 +-
 sound/soc/codecs/ssm2602.c             | 2 +-
 sound/soc/codecs/ssm4567.c             | 2 +-
 sound/soc/codecs/stac9766.c            | 2 +-
 sound/soc/codecs/tas2552.c             | 2 +-
 sound/soc/codecs/tas5086.c             | 2 +-
 sound/soc/codecs/tas5720.c             | 2 +-
 sound/soc/codecs/tlv320aic23.c         | 2 +-
 sound/soc/codecs/tlv320aic26.c         | 2 +-
 sound/soc/codecs/tlv320aic31xx.c       | 2 +-
 sound/soc/codecs/tlv320aic32x4.c       | 2 +-
 sound/soc/codecs/tlv320aic3x.c         | 2 +-
 sound/soc/codecs/tlv320dac33.c         | 2 +-
 sound/soc/codecs/twl4030.c             | 2 +-
 sound/soc/codecs/twl6040.c             | 2 +-
 sound/soc/codecs/uda134x.c             | 2 +-
 sound/soc/codecs/uda1380.c             | 2 +-
 sound/soc/codecs/wl1273.c              | 2 +-
 sound/soc/codecs/zx_aud96p22.c         | 2 +-
 109 files changed, 109 insertions(+), 109 deletions(-)

diff --git a/sound/soc/codecs/88pm860x-codec.c b/sound/soc/codecs/88pm860x-codec.c
index b013a4c62b63..848c5fe49bc7 100644
--- a/sound/soc/codecs/88pm860x-codec.c
+++ b/sound/soc/codecs/88pm860x-codec.c
@@ -1355,7 +1355,7 @@ static struct regmap *pm860x_get_regmap(struct device *dev)
 	return pm860x->regmap;
 }
 
-static struct snd_soc_codec_driver soc_codec_dev_pm860x = {
+static const struct snd_soc_codec_driver soc_codec_dev_pm860x = {
 	.probe		= pm860x_probe,
 	.remove		= pm860x_remove,
 	.set_bias_level	= pm860x_set_bias_level,
diff --git a/sound/soc/codecs/ab8500-codec.c b/sound/soc/codecs/ab8500-codec.c
index 312b2a11abb6..006627b8c3a8 100644
--- a/sound/soc/codecs/ab8500-codec.c
+++ b/sound/soc/codecs/ab8500-codec.c
@@ -2523,7 +2523,7 @@ static int ab8500_codec_probe(struct snd_soc_codec *codec)
 	return status;
 }
 
-static struct snd_soc_codec_driver ab8500_codec_driver = {
+static const struct snd_soc_codec_driver ab8500_codec_driver = {
 	.probe =		ab8500_codec_probe,
 	.component_driver = {
 		.controls =		ab8500_ctrls,
diff --git a/sound/soc/codecs/ac97.c b/sound/soc/codecs/ac97.c
index f7f04c6be01e..440b4ce54376 100644
--- a/sound/soc/codecs/ac97.c
+++ b/sound/soc/codecs/ac97.c
@@ -112,7 +112,7 @@ static int ac97_soc_resume(struct snd_soc_codec *codec)
 #define ac97_soc_resume NULL
 #endif
 
-static struct snd_soc_codec_driver soc_codec_dev_ac97 = {
+static const struct snd_soc_codec_driver soc_codec_dev_ac97 = {
 	.probe = 	ac97_soc_probe,
 	.suspend =	ac97_soc_suspend,
 	.resume =	ac97_soc_resume,
diff --git a/sound/soc/codecs/ad1836.c b/sound/soc/codecs/ad1836.c
index a478239aadac..d0361caad09e 100644
--- a/sound/soc/codecs/ad1836.c
+++ b/sound/soc/codecs/ad1836.c
@@ -321,7 +321,7 @@ static int ad1836_remove(struct snd_soc_codec *codec)
 		AD1836_ADC_SERFMT_MASK, 0);
 }
 
-static struct snd_soc_codec_driver soc_codec_dev_ad1836 = {
+static const struct snd_soc_codec_driver soc_codec_dev_ad1836 = {
 	.probe = ad1836_probe,
 	.remove = ad1836_remove,
 	.suspend = ad1836_suspend,
diff --git a/sound/soc/codecs/ad193x.c b/sound/soc/codecs/ad193x.c
index d643557d89a7..d10988eec0c1 100644
--- a/sound/soc/codecs/ad193x.c
+++ b/sound/soc/codecs/ad193x.c
@@ -408,7 +408,7 @@ static int ad193x_codec_probe(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static struct snd_soc_codec_driver soc_codec_dev_ad193x = {
+static const struct snd_soc_codec_driver soc_codec_dev_ad193x = {
 	.probe = ad193x_codec_probe,
 	.component_driver = {
 		.controls		= ad193x_snd_controls,
diff --git a/sound/soc/codecs/ad1980.c b/sound/soc/codecs/ad1980.c
index b7c1b9f4bf5f..ce89bfb42094 100644
--- a/sound/soc/codecs/ad1980.c
+++ b/sound/soc/codecs/ad1980.c
@@ -295,7 +295,7 @@ static int ad1980_soc_remove(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static struct snd_soc_codec_driver soc_codec_dev_ad1980 = {
+static const struct snd_soc_codec_driver soc_codec_dev_ad1980 = {
 	.probe = 	ad1980_soc_probe,
 	.remove = 	ad1980_soc_remove,
 
diff --git a/sound/soc/codecs/ad73311.c b/sound/soc/codecs/ad73311.c
index 3e358a49442d..d8d86a0fea60 100644
--- a/sound/soc/codecs/ad73311.c
+++ b/sound/soc/codecs/ad73311.c
@@ -54,7 +54,7 @@ static struct snd_soc_dai_driver ad73311_dai = {
 		.formats = SNDRV_PCM_FMTBIT_S16_LE, },
 };
 
-static struct snd_soc_codec_driver soc_codec_dev_ad73311 = {
+static const struct snd_soc_codec_driver soc_codec_dev_ad73311 = {
 	.component_driver = {
 		.dapm_widgets		= ad73311_dapm_widgets,
 		.num_dapm_widgets	= ARRAY_SIZE(ad73311_dapm_widgets),
diff --git a/sound/soc/codecs/adau1373.c b/sound/soc/codecs/adau1373.c
index 8fa9045571ff..a865945d776a 100644
--- a/sound/soc/codecs/adau1373.c
+++ b/sound/soc/codecs/adau1373.c
@@ -1458,7 +1458,7 @@ static const struct regmap_config adau1373_regmap_config = {
 	.num_reg_defaults = ARRAY_SIZE(adau1373_reg_defaults),
 };
 
-static struct snd_soc_codec_driver adau1373_codec_driver = {
+static const struct snd_soc_codec_driver adau1373_codec_driver = {
 	.probe =	adau1373_probe,
 	.resume =	adau1373_resume,
 	.set_bias_level = adau1373_set_bias_level,
diff --git a/sound/soc/codecs/adau1701.c b/sound/soc/codecs/adau1701.c
index 3bad1bc8c00a..805afac8146b 100644
--- a/sound/soc/codecs/adau1701.c
+++ b/sound/soc/codecs/adau1701.c
@@ -757,7 +757,7 @@ static int adau1701_resume(struct snd_soc_codec *codec)
 #define adau1701_suspend 	NULL
 #endif /* CONFIG_PM */
 
-static struct snd_soc_codec_driver adau1701_codec_drv = {
+static const struct snd_soc_codec_driver adau1701_codec_drv = {
 	.probe			= adau1701_probe,
 	.remove			= adau1701_remove,
 	.resume			= adau1701_resume,
diff --git a/sound/soc/codecs/adau1977.c b/sound/soc/codecs/adau1977.c
index b319db6a69f8..329281675765 100644
--- a/sound/soc/codecs/adau1977.c
+++ b/sound/soc/codecs/adau1977.c
@@ -867,7 +867,7 @@ static int adau1977_codec_probe(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static struct snd_soc_codec_driver adau1977_codec_driver = {
+static const struct snd_soc_codec_driver adau1977_codec_driver = {
 	.probe = adau1977_codec_probe,
 	.set_bias_level = adau1977_set_bias_level,
 	.set_sysclk = adau1977_set_sysclk,
diff --git a/sound/soc/codecs/adav80x.c b/sound/soc/codecs/adav80x.c
index 6e793ebb5883..da7ca81f47cf 100644
--- a/sound/soc/codecs/adav80x.c
+++ b/sound/soc/codecs/adav80x.c
@@ -825,7 +825,7 @@ static int adav80x_resume(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static struct snd_soc_codec_driver adav80x_codec_driver = {
+static const struct snd_soc_codec_driver adav80x_codec_driver = {
 	.probe = adav80x_probe,
 	.resume = adav80x_resume,
 	.set_bias_level = adav80x_set_bias_level,
diff --git a/sound/soc/codecs/ads117x.c b/sound/soc/codecs/ads117x.c
index 90c756d183b4..b7f0057c0239 100644
--- a/sound/soc/codecs/ads117x.c
+++ b/sound/soc/codecs/ads117x.c
@@ -58,7 +58,7 @@ static struct snd_soc_dai_driver ads117x_dai = {
 		.formats = ADS117X_FORMATS,},
 };
 
-static struct snd_soc_codec_driver soc_codec_dev_ads117x = {
+static const struct snd_soc_codec_driver soc_codec_dev_ads117x = {
 	.component_driver = {
 		.dapm_widgets		= ads117x_dapm_widgets,
 		.num_dapm_widgets	= ARRAY_SIZE(ads117x_dapm_widgets),
diff --git a/sound/soc/codecs/ak4104.c b/sound/soc/codecs/ak4104.c
index 1a9d233c94d0..dbb184118f2e 100644
--- a/sound/soc/codecs/ak4104.c
+++ b/sound/soc/codecs/ak4104.c
@@ -242,7 +242,7 @@ static int ak4104_soc_resume(struct snd_soc_codec *codec)
 #define ak4104_soc_resume	NULL
 #endif /* CONFIG_PM */
 
-static struct snd_soc_codec_driver soc_codec_device_ak4104 = {
+static const struct snd_soc_codec_driver soc_codec_device_ak4104 = {
 	.probe = ak4104_probe,
 	.remove = ak4104_remove,
 	.suspend = ak4104_soc_suspend,
diff --git a/sound/soc/codecs/ak4535.c b/sound/soc/codecs/ak4535.c
index 66cfffde9a12..e3c157dc88db 100644
--- a/sound/soc/codecs/ak4535.c
+++ b/sound/soc/codecs/ak4535.c
@@ -390,7 +390,7 @@ static const struct regmap_config ak4535_regmap = {
 	.num_reg_defaults = ARRAY_SIZE(ak4535_reg_defaults),
 };
 
-static struct snd_soc_codec_driver soc_codec_dev_ak4535 = {
+static const struct snd_soc_codec_driver soc_codec_dev_ak4535 = {
 	.resume =	ak4535_resume,
 	.set_bias_level = ak4535_set_bias_level,
 	.suspend_bias_off = true,
diff --git a/sound/soc/codecs/ak4554.c b/sound/soc/codecs/ak4554.c
index b92c548b9d29..0bb4fe5c122a 100644
--- a/sound/soc/codecs/ak4554.c
+++ b/sound/soc/codecs/ak4554.c
@@ -64,7 +64,7 @@ static struct snd_soc_dai_driver ak4554_dai = {
 	.symmetric_rates = 1,
 };
 
-static struct snd_soc_codec_driver soc_codec_dev_ak4554 = {
+static const struct snd_soc_codec_driver soc_codec_dev_ak4554 = {
 	.component_driver = {
 		.dapm_widgets		= ak4554_dapm_widgets,
 		.num_dapm_widgets	= ARRAY_SIZE(ak4554_dapm_widgets),
diff --git a/sound/soc/codecs/ak4613.c b/sound/soc/codecs/ak4613.c
index 690edebf029e..b95bb8b52e51 100644
--- a/sound/soc/codecs/ak4613.c
+++ b/sound/soc/codecs/ak4613.c
@@ -522,7 +522,7 @@ static int ak4613_resume(struct snd_soc_codec *codec)
 	return regcache_sync(regmap);
 }
 
-static struct snd_soc_codec_driver soc_codec_dev_ak4613 = {
+static const struct snd_soc_codec_driver soc_codec_dev_ak4613 = {
 	.suspend		= ak4613_suspend,
 	.resume			= ak4613_resume,
 	.set_bias_level		= ak4613_set_bias_level,
diff --git a/sound/soc/codecs/ak4641.c b/sound/soc/codecs/ak4641.c
index ebdaf56c1d61..60142ff32d4f 100644
--- a/sound/soc/codecs/ak4641.c
+++ b/sound/soc/codecs/ak4641.c
@@ -524,7 +524,7 @@ static struct snd_soc_dai_driver ak4641_dai[] = {
 },
 };
 
-static struct snd_soc_codec_driver soc_codec_dev_ak4641 = {
+static const struct snd_soc_codec_driver soc_codec_dev_ak4641 = {
 	.component_driver = {
 		.controls		= ak4641_snd_controls,
 		.num_controls		= ARRAY_SIZE(ak4641_snd_controls),
diff --git a/sound/soc/codecs/ak4642.c b/sound/soc/codecs/ak4642.c
index 66de8a2013a6..29530c567bd9 100644
--- a/sound/soc/codecs/ak4642.c
+++ b/sound/soc/codecs/ak4642.c
@@ -550,7 +550,7 @@ static int ak4642_probe(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static struct snd_soc_codec_driver soc_codec_dev_ak4642 = {
+static const struct snd_soc_codec_driver soc_codec_dev_ak4642 = {
 	.probe			= ak4642_probe,
 	.suspend		= ak4642_suspend,
 	.resume			= ak4642_resume,
diff --git a/sound/soc/codecs/ak4671.c b/sound/soc/codecs/ak4671.c
index 6088afaabf62..dcfdff56fc5a 100644
--- a/sound/soc/codecs/ak4671.c
+++ b/sound/soc/codecs/ak4671.c
@@ -610,7 +610,7 @@ static struct snd_soc_dai_driver ak4671_dai = {
 	.ops = &ak4671_dai_ops,
 };
 
-static struct snd_soc_codec_driver soc_codec_dev_ak4671 = {
+static const struct snd_soc_codec_driver soc_codec_dev_ak4671 = {
 	.set_bias_level = ak4671_set_bias_level,
 	.component_driver = {
 		.controls		= ak4671_snd_controls,
diff --git a/sound/soc/codecs/ak5386.c b/sound/soc/codecs/ak5386.c
index 0ef2df223336..d0e16c03815c 100644
--- a/sound/soc/codecs/ak5386.c
+++ b/sound/soc/codecs/ak5386.c
@@ -69,7 +69,7 @@ static int ak5386_soc_resume(struct snd_soc_codec *codec)
 #define ak5386_soc_resume	NULL
 #endif /* CONFIG_PM */
 
-static struct snd_soc_codec_driver soc_codec_ak5386 = {
+static const struct snd_soc_codec_driver soc_codec_ak5386 = {
 	.probe = ak5386_soc_probe,
 	.remove = ak5386_soc_remove,
 	.suspend = ak5386_soc_suspend,
diff --git a/sound/soc/codecs/alc5623.c b/sound/soc/codecs/alc5623.c
index d2e3a3ef7499..1db965a93632 100644
--- a/sound/soc/codecs/alc5623.c
+++ b/sound/soc/codecs/alc5623.c
@@ -951,7 +951,7 @@ static int alc5623_probe(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static struct snd_soc_codec_driver soc_codec_device_alc5623 = {
+static const struct snd_soc_codec_driver soc_codec_device_alc5623 = {
 	.probe = alc5623_probe,
 	.suspend = alc5623_suspend,
 	.resume = alc5623_resume,
diff --git a/sound/soc/codecs/bt-sco.c b/sound/soc/codecs/bt-sco.c
index 8014e697d540..806191addb44 100644
--- a/sound/soc/codecs/bt-sco.c
+++ b/sound/soc/codecs/bt-sco.c
@@ -62,7 +62,7 @@ static struct snd_soc_dai_driver bt_sco_dai[] = {
 	}
 };
 
-static struct snd_soc_codec_driver soc_codec_dev_bt_sco = {
+static const struct snd_soc_codec_driver soc_codec_dev_bt_sco = {
 	.component_driver = {
 		.dapm_widgets		= bt_sco_widgets,
 		.num_dapm_widgets	= ARRAY_SIZE(bt_sco_widgets),
diff --git a/sound/soc/codecs/cq93vc.c b/sound/soc/codecs/cq93vc.c
index 7a2d9a2ee427..6ed2cc374768 100644
--- a/sound/soc/codecs/cq93vc.c
+++ b/sound/soc/codecs/cq93vc.c
@@ -128,7 +128,7 @@ static struct regmap *cq93vc_get_regmap(struct device *dev)
 	return davinci_vc->regmap;
 }
 
-static struct snd_soc_codec_driver soc_codec_dev_cq93vc = {
+static const struct snd_soc_codec_driver soc_codec_dev_cq93vc = {
 	.set_bias_level = cq93vc_set_bias_level,
 	.get_regmap = cq93vc_get_regmap,
 	.component_driver = {
diff --git a/sound/soc/codecs/cs35l33.c b/sound/soc/codecs/cs35l33.c
index 6df29fa30fb9..61d128b53e14 100644
--- a/sound/soc/codecs/cs35l33.c
+++ b/sound/soc/codecs/cs35l33.c
@@ -831,7 +831,7 @@ static int cs35l33_probe(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static struct snd_soc_codec_driver soc_codec_dev_cs35l33 = {
+static const struct snd_soc_codec_driver soc_codec_dev_cs35l33 = {
 	.probe = cs35l33_probe,
 
 	.set_bias_level = cs35l33_set_bias_level,
diff --git a/sound/soc/codecs/cs35l34.c b/sound/soc/codecs/cs35l34.c
index 0a747c66cc6c..15d712f4803e 100644
--- a/sound/soc/codecs/cs35l34.c
+++ b/sound/soc/codecs/cs35l34.c
@@ -779,7 +779,7 @@ static int cs35l34_probe(struct snd_soc_codec *codec)
 }
 
 
-static struct snd_soc_codec_driver soc_codec_dev_cs35l34 = {
+static const struct snd_soc_codec_driver soc_codec_dev_cs35l34 = {
 	.probe = cs35l34_probe,
 
 	.component_driver = {
diff --git a/sound/soc/codecs/cs35l35.c b/sound/soc/codecs/cs35l35.c
index f1ee184ecab2..129978d1243e 100644
--- a/sound/soc/codecs/cs35l35.c
+++ b/sound/soc/codecs/cs35l35.c
@@ -1079,7 +1079,7 @@ static int cs35l35_codec_probe(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static struct snd_soc_codec_driver soc_codec_dev_cs35l35 = {
+static const struct snd_soc_codec_driver soc_codec_dev_cs35l35 = {
 	.probe = cs35l35_codec_probe,
 	.set_sysclk = cs35l35_codec_set_sysclk,
 	.component_driver = {
diff --git a/sound/soc/codecs/cs4271.c b/sound/soc/codecs/cs4271.c
index d8824773dc29..49a80627af12 100644
--- a/sound/soc/codecs/cs4271.c
+++ b/sound/soc/codecs/cs4271.c
@@ -639,7 +639,7 @@ static int cs4271_codec_remove(struct snd_soc_codec *codec)
 	return 0;
 };
 
-static struct snd_soc_codec_driver soc_codec_dev_cs4271 = {
+static const struct snd_soc_codec_driver soc_codec_dev_cs4271 = {
 	.probe			= cs4271_codec_probe,
 	.remove			= cs4271_codec_remove,
 	.suspend		= cs4271_soc_suspend,
diff --git a/sound/soc/codecs/cs42l51.c b/sound/soc/codecs/cs42l51.c
index 96cfe38943cd..f8072f1897d4 100644
--- a/sound/soc/codecs/cs42l51.c
+++ b/sound/soc/codecs/cs42l51.c
@@ -504,7 +504,7 @@ static int cs42l51_codec_probe(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static struct snd_soc_codec_driver soc_codec_device_cs42l51 = {
+static const struct snd_soc_codec_driver soc_codec_device_cs42l51 = {
 	.probe = cs42l51_codec_probe,
 
 	.component_driver = {
diff --git a/sound/soc/codecs/cs4349.c b/sound/soc/codecs/cs4349.c
index 231ca935cdf3..0a749c79ef57 100644
--- a/sound/soc/codecs/cs4349.c
+++ b/sound/soc/codecs/cs4349.c
@@ -255,7 +255,7 @@ static struct snd_soc_dai_driver cs4349_dai = {
 	.symmetric_rates = 1,
 };
 
-static struct snd_soc_codec_driver soc_codec_dev_cs4349 = {
+static const struct snd_soc_codec_driver soc_codec_dev_cs4349 = {
 	.component_driver = {
 		.controls		= cs4349_snd_controls,
 		.num_controls		= ARRAY_SIZE(cs4349_snd_controls),
diff --git a/sound/soc/codecs/cs47l24.c b/sound/soc/codecs/cs47l24.c
index 47e6fddef92b..d323caa9c816 100644
--- a/sound/soc/codecs/cs47l24.c
+++ b/sound/soc/codecs/cs47l24.c
@@ -1183,7 +1183,7 @@ static struct regmap *cs47l24_get_regmap(struct device *dev)
 	return priv->core.arizona->regmap;
 }
 
-static struct snd_soc_codec_driver soc_codec_dev_cs47l24 = {
+static const struct snd_soc_codec_driver soc_codec_dev_cs47l24 = {
 	.probe = cs47l24_codec_probe,
 	.remove = cs47l24_codec_remove,
 	.get_regmap = cs47l24_get_regmap,
diff --git a/sound/soc/codecs/cs53l30.c b/sound/soc/codecs/cs53l30.c
index 06933a5d0a75..da4ee5633778 100644
--- a/sound/soc/codecs/cs53l30.c
+++ b/sound/soc/codecs/cs53l30.c
@@ -892,7 +892,7 @@ static int cs53l30_codec_probe(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static struct snd_soc_codec_driver cs53l30_driver = {
+static const struct snd_soc_codec_driver cs53l30_driver = {
 	.probe = cs53l30_codec_probe,
 	.set_bias_level = cs53l30_set_bias_level,
 	.idle_bias_off = true,
diff --git a/sound/soc/codecs/cx20442.c b/sound/soc/codecs/cx20442.c
index 2c12471e42a6..46b1fbb66eba 100644
--- a/sound/soc/codecs/cx20442.c
+++ b/sound/soc/codecs/cx20442.c
@@ -398,7 +398,7 @@ static int cx20442_codec_remove(struct snd_soc_codec *codec)
 
 static const u8 cx20442_reg;
 
-static struct snd_soc_codec_driver cx20442_codec_dev = {
+static const struct snd_soc_codec_driver cx20442_codec_dev = {
 	.probe = 	cx20442_codec_probe,
 	.remove = 	cx20442_codec_remove,
 	.set_bias_level = cx20442_set_bias_level,
diff --git a/sound/soc/codecs/da7210.c b/sound/soc/codecs/da7210.c
index 17053dfc94cf..1af443ccbc51 100644
--- a/sound/soc/codecs/da7210.c
+++ b/sound/soc/codecs/da7210.c
@@ -1164,7 +1164,7 @@ static int da7210_probe(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static struct snd_soc_codec_driver soc_codec_dev_da7210 = {
+static const struct snd_soc_codec_driver soc_codec_dev_da7210 = {
 	.probe			= da7210_probe,
 
 	.component_driver = {
diff --git a/sound/soc/codecs/da7213.c b/sound/soc/codecs/da7213.c
index c3e11897f8ae..cc0b2d2eaf15 100644
--- a/sound/soc/codecs/da7213.c
+++ b/sound/soc/codecs/da7213.c
@@ -1787,7 +1787,7 @@ static int da7213_probe(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static struct snd_soc_codec_driver soc_codec_dev_da7213 = {
+static const struct snd_soc_codec_driver soc_codec_dev_da7213 = {
 	.probe			= da7213_probe,
 	.set_bias_level		= da7213_set_bias_level,
 
diff --git a/sound/soc/codecs/da7218.c b/sound/soc/codecs/da7218.c
index 6e1940eb0653..b2d42ec1dcd9 100644
--- a/sound/soc/codecs/da7218.c
+++ b/sound/soc/codecs/da7218.c
@@ -3035,7 +3035,7 @@ static int da7218_resume(struct snd_soc_codec *codec)
 #define da7218_resume NULL
 #endif
 
-static struct snd_soc_codec_driver soc_codec_dev_da7218 = {
+static const struct snd_soc_codec_driver soc_codec_dev_da7218 = {
 	.probe			= da7218_probe,
 	.remove			= da7218_remove,
 	.suspend		= da7218_suspend,
diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
index f71d72c22bfc..6f088536df32 100644
--- a/sound/soc/codecs/da7219.c
+++ b/sound/soc/codecs/da7219.c
@@ -1891,7 +1891,7 @@ static int da7219_resume(struct snd_soc_codec *codec)
 #define da7219_resume NULL
 #endif
 
-static struct snd_soc_codec_driver soc_codec_dev_da7219 = {
+static const struct snd_soc_codec_driver soc_codec_dev_da7219 = {
 	.probe			= da7219_probe,
 	.remove			= da7219_remove,
 	.suspend		= da7219_suspend,
diff --git a/sound/soc/codecs/da732x.c b/sound/soc/codecs/da732x.c
index c1cc1c1c28f2..83db4d23c90b 100644
--- a/sound/soc/codecs/da732x.c
+++ b/sound/soc/codecs/da732x.c
@@ -1499,7 +1499,7 @@ static int da732x_set_bias_level(struct snd_soc_codec *codec,
 	return 0;
 }
 
-static struct snd_soc_codec_driver soc_codec_dev_da732x = {
+static const struct snd_soc_codec_driver soc_codec_dev_da732x = {
 	.set_bias_level		= da732x_set_bias_level,
 	.component_driver = {
 		.controls		= da732x_snd_controls,
diff --git a/sound/soc/codecs/da9055.c b/sound/soc/codecs/da9055.c
index 4efb5f897a0c..bd7faaee5802 100644
--- a/sound/soc/codecs/da9055.c
+++ b/sound/soc/codecs/da9055.c
@@ -1451,7 +1451,7 @@ static int da9055_probe(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static struct snd_soc_codec_driver soc_codec_dev_da9055 = {
+static const struct snd_soc_codec_driver soc_codec_dev_da9055 = {
 	.probe			= da9055_probe,
 	.set_bias_level		= da9055_set_bias_level,
 
diff --git a/sound/soc/codecs/dmic.c b/sound/soc/codecs/dmic.c
index c82b9dc41e9a..6fe6c0ac4f0b 100644
--- a/sound/soc/codecs/dmic.c
+++ b/sound/soc/codecs/dmic.c
@@ -50,7 +50,7 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{"DMIC AIF", NULL, "DMic"},
 };
 
-static struct snd_soc_codec_driver soc_dmic = {
+static const struct snd_soc_codec_driver soc_dmic = {
 	.component_driver = {
 		.dapm_widgets		= dmic_dapm_widgets,
 		.num_dapm_widgets	= ARRAY_SIZE(dmic_dapm_widgets),
diff --git a/sound/soc/codecs/es7134.c b/sound/soc/codecs/es7134.c
index 25ede825d349..3869025754d8 100644
--- a/sound/soc/codecs/es7134.c
+++ b/sound/soc/codecs/es7134.c
@@ -69,7 +69,7 @@ static const struct snd_soc_dapm_route es7134_dapm_routes[] = {
 	{ "AOUTR", NULL, "DAC" },
 };
 
-static struct snd_soc_codec_driver es7134_codec_driver = {
+static const struct snd_soc_codec_driver es7134_codec_driver = {
 	.component_driver = {
 		.dapm_widgets		= es7134_dapm_widgets,
 		.num_dapm_widgets	= ARRAY_SIZE(es7134_dapm_widgets),
diff --git a/sound/soc/codecs/es8316.c b/sound/soc/codecs/es8316.c
index ecc02449c569..4f35af6a5d3a 100644
--- a/sound/soc/codecs/es8316.c
+++ b/sound/soc/codecs/es8316.c
@@ -554,7 +554,7 @@ static int es8316_probe(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static struct snd_soc_codec_driver soc_codec_dev_es8316 = {
+static const struct snd_soc_codec_driver soc_codec_dev_es8316 = {
 	.probe		= es8316_probe,
 	.idle_bias_off	= true,
 
diff --git a/sound/soc/codecs/es8328.c b/sound/soc/codecs/es8328.c
index ed7cc42d1ee2..bcdb8914ec16 100644
--- a/sound/soc/codecs/es8328.c
+++ b/sound/soc/codecs/es8328.c
@@ -830,7 +830,7 @@ const struct regmap_config es8328_regmap_config = {
 };
 EXPORT_SYMBOL_GPL(es8328_regmap_config);
 
-static struct snd_soc_codec_driver es8328_codec_driver = {
+static const struct snd_soc_codec_driver es8328_codec_driver = {
 	.probe		  = es8328_codec_probe,
 	.suspend	  = es8328_suspend,
 	.resume		  = es8328_resume,
diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index e6de50acefd4..e808f94bf8d1 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -1858,7 +1858,7 @@ static void hdmi_codec_complete(struct device *dev)
 #define hdmi_codec_complete NULL
 #endif
 
-static struct snd_soc_codec_driver hdmi_hda_codec = {
+static const struct snd_soc_codec_driver hdmi_hda_codec = {
 	.probe		= hdmi_codec_probe,
 	.remove		= hdmi_codec_remove,
 	.idle_bias_off	= true,
diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index 509ab513b4b2..f288404f0a61 100644
--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -733,7 +733,7 @@ static int hdmi_of_xlate_dai_id(struct snd_soc_component *component,
 	return ret;
 }
 
-static struct snd_soc_codec_driver hdmi_codec = {
+static const struct snd_soc_codec_driver hdmi_codec = {
 	.component_driver = {
 		.dapm_widgets		= hdmi_widgets,
 		.num_dapm_widgets	= ARRAY_SIZE(hdmi_widgets),
diff --git a/sound/soc/codecs/ics43432.c b/sound/soc/codecs/ics43432.c
index dd850b93938d..651206273f36 100644
--- a/sound/soc/codecs/ics43432.c
+++ b/sound/soc/codecs/ics43432.c
@@ -37,7 +37,7 @@ static struct snd_soc_dai_driver ics43432_dai = {
 	},
 };
 
-static struct snd_soc_codec_driver ics43432_codec_driver = {
+static const struct snd_soc_codec_driver ics43432_codec_driver = {
 };
 
 static int ics43432_probe(struct platform_device *pdev)
diff --git a/sound/soc/codecs/inno_rk3036.c b/sound/soc/codecs/inno_rk3036.c
index b918ba5c8ce5..64b0be94bea3 100644
--- a/sound/soc/codecs/inno_rk3036.c
+++ b/sound/soc/codecs/inno_rk3036.c
@@ -376,7 +376,7 @@ static int rk3036_codec_set_bias_level(struct snd_soc_codec *codec,
 	return 0;
 }
 
-static struct snd_soc_codec_driver rk3036_codec_driver = {
+static const struct snd_soc_codec_driver rk3036_codec_driver = {
 	.probe			= rk3036_codec_probe,
 	.remove			= rk3036_codec_remove,
 	.set_bias_level		= rk3036_codec_set_bias_level,
diff --git a/sound/soc/codecs/isabelle.c b/sound/soc/codecs/isabelle.c
index a4b0eded984a..5ca99280ae00 100644
--- a/sound/soc/codecs/isabelle.c
+++ b/sound/soc/codecs/isabelle.c
@@ -1087,7 +1087,7 @@ static struct snd_soc_dai_driver isabelle_dai[] = {
 	},
 };
 
-static struct snd_soc_codec_driver soc_codec_dev_isabelle = {
+static const struct snd_soc_codec_driver soc_codec_dev_isabelle = {
 	.set_bias_level = isabelle_set_bias_level,
 	.component_driver = {
 		.controls		= isabelle_snd_controls,
diff --git a/sound/soc/codecs/jz4740.c b/sound/soc/codecs/jz4740.c
index 0290fab383da..6324ccdc8a5c 100644
--- a/sound/soc/codecs/jz4740.c
+++ b/sound/soc/codecs/jz4740.c
@@ -293,7 +293,7 @@ static int jz4740_codec_dev_probe(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static struct snd_soc_codec_driver soc_codec_dev_jz4740_codec = {
+static const struct snd_soc_codec_driver soc_codec_dev_jz4740_codec = {
 	.probe = jz4740_codec_dev_probe,
 	.set_bias_level = jz4740_codec_set_bias_level,
 	.suspend_bias_off = true,
diff --git a/sound/soc/codecs/lm49453.c b/sound/soc/codecs/lm49453.c
index 8d413c2677cc..41e09d1287b8 100644
--- a/sound/soc/codecs/lm49453.c
+++ b/sound/soc/codecs/lm49453.c
@@ -1389,7 +1389,7 @@ static struct snd_soc_dai_driver lm49453_dai[] = {
 	},
 };
 
-static struct snd_soc_codec_driver soc_codec_dev_lm49453 = {
+static const struct snd_soc_codec_driver soc_codec_dev_lm49453 = {
 	.set_bias_level = lm49453_set_bias_level,
 	.component_driver = {
 		.controls		= lm49453_snd_controls,
diff --git a/sound/soc/codecs/max98088.c b/sound/soc/codecs/max98088.c
index 72f77455582e..f0bb830874e5 100644
--- a/sound/soc/codecs/max98088.c
+++ b/sound/soc/codecs/max98088.c
@@ -1698,7 +1698,7 @@ static int max98088_remove(struct snd_soc_codec *codec)
        return 0;
 }
 
-static struct snd_soc_codec_driver soc_codec_dev_max98088 = {
+static const struct snd_soc_codec_driver soc_codec_dev_max98088 = {
 	.probe   = max98088_probe,
 	.remove  = max98088_remove,
 	.set_bias_level = max98088_set_bias_level,
diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
index 66828480d484..13bcfb1ef9b4 100644
--- a/sound/soc/codecs/max98090.c
+++ b/sound/soc/codecs/max98090.c
@@ -2499,7 +2499,7 @@ static void max98090_seq_notifier(struct snd_soc_dapm_context *dapm,
 	}
 }
 
-static struct snd_soc_codec_driver soc_codec_dev_max98090 = {
+static const struct snd_soc_codec_driver soc_codec_dev_max98090 = {
 	.probe   = max98090_probe,
 	.remove  = max98090_remove,
 	.seq_notifier = max98090_seq_notifier,
diff --git a/sound/soc/codecs/max98095.c b/sound/soc/codecs/max98095.c
index 6f8a757876ed..5ead87d2ab1d 100644
--- a/sound/soc/codecs/max98095.c
+++ b/sound/soc/codecs/max98095.c
@@ -2102,7 +2102,7 @@ static int max98095_remove(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static struct snd_soc_codec_driver soc_codec_dev_max98095 = {
+static const struct snd_soc_codec_driver soc_codec_dev_max98095 = {
 	.probe   = max98095_probe,
 	.remove  = max98095_remove,
 	.suspend = max98095_suspend,
diff --git a/sound/soc/codecs/max98357a.c b/sound/soc/codecs/max98357a.c
index 6a6b68a4cb52..426ed2dae6ca 100644
--- a/sound/soc/codecs/max98357a.c
+++ b/sound/soc/codecs/max98357a.c
@@ -72,7 +72,7 @@ static int max98357a_codec_probe(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static struct snd_soc_codec_driver max98357a_codec_driver = {
+static const struct snd_soc_codec_driver max98357a_codec_driver = {
 	.probe			= max98357a_codec_probe,
 	.component_driver = {
 		.dapm_widgets		= max98357a_dapm_widgets,
diff --git a/sound/soc/codecs/max9850.c b/sound/soc/codecs/max9850.c
index 0610840733d1..a3dfc918c278 100644
--- a/sound/soc/codecs/max9850.c
+++ b/sound/soc/codecs/max9850.c
@@ -301,7 +301,7 @@ static int max9850_probe(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static struct snd_soc_codec_driver soc_codec_dev_max9850 = {
+static const struct snd_soc_codec_driver soc_codec_dev_max9850 = {
 	.probe =	max9850_probe,
 	.set_bias_level = max9850_set_bias_level,
 	.suspend_bias_off = true,
diff --git a/sound/soc/codecs/max9860.c b/sound/soc/codecs/max9860.c
index 499bdbfd0a2d..a2dc6a47f466 100644
--- a/sound/soc/codecs/max9860.c
+++ b/sound/soc/codecs/max9860.c
@@ -534,7 +534,7 @@ static int max9860_set_bias_level(struct snd_soc_codec *codec,
 	return 0;
 }
 
-static struct snd_soc_codec_driver max9860_codec_driver = {
+static const struct snd_soc_codec_driver max9860_codec_driver = {
 	.set_bias_level = max9860_set_bias_level,
 	.idle_bias_off = true,
 
diff --git a/sound/soc/codecs/max9867.c b/sound/soc/codecs/max9867.c
index 2a40a69a7513..6c0c0d6e8f3c 100644
--- a/sound/soc/codecs/max9867.c
+++ b/sound/soc/codecs/max9867.c
@@ -413,7 +413,7 @@ static int max9867_probe(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static struct snd_soc_codec_driver max9867_codec = {
+static const struct snd_soc_codec_driver max9867_codec = {
 	.probe = max9867_probe,
 	.component_driver = {
 		.controls		= max9867_snd_controls,
diff --git a/sound/soc/codecs/max98926.c b/sound/soc/codecs/max98926.c
index 1eff7e0b092e..7a39bfb9e0f9 100644
--- a/sound/soc/codecs/max98926.c
+++ b/sound/soc/codecs/max98926.c
@@ -496,7 +496,7 @@ static int max98926_probe(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static struct snd_soc_codec_driver soc_codec_dev_max98926 = {
+static const struct snd_soc_codec_driver soc_codec_dev_max98926 = {
 	.probe	= max98926_probe,
 	.component_driver = {
 		.controls		= max98926_snd_controls,
diff --git a/sound/soc/codecs/mc13783.c b/sound/soc/codecs/mc13783.c
index 90562703dcfd..4fd8d1dc4eef 100644
--- a/sound/soc/codecs/mc13783.c
+++ b/sound/soc/codecs/mc13783.c
@@ -733,7 +733,7 @@ static struct regmap *mc13783_get_regmap(struct device *dev)
 	return dev_get_regmap(dev->parent, NULL);
 }
 
-static struct snd_soc_codec_driver soc_codec_dev_mc13783 = {
+static const struct snd_soc_codec_driver soc_codec_dev_mc13783 = {
 	.probe		= mc13783_probe,
 	.remove		= mc13783_remove,
 	.get_regmap	= mc13783_get_regmap,
diff --git a/sound/soc/codecs/ml26124.c b/sound/soc/codecs/ml26124.c
index 69e5e18880c5..5cc960d8211e 100644
--- a/sound/soc/codecs/ml26124.c
+++ b/sound/soc/codecs/ml26124.c
@@ -537,7 +537,7 @@ static int ml26124_probe(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static struct snd_soc_codec_driver soc_codec_dev_ml26124 = {
+static const struct snd_soc_codec_driver soc_codec_dev_ml26124 = {
 	.probe =	ml26124_probe,
 	.set_bias_level = ml26124_set_bias_level,
 	.suspend_bias_off = true,
diff --git a/sound/soc/codecs/msm8916-wcd-analog.c b/sound/soc/codecs/msm8916-wcd-analog.c
index a78802920c3c..4cc52cecf3b7 100644
--- a/sound/soc/codecs/msm8916-wcd-analog.c
+++ b/sound/soc/codecs/msm8916-wcd-analog.c
@@ -785,7 +785,7 @@ static struct snd_soc_dai_driver pm8916_wcd_analog_dai[] = {
 	       },
 };
 
-static struct snd_soc_codec_driver pm8916_wcd_analog = {
+static const struct snd_soc_codec_driver pm8916_wcd_analog = {
 	.probe = pm8916_wcd_analog_probe,
 	.remove = pm8916_wcd_analog_remove,
 	.get_regmap = pm8916_get_regmap,
diff --git a/sound/soc/codecs/msm8916-wcd-digital.c b/sound/soc/codecs/msm8916-wcd-digital.c
index 661cd6dd5473..43a915c725a0 100644
--- a/sound/soc/codecs/msm8916-wcd-digital.c
+++ b/sound/soc/codecs/msm8916-wcd-digital.c
@@ -830,7 +830,7 @@ static struct snd_soc_dai_driver msm8916_wcd_digital_dai[] = {
 	       },
 };
 
-static struct snd_soc_codec_driver msm8916_wcd_digital = {
+static const struct snd_soc_codec_driver msm8916_wcd_digital = {
 	.probe = msm8916_wcd_digital_codec_probe,
 	.set_sysclk = msm8916_wcd_digital_codec_set_sysclk,
 	.component_driver = {
diff --git a/sound/soc/codecs/nau8540.c b/sound/soc/codecs/nau8540.c
index c8bcb1db966d..f9c9933acffb 100644
--- a/sound/soc/codecs/nau8540.c
+++ b/sound/soc/codecs/nau8540.c
@@ -735,7 +735,7 @@ static int __maybe_unused nau8540_resume(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static struct snd_soc_codec_driver nau8540_codec_driver = {
+static const struct snd_soc_codec_driver nau8540_codec_driver = {
 	.set_sysclk = nau8540_set_sysclk,
 	.set_pll = nau8540_set_pll,
 	.suspend = nau8540_suspend,
diff --git a/sound/soc/codecs/nau8810.c b/sound/soc/codecs/nau8810.c
index e45518629968..c8e2451ae0a3 100644
--- a/sound/soc/codecs/nau8810.c
+++ b/sound/soc/codecs/nau8810.c
@@ -808,7 +808,7 @@ static const struct regmap_config nau8810_regmap_config = {
 	.num_reg_defaults = ARRAY_SIZE(nau8810_reg_defaults),
 };
 
-static struct snd_soc_codec_driver nau8810_codec_driver = {
+static const struct snd_soc_codec_driver nau8810_codec_driver = {
 	.set_bias_level = nau8810_set_bias_level,
 	.suspend_bias_off = true,
 
diff --git a/sound/soc/codecs/nau8824.c b/sound/soc/codecs/nau8824.c
index 3a309b18035e..0240759f951c 100644
--- a/sound/soc/codecs/nau8824.c
+++ b/sound/soc/codecs/nau8824.c
@@ -1469,7 +1469,7 @@ static int __maybe_unused nau8824_resume(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static struct snd_soc_codec_driver nau8824_codec_driver = {
+static const struct snd_soc_codec_driver nau8824_codec_driver = {
 	.probe = nau8824_codec_probe,
 	.set_sysclk = nau8824_set_sysclk,
 	.set_pll = nau8824_set_pll,
diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
index 46a30eaa7ace..000aa79314fa 100644
--- a/sound/soc/codecs/nau8825.c
+++ b/sound/soc/codecs/nau8825.c
@@ -2388,7 +2388,7 @@ static int __maybe_unused nau8825_resume(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static struct snd_soc_codec_driver nau8825_codec_driver = {
+static const struct snd_soc_codec_driver nau8825_codec_driver = {
 	.probe = nau8825_codec_probe,
 	.remove = nau8825_codec_remove,
 	.set_sysclk = nau8825_set_sysclk,
diff --git a/sound/soc/codecs/pcm1681.c b/sound/soc/codecs/pcm1681.c
index 0b14efab6280..c7e28dd2e815 100644
--- a/sound/soc/codecs/pcm1681.c
+++ b/sound/soc/codecs/pcm1681.c
@@ -288,7 +288,7 @@ static const struct regmap_config pcm1681_regmap = {
 	.readable_reg		= pcm1681_accessible_reg,
 };
 
-static struct snd_soc_codec_driver soc_codec_dev_pcm1681 = {
+static const struct snd_soc_codec_driver soc_codec_dev_pcm1681 = {
 	.component_driver = {
 		.controls		= pcm1681_controls,
 		.num_controls		= ARRAY_SIZE(pcm1681_controls),
diff --git a/sound/soc/codecs/pcm179x.c b/sound/soc/codecs/pcm179x.c
index b813a154ddd9..82a3d9db32cb 100644
--- a/sound/soc/codecs/pcm179x.c
+++ b/sound/soc/codecs/pcm179x.c
@@ -205,7 +205,7 @@ const struct regmap_config pcm179x_regmap_config = {
 };
 EXPORT_SYMBOL_GPL(pcm179x_regmap_config);
 
-static struct snd_soc_codec_driver soc_codec_dev_pcm179x = {
+static const struct snd_soc_codec_driver soc_codec_dev_pcm179x = {
 	.component_driver = {
 		.controls		= pcm179x_controls,
 		.num_controls		= ARRAY_SIZE(pcm179x_controls),
diff --git a/sound/soc/codecs/pcm3008.c b/sound/soc/codecs/pcm3008.c
index 708af05486f6..e59d8ffb93bd 100644
--- a/sound/soc/codecs/pcm3008.c
+++ b/sound/soc/codecs/pcm3008.c
@@ -98,7 +98,7 @@ static struct snd_soc_dai_driver pcm3008_dai = {
 	},
 };
 
-static struct snd_soc_codec_driver soc_codec_dev_pcm3008 = {
+static const struct snd_soc_codec_driver soc_codec_dev_pcm3008 = {
 	.component_driver = {
 		.dapm_widgets		= pcm3008_dapm_widgets,
 		.num_dapm_widgets	= ARRAY_SIZE(pcm3008_dapm_widgets),
diff --git a/sound/soc/codecs/pcm512x.c b/sound/soc/codecs/pcm512x.c
index 72b19e62f626..f1005a31c709 100644
--- a/sound/soc/codecs/pcm512x.c
+++ b/sound/soc/codecs/pcm512x.c
@@ -1344,7 +1344,7 @@ static struct snd_soc_dai_driver pcm512x_dai = {
 	.ops = &pcm512x_dai_ops,
 };
 
-static struct snd_soc_codec_driver pcm512x_codec_driver = {
+static const struct snd_soc_codec_driver pcm512x_codec_driver = {
 	.set_bias_level = pcm512x_set_bias_level,
 	.idle_bias_off = true,
 
diff --git a/sound/soc/codecs/rt274.c b/sound/soc/codecs/rt274.c
index fb683ffc4e03..58cfe244f81e 100644
--- a/sound/soc/codecs/rt274.c
+++ b/sound/soc/codecs/rt274.c
@@ -1055,7 +1055,7 @@ static struct snd_soc_dai_driver rt274_dai[] = {
 	},
 };
 
-static struct snd_soc_codec_driver soc_codec_dev_rt274 = {
+static const struct snd_soc_codec_driver soc_codec_dev_rt274 = {
 	.probe = rt274_probe,
 	.remove = rt274_remove,
 	.suspend = rt274_suspend,
diff --git a/sound/soc/codecs/rt286.c b/sound/soc/codecs/rt286.c
index 7899a2cdeb42..af6325c78292 100644
--- a/sound/soc/codecs/rt286.c
+++ b/sound/soc/codecs/rt286.c
@@ -1046,7 +1046,7 @@ static struct snd_soc_dai_driver rt286_dai[] = {
 
 };
 
-static struct snd_soc_codec_driver soc_codec_dev_rt286 = {
+static const struct snd_soc_codec_driver soc_codec_dev_rt286 = {
 	.probe = rt286_probe,
 	.remove = rt286_remove,
 	.suspend = rt286_suspend,
diff --git a/sound/soc/codecs/rt298.c b/sound/soc/codecs/rt298.c
index d9e96e65e1c4..ce963768449f 100644
--- a/sound/soc/codecs/rt298.c
+++ b/sound/soc/codecs/rt298.c
@@ -1113,7 +1113,7 @@ static struct snd_soc_dai_driver rt298_dai[] = {
 
 };
 
-static struct snd_soc_codec_driver soc_codec_dev_rt298 = {
+static const struct snd_soc_codec_driver soc_codec_dev_rt298 = {
 	.probe = rt298_probe,
 	.remove = rt298_remove,
 	.suspend = rt298_suspend,
diff --git a/sound/soc/codecs/rt5514.c b/sound/soc/codecs/rt5514.c
index 1b6796c4c471..7a1b36f6596a 100644
--- a/sound/soc/codecs/rt5514.c
+++ b/sound/soc/codecs/rt5514.c
@@ -1042,7 +1042,7 @@ struct snd_soc_dai_driver rt5514_dai[] = {
 	}
 };
 
-static struct snd_soc_codec_driver soc_codec_dev_rt5514 = {
+static const struct snd_soc_codec_driver soc_codec_dev_rt5514 = {
 	.probe = rt5514_probe,
 	.idle_bias_off = true,
 	.set_bias_level = rt5514_set_bias_level,
diff --git a/sound/soc/codecs/rt5616.c b/sound/soc/codecs/rt5616.c
index 7d6e0823f98f..3c5f555ae6d0 100644
--- a/sound/soc/codecs/rt5616.c
+++ b/sound/soc/codecs/rt5616.c
@@ -1294,7 +1294,7 @@ static struct snd_soc_dai_driver rt5616_dai[] = {
 	},
 };
 
-static struct snd_soc_codec_driver soc_codec_dev_rt5616 = {
+static const struct snd_soc_codec_driver soc_codec_dev_rt5616 = {
 	.probe = rt5616_probe,
 	.suspend = rt5616_suspend,
 	.resume = rt5616_resume,
diff --git a/sound/soc/codecs/rt5631.c b/sound/soc/codecs/rt5631.c
index 0e418089c053..55b04c55fb4b 100644
--- a/sound/soc/codecs/rt5631.c
+++ b/sound/soc/codecs/rt5631.c
@@ -1653,7 +1653,7 @@ static struct snd_soc_dai_driver rt5631_dai[] = {
 	},
 };
 
-static struct snd_soc_codec_driver soc_codec_dev_rt5631 = {
+static const struct snd_soc_codec_driver soc_codec_dev_rt5631 = {
 	.probe = rt5631_probe,
 	.set_bias_level = rt5631_set_bias_level,
 	.suspend_bias_off = true,
diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index 1584ccc3a87b..438fe52a12df 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -2259,7 +2259,7 @@ static struct snd_soc_dai_driver rt5640_dai[] = {
 	},
 };
 
-static struct snd_soc_codec_driver soc_codec_dev_rt5640 = {
+static const struct snd_soc_codec_driver soc_codec_dev_rt5640 = {
 	.probe = rt5640_probe,
 	.remove = rt5640_remove,
 	.suspend = rt5640_suspend,
diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 9ec58166f7c4..ce31d0dcf894 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3473,7 +3473,7 @@ static struct snd_soc_dai_driver rt5645_dai[] = {
 	},
 };
 
-static struct snd_soc_codec_driver soc_codec_dev_rt5645 = {
+static const struct snd_soc_codec_driver soc_codec_dev_rt5645 = {
 	.probe = rt5645_probe,
 	.remove = rt5645_remove,
 	.suspend = rt5645_suspend,
diff --git a/sound/soc/codecs/rt5651.c b/sound/soc/codecs/rt5651.c
index db05b60d5002..da60b28ba3df 100644
--- a/sound/soc/codecs/rt5651.c
+++ b/sound/soc/codecs/rt5651.c
@@ -1664,7 +1664,7 @@ static struct snd_soc_dai_driver rt5651_dai[] = {
 	},
 };
 
-static struct snd_soc_codec_driver soc_codec_dev_rt5651 = {
+static const struct snd_soc_codec_driver soc_codec_dev_rt5651 = {
 	.probe = rt5651_probe,
 	.suspend = rt5651_suspend,
 	.resume = rt5651_resume,
diff --git a/sound/soc/codecs/rt5659.c b/sound/soc/codecs/rt5659.c
index 1b7060850340..e8018fce7e4b 100644
--- a/sound/soc/codecs/rt5659.c
+++ b/sound/soc/codecs/rt5659.c
@@ -3730,7 +3730,7 @@ static struct snd_soc_dai_driver rt5659_dai[] = {
 	},
 };
 
-static struct snd_soc_codec_driver soc_codec_dev_rt5659 = {
+static const struct snd_soc_codec_driver soc_codec_dev_rt5659 = {
 	.probe = rt5659_probe,
 	.remove = rt5659_remove,
 	.suspend = rt5659_suspend,
diff --git a/sound/soc/codecs/rt5660.c b/sound/soc/codecs/rt5660.c
index c93490d77f2a..d22ef00e0d96 100644
--- a/sound/soc/codecs/rt5660.c
+++ b/sound/soc/codecs/rt5660.c
@@ -1197,7 +1197,7 @@ static struct snd_soc_dai_driver rt5660_dai[] = {
 	},
 };
 
-static struct snd_soc_codec_driver soc_codec_dev_rt5660 = {
+static const struct snd_soc_codec_driver soc_codec_dev_rt5660 = {
 	.probe = rt5660_probe,
 	.remove = rt5660_remove,
 	.suspend = rt5660_suspend,
diff --git a/sound/soc/codecs/rt5663.c b/sound/soc/codecs/rt5663.c
index a33202affeb1..ebc5e3b2b62b 100644
--- a/sound/soc/codecs/rt5663.c
+++ b/sound/soc/codecs/rt5663.c
@@ -2891,7 +2891,7 @@ static struct snd_soc_dai_driver rt5663_dai[] = {
 	},
 };
 
-static struct snd_soc_codec_driver soc_codec_dev_rt5663 = {
+static const struct snd_soc_codec_driver soc_codec_dev_rt5663 = {
 	.probe = rt5663_probe,
 	.remove = rt5663_remove,
 	.suspend = rt5663_suspend,
diff --git a/sound/soc/codecs/rt5665.c b/sound/soc/codecs/rt5665.c
index 370ed54d1e15..2c405456d89f 100644
--- a/sound/soc/codecs/rt5665.c
+++ b/sound/soc/codecs/rt5665.c
@@ -4562,7 +4562,7 @@ static struct snd_soc_dai_driver rt5665_dai[] = {
 	},
 };
 
-static struct snd_soc_codec_driver soc_codec_dev_rt5665 = {
+static const struct snd_soc_codec_driver soc_codec_dev_rt5665 = {
 	.probe = rt5665_probe,
 	.remove = rt5665_remove,
 	.suspend = rt5665_suspend,
diff --git a/sound/soc/codecs/rt5670.c b/sound/soc/codecs/rt5670.c
index 0ec7985ed306..52a6ce8f0b39 100644
--- a/sound/soc/codecs/rt5670.c
+++ b/sound/soc/codecs/rt5670.c
@@ -2765,7 +2765,7 @@ static struct snd_soc_dai_driver rt5670_dai[] = {
 	},
 };
 
-static struct snd_soc_codec_driver soc_codec_dev_rt5670 = {
+static const struct snd_soc_codec_driver soc_codec_dev_rt5670 = {
 	.probe = rt5670_probe,
 	.remove = rt5670_remove,
 	.suspend = rt5670_suspend,
diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index 36e530a36c82..ce9b65d466e8 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -4968,7 +4968,7 @@ static struct snd_soc_dai_driver rt5677_dai[] = {
 	},
 };
 
-static struct snd_soc_codec_driver soc_codec_dev_rt5677 = {
+static const struct snd_soc_codec_driver soc_codec_dev_rt5677 = {
 	.probe = rt5677_probe,
 	.remove = rt5677_remove,
 	.suspend = rt5677_suspend,
diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index 8f6814c1eb6b..68e7020b2875 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -1248,7 +1248,7 @@ static int sgtl5000_remove(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static struct snd_soc_codec_driver sgtl5000_driver = {
+static const struct snd_soc_codec_driver sgtl5000_driver = {
 	.probe = sgtl5000_probe,
 	.remove = sgtl5000_remove,
 	.set_bias_level = sgtl5000_set_bias_level,
diff --git a/sound/soc/codecs/si476x.c b/sound/soc/codecs/si476x.c
index 5344f4aa8fde..354dc0d64f11 100644
--- a/sound/soc/codecs/si476x.c
+++ b/sound/soc/codecs/si476x.c
@@ -236,7 +236,7 @@ static struct regmap *si476x_get_regmap(struct device *dev)
 	return dev_get_regmap(dev->parent, NULL);
 }
 
-static struct snd_soc_codec_driver soc_codec_dev_si476x = {
+static const struct snd_soc_codec_driver soc_codec_dev_si476x = {
 	.get_regmap = si476x_get_regmap,
 	.component_driver = {
 		.dapm_widgets		= si476x_dapm_widgets,
diff --git a/sound/soc/codecs/sirf-audio-codec.c b/sound/soc/codecs/sirf-audio-codec.c
index 6bfd25c289d1..50bc22266ecb 100644
--- a/sound/soc/codecs/sirf-audio-codec.c
+++ b/sound/soc/codecs/sirf-audio-codec.c
@@ -429,7 +429,7 @@ static int sirf_audio_codec_remove(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static struct snd_soc_codec_driver soc_codec_device_sirf_audio_codec = {
+static const struct snd_soc_codec_driver soc_codec_device_sirf_audio_codec = {
 	.probe = sirf_audio_codec_probe,
 	.remove = sirf_audio_codec_remove,
 	.dapm_widgets = sirf_audio_codec_dapm_widgets,
diff --git a/sound/soc/codecs/sn95031.c b/sound/soc/codecs/sn95031.c
index eae54c37cff9..887923e68849 100644
--- a/sound/soc/codecs/sn95031.c
+++ b/sound/soc/codecs/sn95031.c
@@ -883,7 +883,7 @@ static int sn95031_codec_probe(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static struct snd_soc_codec_driver sn95031_codec = {
+static const struct snd_soc_codec_driver sn95031_codec = {
 	.probe		= sn95031_codec_probe,
 	.set_bias_level	= sn95031_set_vaud_bias,
 	.idle_bias_off	= true,
diff --git a/sound/soc/codecs/spdif_receiver.c b/sound/soc/codecs/spdif_receiver.c
index 234f87b54838..7acd05140a81 100644
--- a/sound/soc/codecs/spdif_receiver.c
+++ b/sound/soc/codecs/spdif_receiver.c
@@ -37,7 +37,7 @@ static const struct snd_soc_dapm_route dir_routes[] = {
 			SNDRV_PCM_FMTBIT_S24_LE | \
 			SNDRV_PCM_FMTBIT_IEC958_SUBFRAME_LE)
 
-static struct snd_soc_codec_driver soc_codec_spdif_dir = {
+static const struct snd_soc_codec_driver soc_codec_spdif_dir = {
 	.component_driver = {
 		.dapm_widgets		= dir_widgets,
 		.num_dapm_widgets	= ARRAY_SIZE(dir_widgets),
diff --git a/sound/soc/codecs/spdif_transmitter.c b/sound/soc/codecs/spdif_transmitter.c
index ee367536a498..063a64ff82d3 100644
--- a/sound/soc/codecs/spdif_transmitter.c
+++ b/sound/soc/codecs/spdif_transmitter.c
@@ -37,7 +37,7 @@ static const struct snd_soc_dapm_route dit_routes[] = {
 	{ "spdif-out", NULL, "Playback" },
 };
 
-static struct snd_soc_codec_driver soc_codec_spdif_dit = {
+static const struct snd_soc_codec_driver soc_codec_spdif_dit = {
 	.component_driver = {
 		.dapm_widgets		= dit_widgets,
 		.num_dapm_widgets	= ARRAY_SIZE(dit_widgets),
diff --git a/sound/soc/codecs/ssm2518.c b/sound/soc/codecs/ssm2518.c
index 38a85f3adc80..15486fd16269 100644
--- a/sound/soc/codecs/ssm2518.c
+++ b/sound/soc/codecs/ssm2518.c
@@ -710,7 +710,7 @@ static int ssm2518_set_sysclk(struct snd_soc_codec *codec, int clk_id,
 			SSM2518_POWER1_NO_BCLK, val);
 }
 
-static struct snd_soc_codec_driver ssm2518_codec_driver = {
+static const struct snd_soc_codec_driver ssm2518_codec_driver = {
 	.set_bias_level = ssm2518_set_bias_level,
 	.set_sysclk = ssm2518_set_sysclk,
 	.idle_bias_off = true,
diff --git a/sound/soc/codecs/ssm2602.c b/sound/soc/codecs/ssm2602.c
index 993bde29ca1b..9b341c23f62b 100644
--- a/sound/soc/codecs/ssm2602.c
+++ b/sound/soc/codecs/ssm2602.c
@@ -591,7 +591,7 @@ static int ssm260x_codec_probe(struct snd_soc_codec *codec)
 	return ret;
 }
 
-static struct snd_soc_codec_driver soc_codec_dev_ssm2602 = {
+static const struct snd_soc_codec_driver soc_codec_dev_ssm2602 = {
 	.probe =	ssm260x_codec_probe,
 	.resume =	ssm2602_resume,
 	.set_bias_level = ssm2602_set_bias_level,
diff --git a/sound/soc/codecs/ssm4567.c b/sound/soc/codecs/ssm4567.c
index a622623e8558..4afeddef7728 100644
--- a/sound/soc/codecs/ssm4567.c
+++ b/sound/soc/codecs/ssm4567.c
@@ -417,7 +417,7 @@ static struct snd_soc_dai_driver ssm4567_dai = {
 	.ops = &ssm4567_dai_ops,
 };
 
-static struct snd_soc_codec_driver ssm4567_codec_driver = {
+static const struct snd_soc_codec_driver ssm4567_codec_driver = {
 	.set_bias_level = ssm4567_set_bias_level,
 	.idle_bias_off = true,
 
diff --git a/sound/soc/codecs/stac9766.c b/sound/soc/codecs/stac9766.c
index 9de7fe8af255..c66363a2cac7 100644
--- a/sound/soc/codecs/stac9766.c
+++ b/sound/soc/codecs/stac9766.c
@@ -307,7 +307,7 @@ static int stac9766_codec_remove(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static struct snd_soc_codec_driver soc_codec_dev_stac9766 = {
+static const struct snd_soc_codec_driver soc_codec_dev_stac9766 = {
 	.component_driver = {
 		.controls		= stac9766_snd_ac97_controls,
 		.num_controls		= ARRAY_SIZE(stac9766_snd_ac97_controls),
diff --git a/sound/soc/codecs/tas2552.c b/sound/soc/codecs/tas2552.c
index 8840f72f3c4a..49cf9bc32eb6 100644
--- a/sound/soc/codecs/tas2552.c
+++ b/sound/soc/codecs/tas2552.c
@@ -660,7 +660,7 @@ static int tas2552_resume(struct snd_soc_codec *codec)
 #define tas2552_resume NULL
 #endif
 
-static struct snd_soc_codec_driver soc_codec_dev_tas2552 = {
+static const struct snd_soc_codec_driver soc_codec_dev_tas2552 = {
 	.probe = tas2552_codec_probe,
 	.remove = tas2552_codec_remove,
 	.suspend =	tas2552_suspend,
diff --git a/sound/soc/codecs/tas5086.c b/sound/soc/codecs/tas5086.c
index b7de857abb16..199272d5cb6a 100644
--- a/sound/soc/codecs/tas5086.c
+++ b/sound/soc/codecs/tas5086.c
@@ -885,7 +885,7 @@ static int tas5086_remove(struct snd_soc_codec *codec)
 	return 0;
 };
 
-static struct snd_soc_codec_driver soc_codec_dev_tas5086 = {
+static const struct snd_soc_codec_driver soc_codec_dev_tas5086 = {
 	.probe			= tas5086_probe,
 	.remove			= tas5086_remove,
 	.suspend		= tas5086_soc_suspend,
diff --git a/sound/soc/codecs/tas5720.c b/sound/soc/codecs/tas5720.c
index c65b917598d2..d14b78b1917b 100644
--- a/sound/soc/codecs/tas5720.c
+++ b/sound/soc/codecs/tas5720.c
@@ -483,7 +483,7 @@ static const struct snd_soc_dapm_route tas5720_audio_map[] = {
 	{ "OUT", NULL, "DAC" },
 };
 
-static struct snd_soc_codec_driver soc_codec_dev_tas5720 = {
+static const struct snd_soc_codec_driver soc_codec_dev_tas5720 = {
 	.probe = tas5720_codec_probe,
 	.remove = tas5720_codec_remove,
 	.suspend = tas5720_suspend,
diff --git a/sound/soc/codecs/tlv320aic23.c b/sound/soc/codecs/tlv320aic23.c
index 628a8eeaab68..3d42138a7974 100644
--- a/sound/soc/codecs/tlv320aic23.c
+++ b/sound/soc/codecs/tlv320aic23.c
@@ -576,7 +576,7 @@ static int tlv320aic23_codec_probe(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static struct snd_soc_codec_driver soc_codec_dev_tlv320aic23 = {
+static const struct snd_soc_codec_driver soc_codec_dev_tlv320aic23 = {
 	.probe = tlv320aic23_codec_probe,
 	.resume = tlv320aic23_resume,
 	.set_bias_level = tlv320aic23_set_bias_level,
diff --git a/sound/soc/codecs/tlv320aic26.c b/sound/soc/codecs/tlv320aic26.c
index 14aa96d41719..89421caaeb70 100644
--- a/sound/soc/codecs/tlv320aic26.c
+++ b/sound/soc/codecs/tlv320aic26.c
@@ -319,7 +319,7 @@ static int aic26_probe(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static struct snd_soc_codec_driver aic26_soc_codec_dev = {
+static const struct snd_soc_codec_driver aic26_soc_codec_dev = {
 	.probe = aic26_probe,
 	.component_driver = {
 		.controls		= aic26_snd_controls,
diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
index d7d03c92cb8a..54a87a905eb6 100644
--- a/sound/soc/codecs/tlv320aic31xx.c
+++ b/sound/soc/codecs/tlv320aic31xx.c
@@ -1185,7 +1185,7 @@ static int aic31xx_codec_remove(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static struct snd_soc_codec_driver soc_codec_driver_aic31xx = {
+static const struct snd_soc_codec_driver soc_codec_driver_aic31xx = {
 	.probe			= aic31xx_codec_probe,
 	.remove			= aic31xx_codec_remove,
 	.set_bias_level		= aic31xx_set_bias_level,
diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index 28fdfc5ec544..ccfc955321ae 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -792,7 +792,7 @@ static int aic32x4_codec_probe(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static struct snd_soc_codec_driver soc_codec_dev_aic32x4 = {
+static const struct snd_soc_codec_driver soc_codec_dev_aic32x4 = {
 	.probe = aic32x4_codec_probe,
 	.set_bias_level = aic32x4_set_bias_level,
 	.suspend_bias_off = true,
diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 29bf8c81ae02..405f4602888a 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -1684,7 +1684,7 @@ static int aic3x_remove(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static struct snd_soc_codec_driver soc_codec_dev_aic3x = {
+static const struct snd_soc_codec_driver soc_codec_dev_aic3x = {
 	.set_bias_level = aic3x_set_bias_level,
 	.idle_bias_off = true,
 	.probe = aic3x_probe,
diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
index 7bcf01efdf9a..5b94a151539c 100644
--- a/sound/soc/codecs/tlv320dac33.c
+++ b/sound/soc/codecs/tlv320dac33.c
@@ -1433,7 +1433,7 @@ static int dac33_soc_remove(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static struct snd_soc_codec_driver soc_codec_dev_tlv320dac33 = {
+static const struct snd_soc_codec_driver soc_codec_dev_tlv320dac33 = {
 	.read = dac33_read_reg_cache,
 	.write = dac33_write_locked,
 	.set_bias_level = dac33_set_bias_level,
diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index a2104d68169d..d439c4c6fe50 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -2191,7 +2191,7 @@ static int twl4030_soc_remove(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static struct snd_soc_codec_driver soc_codec_dev_twl4030 = {
+static const struct snd_soc_codec_driver soc_codec_dev_twl4030 = {
 	.probe = twl4030_soc_probe,
 	.remove = twl4030_soc_remove,
 	.read = twl4030_read,
diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index 2b6ad09e0886..0dc21f7e0af9 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -1155,7 +1155,7 @@ static int twl6040_remove(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static struct snd_soc_codec_driver soc_codec_dev_twl6040 = {
+static const struct snd_soc_codec_driver soc_codec_dev_twl6040 = {
 	.probe = twl6040_probe,
 	.remove = twl6040_remove,
 	.read = twl6040_read,
diff --git a/sound/soc/codecs/uda134x.c b/sound/soc/codecs/uda134x.c
index 5fdee874406d..77c9cc4467b8 100644
--- a/sound/soc/codecs/uda134x.c
+++ b/sound/soc/codecs/uda134x.c
@@ -518,7 +518,7 @@ static int uda134x_soc_probe(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static struct snd_soc_codec_driver soc_codec_dev_uda134x = {
+static const struct snd_soc_codec_driver soc_codec_dev_uda134x = {
 	.probe =        uda134x_soc_probe,
 	.set_bias_level = uda134x_set_bias_level,
 	.suspend_bias_off = true,
diff --git a/sound/soc/codecs/uda1380.c b/sound/soc/codecs/uda1380.c
index 61cdc79840e7..926c81ae8185 100644
--- a/sound/soc/codecs/uda1380.c
+++ b/sound/soc/codecs/uda1380.c
@@ -720,7 +720,7 @@ static int uda1380_probe(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static struct snd_soc_codec_driver soc_codec_dev_uda1380 = {
+static const struct snd_soc_codec_driver soc_codec_dev_uda1380 = {
 	.probe =	uda1380_probe,
 	.read =		uda1380_read_reg_cache,
 	.write =	uda1380_write,
diff --git a/sound/soc/codecs/wl1273.c b/sound/soc/codecs/wl1273.c
index fcffb6e707d9..942f1644973e 100644
--- a/sound/soc/codecs/wl1273.c
+++ b/sound/soc/codecs/wl1273.c
@@ -480,7 +480,7 @@ static int wl1273_remove(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static struct snd_soc_codec_driver soc_codec_dev_wl1273 = {
+static const struct snd_soc_codec_driver soc_codec_dev_wl1273 = {
 	.probe = wl1273_probe,
 	.remove = wl1273_remove,
 
diff --git a/sound/soc/codecs/zx_aud96p22.c b/sound/soc/codecs/zx_aud96p22.c
index 032fb7cf6cbd..36d0a7087a54 100644
--- a/sound/soc/codecs/zx_aud96p22.c
+++ b/sound/soc/codecs/zx_aud96p22.c
@@ -261,7 +261,7 @@ static const struct snd_soc_dapm_route aud96p22_dapm_routes[] = {
 	{ "LINEOUTMN", NULL, "LD2" },
 };
 
-static struct snd_soc_codec_driver aud96p22_driver = {
+static const struct snd_soc_codec_driver aud96p22_driver = {
 	.component_driver = {
 		.controls = aud96p22_snd_controls,
 		.num_controls = ARRAY_SIZE(aud96p22_snd_controls),
-- 
2.13.2
