From: broonie@kernel.org (Mark Brown)
Date: Wed, 08 Feb 2017 18:34:03 +0000
Subject: Applied "ASoC: sunxi: allow the analog codec driver to be built on
 ARM64" to the asoc tree
In-Reply-To: <20170126154859.55855-9-icenowy@aosc.xyz>
Message-ID: <E1cbX47-0000ia-Ks@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: sunxi: allow the analog codec driver to be built on ARM64

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

>From e5028a259733ec2324893cb481023ed6cf7e9723 Mon Sep 17 00:00:00 2001
From: Icenowy Zheng <icenowy@aosc.xyz>
Date: Wed, 8 Feb 2017 02:30:40 +0800
Subject: [PATCH] ASoC: sunxi: allow the analog codec driver to be built on
 ARM64

As the 64-bit Allwinner H5 SoC has the same analog codec part (also the
same digital part) as H3, enable the driver to be built on ARM64
Allwinner platform, so that it can be used on H5.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Acked-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sunxi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sunxi/Kconfig b/sound/soc/sunxi/Kconfig
index 13a8267f17c7..22408bc2d6ec 100644
--- a/sound/soc/sunxi/Kconfig
+++ b/sound/soc/sunxi/Kconfig
@@ -22,7 +22,7 @@ config SND_SUN8I_CODEC
 
 config SND_SUN8I_CODEC_ANALOG
 	tristate "Allwinner sun8i Codec Analog Controls Support"
-	depends on MACH_SUN8I || COMPILE_TEST
+	depends on MACH_SUN8I || (ARM64 && ARCH_SUNXI) || COMPILE_TEST
 	select REGMAP
 	help
 	  Say Y or M if you want to add support for the analog controls for
-- 
2.11.0
