From: broonie@kernel.org (Mark Brown)
Date: Mon, 09 Jul 2018 12:27:36 +0100
Subject: Applied "ASoC: pxa: make SND_PXA_SOC_SSP depend on PLAT_PXA" to the
 asoc tree
In-Reply-To: <20180706133104.129049-1-arnd@arndb.de>
Message-ID: <E1fcUKO-0006Am-GV@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: pxa: make SND_PXA_SOC_SSP depend on PLAT_PXA

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

>From 9d1310daedae494874fe36a995172e64b06e29a4 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 6 Jul 2018 15:30:48 +0200
Subject: [PATCH] ASoC: pxa: make SND_PXA_SOC_SSP depend on PLAT_PXA

For the moment, we can't enable CONFIG_SND_PXA_SOC_SSP unless we are
building for ARM PXA or MMP:

WARNING: unmet direct dependencies detected for PXA_SSP
  Depends on [n]: PLAT_PXA [=n]
  Selected by [y]:
  - SND_PXA_SOC_SSP [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y]

This adds an explicit dependency for it.

Fixes: 0a94cf345740 ("ASoC: pxa: make SND_PXA2XX_SOC_I2S selectable")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/pxa/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/pxa/Kconfig b/sound/soc/pxa/Kconfig
index 2fc02c227f69..776e148b0aa2 100644
--- a/sound/soc/pxa/Kconfig
+++ b/sound/soc/pxa/Kconfig
@@ -34,6 +34,7 @@ config SND_PXA2XX_SOC_I2S
 
 config SND_PXA_SOC_SSP
 	tristate "Soc Audio via PXA2xx/PXA3xx SSP ports"
+	depends on PLAT_PXA
 	select PXA_SSP
 	select SND_PXA2XX_LIB
 
-- 
2.18.0.rc2
