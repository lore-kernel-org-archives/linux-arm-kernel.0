From: broonie@kernel.org (Mark Brown)
Date: Mon,  5 Nov 2018 11:59:40 +0000 (GMT)
Subject: Applied "ASoC: sunxi: rename SND_SUNXI_ADDA_PR_REGMAP to
 SND_SUN8I_ADDA_PR_REGMAP" to the asoc tree
In-Reply-To: <20181103042651.6641-1-anarsoul@gmail.com>
Message-ID: <20181105115940.676651124D98@debutante.sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: sunxi: rename SND_SUNXI_ADDA_PR_REGMAP to SND_SUN8I_ADDA_PR_REGMAP

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 2f5d94123ce3c12a1e15802e6d5ee98f304ccb71 Mon Sep 17 00:00:00 2001
From: Vasily Khoruzhick <anarsoul@gmail.com>
Date: Fri, 2 Nov 2018 21:26:51 -0700
Subject: [PATCH] ASoC: sunxi: rename SND_SUNXI_ADDA_PR_REGMAP to
 SND_SUN8I_ADDA_PR_REGMAP

SND_SUN50I_CODEC_ANALOG selects SND_SUNXI_ADDA_PR_REGMAP which is leftover
of renaming SND_SUNXI_ADDA_PR_REGMAP to SND_SUN8I_ADDA_PR_REGMAP. Replace
it with SND_SUN8I_ADDA_PR_REGMAP to fix possible link errors for some
configurations:

sound/soc/sunxi/sun50i-codec-analog.o: In function `sun50i_codec_analog_probe':
sun50i-codec-analog.c:(.text+0x62): undefined reference to `sun8i_adda_pr_regmap_init'

Fixes: 42371f327df0 ("ASoC: sunxi: Add new driver for Allwinner A64 codec's analog path controls")
Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sunxi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sunxi/Kconfig b/sound/soc/sunxi/Kconfig
index 66aad0d3f9c7..8134c3c94229 100644
--- a/sound/soc/sunxi/Kconfig
+++ b/sound/soc/sunxi/Kconfig
@@ -31,7 +31,7 @@ config SND_SUN8I_CODEC_ANALOG
 config SND_SUN50I_CODEC_ANALOG
 	tristate "Allwinner sun50i Codec Analog Controls Support"
 	depends on (ARM64 && ARCH_SUNXI) || COMPILE_TEST
-	select SND_SUNXI_ADDA_PR_REGMAP
+	select SND_SUN8I_ADDA_PR_REGMAP
 	help
 	  Say Y or M if you want to add support for the analog controls for
 	  the codec embedded in Allwinner A64 SoC.
-- 
2.19.0.rc2
