From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 28 Apr 2014 16:46:30 +0200
Subject: [PATCH] ASoC: fsl: select SND_SOC_IMX_PCM_DMA where needed
Message-ID: <6606961.lAGLvkNsEj@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since commit 204dec93eaa "ASoC: fsl: Allow to select individual common
options", it is possible to enable SND_SOC_FSL_SSI and SND_SOC_FSL_SPDIF
manually. However, these two options are for drivers that both
require the imx-pcm-dma framework and result in a link error if that
is not provided.

This changes Kconfig to automatically select SND_SOC_IMX_PCM_DMA
to avoid the problem, as we do for other drivers that need the same
framework.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index fb26345..25abd21 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -9,6 +9,7 @@ config SND_SOC_FSL_SAI
 
 config SND_SOC_FSL_SSI
 	tristate "Synchronous Serial Interface module support"
+	select SND_SOC_IMX_PCM_DMA
 	help
 	  Say Y if you want to add Synchronous Serial Interface (SSI)
 	  support for the Freescale CPUs.
@@ -17,6 +18,7 @@ config SND_SOC_FSL_SSI
 
 config SND_SOC_FSL_SPDIF
 	tristate "Sony/Philips Digital Interface module support"
+	select SND_SOC_IMX_PCM_DMA
 	select REGMAP_MMIO
 	help
 	  Say Y if you want to add Sony/Philips Digital Interface (SPDIF)
