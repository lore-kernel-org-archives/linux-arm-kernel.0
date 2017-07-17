From: broonie@kernel.org (Mark Brown)
Date: Mon, 17 Jul 2017 17:05:30 +0100
Subject: Applied "ASoC: sun8i-codec: constify snd_soc_dai_ops structure" to
 the asoc tree
In-Reply-To: <20170713055223.GA18940@embeddedgus>
Message-ID: <E1dX8WY-0004oV-5y@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: sun8i-codec: constify snd_soc_dai_ops structure

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

>From fe49cd980fc15cbb7eeb8d1a4ef45a14b807b55d Mon Sep 17 00:00:00 2001
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Date: Thu, 13 Jul 2017 00:52:23 -0500
Subject: [PATCH] ASoC: sun8i-codec: constify snd_soc_dai_ops structure

This structure is only stored in the ops field of a snd_soc_dai_driver
structure. That field is declared const, so snd_soc_dai_ops structures
that have this property can be declared as const also.

Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sunxi/sun8i-codec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-codec.c
index 5723c3404f6b..253ae0b5a4d4 100644
--- a/sound/soc/sunxi/sun8i-codec.c
+++ b/sound/soc/sunxi/sun8i-codec.c
@@ -341,7 +341,7 @@ static const struct snd_soc_dapm_route sun8i_codec_dapm_routes[] = {
 	  "AIF1 Slot 0 Right"},
 };
 
-static struct snd_soc_dai_ops sun8i_codec_dai_ops = {
+static const struct snd_soc_dai_ops sun8i_codec_dai_ops = {
 	.hw_params = sun8i_codec_hw_params,
 	.set_fmt = sun8i_set_fmt,
 };
-- 
2.13.2
