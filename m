From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Sun, 28 Oct 2012 18:35:51 +0300
Subject: [PATCH 1/5] ARM: PXA: Add z2-usb-switch driver
Message-ID: <1351438555-4668-1-git-send-email-anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This driver controls mode of USB port #2 pins - device or host.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 arch/arm/mach-pxa/Kconfig  | 7 +++++++
 arch/arm/mach-pxa/Makefile | 1 +
 2 files changed, 8 insertions(+)

diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
index 11aa739..5fffc4b 100644
--- a/arch/arm/mach-pxa/Kconfig
+++ b/arch/arm/mach-pxa/Kconfig
@@ -630,6 +630,13 @@ config MACH_ZIPIT2
 	bool "Zipit Z2 Handheld"
 	select HAVE_PWM
 	select PXA27x
+
+config Z2_USB_SWITCH
+	tristate "Control the state of USB port on Zipit Z2"
+	depends on MACH_ZIPIT2
+	help
+	  This is a simple driver that is able to control
+	  usb mode of Zipit Z2
 endif
 endmenu
 
diff --git a/arch/arm/mach-pxa/Makefile b/arch/arm/mach-pxa/Makefile
index ee88d6e..86a032f 100644
--- a/arch/arm/mach-pxa/Makefile
+++ b/arch/arm/mach-pxa/Makefile
@@ -99,3 +99,4 @@ obj-$(CONFIG_MACH_RAUMFELD_SPEAKER)	+= raumfeld.o
 obj-$(CONFIG_MACH_ZIPIT2)	+= z2.o
 
 obj-$(CONFIG_TOSA_BT)		+= tosa-bt.o
+obj-$(CONFIG_Z2_USB_SWITCH)	+= z2-usb-switch.o
-- 
1.7.12.4
