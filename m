From: richard.zhao@linaro.org (Richard Zhao)
Date: Thu, 2 Feb 2012 10:12:06 +0800
Subject: [PATCH v2 7/9] ARM: mxc: move audmux-v2 to sound/soc/imx
In-Reply-To: <1328148728-32258-1-git-send-email-richard.zhao@linaro.org>
References: <1328148728-32258-1-git-send-email-richard.zhao@linaro.org>
Message-ID: <1328148728-32258-8-git-send-email-richard.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's for clean up code under arch/arm.

audmux.h is shared with audmux-v1, leave it under mach/.

Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
---
 arch/arm/plat-mxc/Kconfig                        |    3 ---
 arch/arm/plat-mxc/Makefile                       |    1 -
 sound/soc/imx/Kconfig                            |    4 ++++
 sound/soc/imx/Makefile                           |    2 ++
 {arch/arm/plat-mxc => sound/soc/imx}/audmux-v2.c |    0
 5 files changed, 6 insertions(+), 4 deletions(-)
 rename {arch/arm/plat-mxc => sound/soc/imx}/audmux-v2.c (100%)

diff --git a/arch/arm/plat-mxc/Kconfig b/arch/arm/plat-mxc/Kconfig
index dcebb12..9e47d9c 100644
--- a/arch/arm/plat-mxc/Kconfig
+++ b/arch/arm/plat-mxc/Kconfig
@@ -91,9 +91,6 @@ config ARCH_MXC_IOMUX_V3
 config ARCH_MXC_AUDMUX_V1
 	bool
 
-config ARCH_MXC_AUDMUX_V2
-	bool
-
 config IRAM_ALLOC
 	bool
 	select GENERIC_ALLOCATOR
diff --git a/arch/arm/plat-mxc/Makefile b/arch/arm/plat-mxc/Makefile
index 076db84f..0cd5d8a 100644
--- a/arch/arm/plat-mxc/Makefile
+++ b/arch/arm/plat-mxc/Makefile
@@ -15,7 +15,6 @@ obj-$(CONFIG_MXC_PWM)  += pwm.o
 obj-$(CONFIG_MXC_ULPI) += ulpi.o
 obj-$(CONFIG_MXC_USE_EPIT) += epit.o
 obj-$(CONFIG_ARCH_MXC_AUDMUX_V1) += audmux-v1.o
-obj-$(CONFIG_ARCH_MXC_AUDMUX_V2) += audmux-v2.o
 obj-$(CONFIG_MXC_DEBUG_BOARD) += 3ds_debugboard.o
 obj-$(CONFIG_CPU_FREQ_IMX)    += cpufreq.o
 ifdef CONFIG_SND_IMX_SOC
diff --git a/sound/soc/imx/Kconfig b/sound/soc/imx/Kconfig
index 7383917..f9eb436 100644
--- a/sound/soc/imx/Kconfig
+++ b/sound/soc/imx/Kconfig
@@ -17,10 +17,14 @@ config SND_MXC_SOC_FIQ
 config SND_MXC_SOC_MX2
 	tristate
 
+config SND_MXC_SOC_AUDMUXV2
+	tristate
+
 config SND_MXC_SOC_WM1133_EV1
 	tristate "Audio on the the i.MX31ADS with WM1133-EV1 fitted"
 	depends on MACH_MX31ADS_WM1133_EV1 && EXPERIMENTAL
 	select SND_SOC_WM8350
+	select SND_MXC_SOC_AUDMUXV2
 	select SND_MXC_SOC_FIQ
 	help
 	  Enable support for audio on the i.MX31ADS with the WM1133-EV1
diff --git a/sound/soc/imx/Makefile b/sound/soc/imx/Makefile
index d6d609b..703ab5e 100644
--- a/sound/soc/imx/Makefile
+++ b/sound/soc/imx/Makefile
@@ -2,10 +2,12 @@
 snd-soc-imx-objs := imx-ssi.o
 snd-soc-imx-fiq-objs := imx-pcm-fiq.o
 snd-soc-imx-mx2-objs := imx-pcm-dma-mx2.o
+snd-soc-imx-audmuxv2-objs := audmux-v2.o
 
 obj-$(CONFIG_SND_IMX_SOC) += snd-soc-imx.o
 obj-$(CONFIG_SND_MXC_SOC_FIQ) += snd-soc-imx-fiq.o
 obj-$(CONFIG_SND_MXC_SOC_MX2) += snd-soc-imx-mx2.o
+obj-$(CONFIG_SND_MXC_SOC_AUDMUXV2) += snd-soc-imx-audmuxv2.o
 
 # i.MX Machine Support
 snd-soc-eukrea-tlv320-objs := eukrea-tlv320.o
diff --git a/arch/arm/plat-mxc/audmux-v2.c b/sound/soc/imx/audmux-v2.c
similarity index 100%
rename from arch/arm/plat-mxc/audmux-v2.c
rename to sound/soc/imx/audmux-v2.c
-- 
1.7.5.4
