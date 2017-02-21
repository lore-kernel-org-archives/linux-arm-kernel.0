From: broonie@kernel.org (Mark Brown)
Date: Tue, 21 Feb 2017 15:05:10 -0800
Subject: Applied "ASoC: mediatek: add I2C dependency for CS42XX8" to the asoc
 tree
In-Reply-To: <20170221220108.200734-1-arnd@arndb.de>
Message-ID: <E1cgJUc-0004l6-Gv@finisterre>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: mediatek: add I2C dependency for CS42XX8

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

>From 72cedf599fcebfd6cd2550274d7855838068d28c Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 21 Feb 2017 23:00:46 +0100
Subject: [PATCH] ASoC: mediatek: add I2C dependency for CS42XX8

We should not select drivers that depend on I2C when that is disabled,
as it results in a build error:

warning: (SND_SOC_MT2701_CS42448) selects SND_SOC_CS42XX8_I2C which has unmet direct dependencies (SOUND && !M68K && !UML && SND && SND_SOC && I2C)
sound/soc/codecs/cs42xx8-i2c.c:60:1: warning: data definition has no type or storage class
 module_i2c_driver(cs42xx8_i2c_driver);
sound/soc/codecs/cs42xx8-i2c.c:60:1: error: type defaults to 'int' in declaration of 'module_i2c_driver' [-Werror=implicit-int]

Fixes: 1f458d53f76c ("ASoC: mediatek: Add mt2701-cs42448 driver and config option.")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/mediatek/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/mediatek/Kconfig b/sound/soc/mediatek/Kconfig
index 05cf809cf9e1..d7013bde6f45 100644
--- a/sound/soc/mediatek/Kconfig
+++ b/sound/soc/mediatek/Kconfig
@@ -13,7 +13,7 @@ config SND_SOC_MT2701
 
 config SND_SOC_MT2701_CS42448
 	tristate "ASoc Audio driver for MT2701 with CS42448 codec"
-	depends on SND_SOC_MT2701
+	depends on SND_SOC_MT2701 && I2C
 	select SND_SOC_CS42XX8_I2C
 	select SND_SOC_BT_SCO
 	help
-- 
2.11.0
