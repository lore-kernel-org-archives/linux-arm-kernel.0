From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 23 Feb 2012 14:47:21 +0800
Subject: [PATCH 1/4] ASoC: imx: let SND_MXC_SOC_FIQ select FIQ
Message-ID: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CONFIG_FIQ is only needed when CONFIG_SND_MXC_SOC_FIQ is selected to
build imx-pcm-fiq.c, so let SND_MXC_SOC_FIQ select FIQ.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 sound/soc/imx/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/imx/Kconfig b/sound/soc/imx/Kconfig
index 91b66ef..17810d9 100644
--- a/sound/soc/imx/Kconfig
+++ b/sound/soc/imx/Kconfig
@@ -1,7 +1,6 @@
 menuconfig SND_IMX_SOC
 	tristate "SoC Audio for Freescale i.MX CPUs"
 	depends on ARCH_MXC
-	select FIQ
 	select SND_SOC_AC97_BUS
 	help
 	  Say Y or M if you want to add support for codecs attached to
@@ -12,6 +11,7 @@ if SND_IMX_SOC
 
 config SND_MXC_SOC_FIQ
 	tristate
+	select FIQ
 
 config SND_MXC_SOC_MX2
 	tristate
-- 
1.7.5.4
