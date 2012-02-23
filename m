From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 23 Feb 2012 14:47:22 +0800
Subject: [PATCH 2/4] ASoC: imx: move SND_SOC_AC97_BUS selection down to
 machine driver
In-Reply-To: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
References: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1329979644-31046-2-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SND_SOC_AC97_BUS is selected to enable the AC97 support in soc-core.
Rather than selecting the option under SND_IMX_SOC, it's better to
leave the selection to individual machine driver which knows if AC97
support is needed or not.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 sound/soc/imx/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/imx/Kconfig b/sound/soc/imx/Kconfig
index 17810d9..bca5d34 100644
--- a/sound/soc/imx/Kconfig
+++ b/sound/soc/imx/Kconfig
@@ -1,7 +1,6 @@
 menuconfig SND_IMX_SOC
 	tristate "SoC Audio for Freescale i.MX CPUs"
 	depends on ARCH_MXC
-	select SND_SOC_AC97_BUS
 	help
 	  Say Y or M if you want to add support for codecs attached to
 	  the i.MX SSI interface.
@@ -37,6 +36,7 @@ config SND_SOC_MX27VIS_AIC32X4
 config SND_SOC_PHYCORE_AC97
 	tristate "SoC Audio support for Phytec phyCORE (and phyCARD) boards"
 	depends on MACH_PCM043 || MACH_PCA100
+	select SND_SOC_AC97_BUS
 	select SND_SOC_WM9712
 	select SND_MXC_SOC_FIQ
 	help
-- 
1.7.5.4
