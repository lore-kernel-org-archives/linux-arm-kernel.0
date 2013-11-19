From: jsarha@ti.com (Jyri Sarha)
Date: Tue, 19 Nov 2013 14:12:26 +0200
Subject: [PATCH RFC 6/9] ASoC: davinci: HDMI audio build for AM33XX and TDA998x
In-Reply-To: <cover.1384862950.git.jsarha@ti.com>
References: <cover.1384862950.git.jsarha@ti.com>
Message-ID: <aa02019837565e4cce039f0b8e72ec22673e609f.1384862950.git.jsarha@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds configuration option for HDMI audio support for AM33XX based
boards with NXP TDA998x HDMI transmitter. The audio is connected to
NXP TDA998x trough McASP running in i2s mode.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 sound/soc/davinci/Kconfig  |   12 ++++++++++++
 sound/soc/davinci/Makefile |    1 +
 2 files changed, 13 insertions(+)

diff --git a/sound/soc/davinci/Kconfig b/sound/soc/davinci/Kconfig
index a8ec1fc..40dd5d1 100644
--- a/sound/soc/davinci/Kconfig
+++ b/sound/soc/davinci/Kconfig
@@ -26,6 +26,18 @@ config SND_AM33XX_SOC_EVM
 	  AM335X-EVMSK, and BeagelBone with AudioCape boards have this
 	  setup.
 
+config SND_AM335X_SOC_NXPTDA_EVM
+	tristate "HDMI Audio for the AM33XX chip based boards with TDA998x"
+	depends on SND_DAVINCI_SOC && SOC_AM33XX
+	depends on DRM_TILCDC && DRM_I2C_NXP_TDA998X
+	select SND_SOC_HDMI_CODEC
+	select SND_DAVINCI_SOC_MCASP
+	help
+	  Say Y or M if you want to add support for HDMI SoC audio on
+	  AM33XX boards with NXP TDA998x HDMI transmitter. For example
+	  BeagleBoneBack. The audio is connected to NXP TDA998x trough
+	  McASP running in i2s mode.
+
 config SND_DAVINCI_SOC_EVM
 	tristate "SoC Audio support for DaVinci DM6446, DM355 or DM365 EVM"
 	depends on SND_DAVINCI_SOC
diff --git a/sound/soc/davinci/Makefile b/sound/soc/davinci/Makefile
index 744d4d9..7587a70 100644
--- a/sound/soc/davinci/Makefile
+++ b/sound/soc/davinci/Makefile
@@ -13,3 +13,4 @@ obj-$(CONFIG_SND_DAVINCI_SOC_VCIF) += snd-soc-davinci-vcif.o
 snd-soc-evm-objs := davinci-evm.o
 
 obj-$(CONFIG_SND_DAVINCI_SOC_GENERIC_EVM) += snd-soc-evm.o
+obj-$(CONFIG_SND_AM335X_SOC_NXPTDA_EVM) += snd-soc-evm.o
-- 
1.7.9.5
