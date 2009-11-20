From: kevin.wells@nxp.com (Kevin Wells)
Date: Fri, 20 Nov 2009 02:11:14 +0100
Subject: RFC [PATCH 1/9] Added support for lpc32xx based platforms
Message-ID: <083DF309106F364B939360100EC290F804F54D560A@eu1rdcrdc1wx030.exi.nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Added support for lpc32xx based platforms

Signed-off-by: Kevin Wells <kevin.wells@nxp.com>
---
 arch/arm/Kconfig  |   16 ++++++++++++++++
 arch/arm/Makefile |    1 +
 2 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 1c4119c..1160e64 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -537,6 +537,20 @@ config ARCH_W90X900
 	  <http://www.nuvoton.com/hq/enu/ProductAndSales/ProductLines/
 		ConsumerElectronicsIC/ARMMicrocontroller/ARMMicrocontroller>
 
+config ARCH_LPC32XX
+	bool "NXP LPC32XX"
+	select CPU_ARM926T
+	select GENERIC_GPIO
+	select ARCH_REQUIRE_GPIOLIB
+	select HAVE_IDE
+	select ARM_AMBA
+	select USB_ARCH_HAS_OHCI
+	select COMMON_CLKDEV
+	select GENERIC_TIME
+	select GENERIC_CLOCKEVENTS
+	help
+	  Support for the NXP LPC32XX family of processors
+
 config ARCH_PNX4008
 	bool "Philips Nexperia PNX4008 Mobile"
 	select CPU_ARM926T
@@ -804,6 +818,8 @@ source "arch/arm/mach-w90x900/Kconfig"
 
 source "arch/arm/mach-bcmring/Kconfig"
 
+source "arch/arm/mach-lpc32xx/Kconfig"
+
 # Definitions to make life easier
 config ARCH_ACORN
 	bool
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index a73caaf..7e5a1f4 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -138,6 +138,7 @@ machine-$(CONFIG_ARCH_KS8695)		:= ks8695
 machine-$(CONFIG_ARCH_L7200)		:= l7200
 machine-$(CONFIG_ARCH_LH7A40X)		:= lh7a40x
 machine-$(CONFIG_ARCH_LOKI) 		:= loki
+machine-$(CONFIG_ARCH_LPC32XX)		:= lpc32xx
 machine-$(CONFIG_ARCH_MMP)		:= mmp
 machine-$(CONFIG_ARCH_MSM)		:= msm
 machine-$(CONFIG_ARCH_MV78XX0)		:= mv78xx0
-- 
1.6.0.6
