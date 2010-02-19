From: wellsk40@gmail.com (wellsk40 at gmail.com)
Date: Fri, 19 Feb 2010 15:26:07 -0800
Subject: [PATCH 11/13] ARM: Add support for the LPC32XX arch
In-Reply-To: <1266621969-28847-1-git-send-email-wellsk40@gmail.com>
References: <1266621969-28847-1-git-send-email-wellsk40@gmail.com>
Message-ID: <1266621969-28847-12-git-send-email-wellsk40@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kevin Wells <wellsk40@gmail.com>

Add LPC32XX support in arch/arm/Kconfig and arch/arm/Makefile

Signed-off-by: Kevin Wells <wellsk40@gmail.com>
---
 arch/arm/Kconfig  |   15 +++++++++++++++
 arch/arm/Makefile |    1 +
 2 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index e4150f4..922dfb0 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -572,6 +572,19 @@ config ARCH_NUC93X
 	  Support for Nuvoton (Winbond logic dept.) NUC93X MCU,The NUC93X is a
 	  low-power and high performance MPEG-4/JPEG multimedia controller chip.
 
+config ARCH_LPC32XX
+	bool "NXP LPC32XX"
+	select CPU_ARM926T
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
@@ -809,6 +822,8 @@ source "arch/arm/mach-lh7a40x/Kconfig"
 
 source "arch/arm/mach-loki/Kconfig"
 
+source "arch/arm/mach-lpc32xx/Kconfig"
+
 source "arch/arm/mach-msm/Kconfig"
 
 source "arch/arm/mach-mv78xx0/Kconfig"
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index e471a96..181611c 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -139,6 +139,7 @@ machine-$(CONFIG_ARCH_KS8695)		:= ks8695
 machine-$(CONFIG_ARCH_L7200)		:= l7200
 machine-$(CONFIG_ARCH_LH7A40X)		:= lh7a40x
 machine-$(CONFIG_ARCH_LOKI) 		:= loki
+machine-$(CONFIG_ARCH_LPC32XX) 		:= lpc32xx
 machine-$(CONFIG_ARCH_MMP)		:= mmp
 machine-$(CONFIG_ARCH_MSM)		:= msm
 machine-$(CONFIG_ARCH_MV78XX0)		:= mv78xx0
-- 
1.6.6
