From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 21 Apr 2012 23:57:18 +0800
Subject: [PATCH 6/8] ARM: mxs: switch to common clk framework
In-Reply-To: <1335023840-1394-1-git-send-email-shawn.guo@linaro.org>
References: <1335023840-1394-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1335023840-1394-7-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It switches mxs clock support to common clk framework based drivers.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/Kconfig           |    1 +
 arch/arm/mach-mxs/Makefile |    5 +----
 drivers/clk/Makefile       |    2 ++
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index cf006d4..60bdec7 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -468,6 +468,7 @@ config ARCH_MXS
 	select ARCH_REQUIRE_GPIOLIB
 	select CLKDEV_LOOKUP
 	select CLKSRC_MMIO
+	select COMMON_CLK
 	select HAVE_CLK_PREPARE
 	help
 	  Support for Freescale MXS-based family of processors
diff --git a/arch/arm/mach-mxs/Makefile b/arch/arm/mach-mxs/Makefile
index 908bf9a..6ce21a2 100644
--- a/arch/arm/mach-mxs/Makefile
+++ b/arch/arm/mach-mxs/Makefile
@@ -1,12 +1,9 @@
 # Common support
-obj-y := clock.o devices.o icoll.o iomux.o system.o timer.o mm.o
+obj-y := devices.o icoll.o iomux.o system.o timer.o mm.o
 
 obj-$(CONFIG_MXS_OCOTP) += ocotp.o
 obj-$(CONFIG_PM) += pm.o
 
-obj-$(CONFIG_SOC_IMX23) += clock-mx23.o
-obj-$(CONFIG_SOC_IMX28) += clock-mx28.o
-
 obj-$(CONFIG_MACH_STMP378X_DEVB) += mach-stmp378x_devb.o
 obj-$(CONFIG_MACH_MX23EVK) += mach-mx23evk.o
 obj-$(CONFIG_MACH_MX28EVK) += mach-mx28evk.o
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 24aa714..4a5bdbc 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -2,3 +2,5 @@
 obj-$(CONFIG_CLKDEV_LOOKUP)	+= clkdev.o
 obj-$(CONFIG_COMMON_CLK)	+= clk.o clk-fixed-rate.o clk-gate.o \
 				   clk-mux.o clk-divider.o clk-fixed-factor.o
+
+obj-$(CONFIG_ARCH_MXS)		+= mxs/
-- 
1.7.5.4
