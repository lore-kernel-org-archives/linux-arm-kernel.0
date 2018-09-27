From: broonie@kernel.org (Mark Brown)
Date: Thu, 27 Sep 2018 23:39:38 +0100 (BST)
Subject: Applied "ASoC: atmel: add SND_SOC_I2C_AND_SPI dependency" to the asoc
 tree
In-Reply-To: <20180926125957.2256982-1-arnd@arndb.de>
Message-ID: <20180927223938.753FF440078@finisterre.ee.mobilebroadband>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: atmel: add SND_SOC_I2C_AND_SPI dependency

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

>From 53c156ab9d8aae2083d3c895365a3e39b864a5a7 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 26 Sep 2018 14:59:40 +0200
Subject: [PATCH] ASoC: atmel: add SND_SOC_I2C_AND_SPI dependency

Selecting SND_SOC_WM8731 is only allowed when all its dependencies
are already there:

WARNING: unmet direct dependencies detected for SND_SOC_WM8731
  Depends on [m]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_SOC_I2C_AND_SPI [=m]
  Selected by [y]:
  - SND_SOC_MIKROE_PROTO [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_ATMEL_SOC [=y] && OF [=y]
  Selected by [m]:
  - SND_AT91_SOC_SAM9X5_WM8731 [=m] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_ATMEL_SOC [=y] && (ARCH_AT91 [=y] || COMPILE_TEST [=y]) && ATMEL_SSC [=y] && SND_SOC_I2C_AND_SPI [=m]
  - SND_SOC_ALL_CODECS [=m] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && COMPILE_TEST [=y] && SND_SOC_I2C_AND_SPI [=m]

Fixes: a45f8853a5f9 ("ASoC: Add driver for PROTO Audio CODEC (with a WM8731)")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/atmel/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/atmel/Kconfig b/sound/soc/atmel/Kconfig
index 81a0712d4f14..64f86f0b87e5 100644
--- a/sound/soc/atmel/Kconfig
+++ b/sound/soc/atmel/Kconfig
@@ -101,6 +101,7 @@ config SND_ATMEL_SOC_I2S
 config SND_SOC_MIKROE_PROTO
 	tristate "Support for Mikroe-PROTO board"
 	depends on OF
+	depends on SND_SOC_I2C_AND_SPI
 	select SND_SOC_WM8731
 	help
 	  Say Y or M if you want to add support for MikroElektronika PROTO Audio
-- 
2.19.0
