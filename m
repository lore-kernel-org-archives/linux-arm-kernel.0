From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 20 Feb 2012 15:05:24 +0800
Subject: [PATCH] ASoC: imx/mxs: remove redundant SND_PCM selection
Message-ID: <1329721524-28394-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SND_PCM is already selected by SND_SOC, there is no need for
SND_IMX_SOC and SND_MXS_SOC to select it again.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 sound/soc/imx/Kconfig |    1 -
 sound/soc/mxs/Kconfig |    1 -
 2 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/sound/soc/imx/Kconfig b/sound/soc/imx/Kconfig
index 7383917..91b66ef 100644
--- a/sound/soc/imx/Kconfig
+++ b/sound/soc/imx/Kconfig
@@ -1,7 +1,6 @@
 menuconfig SND_IMX_SOC
 	tristate "SoC Audio for Freescale i.MX CPUs"
 	depends on ARCH_MXC
-	select SND_PCM
 	select FIQ
 	select SND_SOC_AC97_BUS
 	help
diff --git a/sound/soc/mxs/Kconfig b/sound/soc/mxs/Kconfig
index e4ba8d5..21d20f3 100644
--- a/sound/soc/mxs/Kconfig
+++ b/sound/soc/mxs/Kconfig
@@ -1,7 +1,6 @@
 menuconfig SND_MXS_SOC
 	tristate "SoC Audio for Freescale MXS CPUs"
 	depends on ARCH_MXS
-	select SND_PCM
 	help
 	  Say Y or M if you want to add support for codecs attached to
 	  the MXS SAIF interface.
-- 
1.7.5.4
