From: arnd@arndb.de (Arnd Bergmann)
Date: Fri,  6 Jul 2018 15:30:48 +0200
Subject: [PATCH] ASoC: pxa: make SND_PXA_SOC_SSP depend on PLAT_PXA
Message-ID: <20180706133104.129049-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For the moment, we can't enable CONFIG_SND_PXA_SOC_SSP unless we are
building for ARM PXA or MMP:

WARNING: unmet direct dependencies detected for PXA_SSP
  Depends on [n]: PLAT_PXA [=n]
  Selected by [y]:
  - SND_PXA_SOC_SSP [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y]

This adds an explicit dependency for it.

Fixes: 0a94cf345740 ("ASoC: pxa: make SND_PXA2XX_SOC_I2S selectable")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
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
2.9.0
