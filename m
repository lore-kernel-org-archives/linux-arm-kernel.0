From: wellsk40@gmail.com (wellsk40 at gmail.com)
Date: Wed, 27 Jan 2010 17:43:22 -0800
Subject: [PATCH 04/13] ARM: LPC32XX arch support in Kconfig and Makefile
In-Reply-To: <1264643011-17390-1-git-send-email-wellsk40@gmail.com>
References: <1264643011-17390-1-git-send-email-wellsk40@gmail.com>
Message-ID: <1264643011-17390-5-git-send-email-wellsk40@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kevin Wells <wellsk40@gmail.com>

Added support and default config flags in Kconfig for the LCP32XX
arch. Updated the Makefile to include the mach-lpc32xx dir when
the ARCH_LCP32XX arch is selected.

Signed-off-by: Kevin Wells <wellsk40@gmail.com>
---
 arch/arm/Kconfig  |   16 ++++++++++++++++
 arch/arm/Makefile |    1 +
 2 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 4c33ca8..cc2dbf9 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -550,6 +550,20 @@ config ARCH_W90X900
 	  <http://www.nuvoton.com/hq/enu/ProductAndSales/ProductLines/
 		ConsumerElectronicsIC/ARMMicrocontroller/ARMMicrocontroller>
 
+config ARCH_LPC32XX
+	bool "NXP LPC32XX"
+	select CPU_ARM926T
+	select ARCH_REQUIRE_GPIOLIB
+	select GENERIC_GPIO
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
@@ -771,6 +785,8 @@ source "arch/arm/mach-lh7a40x/Kconfig"
 
 source "arch/arm/mach-loki/Kconfig"
 
+source "arch/arm/mach-lpc32xx/Kconfig"
+
 source "arch/arm/mach-msm/Kconfig"
 
 source "arch/arm/mach-mv78xx0/Kconfig"
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 9e75825..b6ec4f7 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -139,6 +139,7 @@ machine-$(CONFIG_ARCH_KS8695)		:= ks8695
 machine-$(CONFIG_ARCH_L7200)		:= l7200
 machine-$(CONFIG_ARCH_LH7A40X)		:= lh7a40x
 machine-$(CONFIG_ARCH_LOKI) 		:= loki
+machine-$(CONFIG_ARCH_LPC32XX)		:= lpc32xx
 machine-$(CONFIG_ARCH_MMP)		:= mmp
 machine-$(CONFIG_ARCH_MSM)		:= msm
 machine-$(CONFIG_ARCH_MV78XX0)		:= mv78xx0
-- 
1.6.6
