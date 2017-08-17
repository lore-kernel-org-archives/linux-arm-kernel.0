From: broonie@kernel.org (Mark Brown)
Date: Thu, 17 Aug 2017 18:13:11 +0100
Subject: Applied "ASoC: cirrus: make snd_soc_ops const" to the asoc tree
In-Reply-To: <1502902770-3758-3-git-send-email-bhumirks@gmail.com>
Message-ID: <E1diOM3-0008Pg-Bn@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: cirrus: make snd_soc_ops const

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

>From 7f8159acecb3bb58c0d782813dc605ebef63b317 Mon Sep 17 00:00:00 2001
From: Bhumika Goyal <bhumirks@gmail.com>
Date: Wed, 16 Aug 2017 22:29:25 +0530
Subject: [PATCH] ASoC: cirrus: make snd_soc_ops const

Make these const as they are only stored in the ops field of a
snd_soc_dai_link structure, which is const.
Done using Coccinelle.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/cirrus/edb93xx.c     | 2 +-
 sound/soc/cirrus/snappercl15.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/cirrus/edb93xx.c b/sound/soc/cirrus/edb93xx.c
index 85962657aabe..c53bd6f2c2d7 100644
--- a/sound/soc/cirrus/edb93xx.c
+++ b/sound/soc/cirrus/edb93xx.c
@@ -56,7 +56,7 @@ static int edb93xx_hw_params(struct snd_pcm_substream *substream,
 				      SND_SOC_CLOCK_OUT);
 }
 
-static struct snd_soc_ops edb93xx_ops = {
+static const struct snd_soc_ops edb93xx_ops = {
 	.hw_params	= edb93xx_hw_params,
 };
 
diff --git a/sound/soc/cirrus/snappercl15.c b/sound/soc/cirrus/snappercl15.c
index 98089df08df6..2334ec19e7eb 100644
--- a/sound/soc/cirrus/snappercl15.c
+++ b/sound/soc/cirrus/snappercl15.c
@@ -45,7 +45,7 @@ static int snappercl15_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static struct snd_soc_ops snappercl15_ops = {
+static const struct snd_soc_ops snappercl15_ops = {
 	.hw_params	= snappercl15_hw_params,
 };
 
-- 
2.13.3
