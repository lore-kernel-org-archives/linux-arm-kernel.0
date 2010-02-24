From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 24 Feb 2010 11:08:23 +0100
Subject: [PATCH 28/39] arm/imx/iomux-v1: rename source file and reorganize
	Kconfig stuff
In-Reply-To: <20100224100649.GA6456@pengutronix.de>
References: <20100224100649.GA6456@pengutronix.de>
Message-ID: <1267006114-31743-28-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/plat-mxc/Kconfig                         |    5 +++++
 arch/arm/plat-mxc/Makefile                        |    7 ++++---
 arch/arm/plat-mxc/{iomux-mx1-mx2.c => iomux-v1.c} |   11 +++++------
 3 files changed, 14 insertions(+), 9 deletions(-)
 rename arch/arm/plat-mxc/{iomux-mx1-mx2.c => iomux-v1.c} (96%)

diff --git a/arch/arm/plat-mxc/Kconfig b/arch/arm/plat-mxc/Kconfig
index 9c8d4e7..6debae2 100644
--- a/arch/arm/plat-mxc/Kconfig
+++ b/arch/arm/plat-mxc/Kconfig
@@ -9,12 +9,14 @@ choice
 config ARCH_MX1
 	bool "MX1-based"
 	select CPU_ARM920T
+	select IMX_HAVE_IOMUX_V1
 	help
 	  This enables support for systems based on the Freescale i.MX1 family
 
 config ARCH_MX2
 	bool "MX2-based"
 	select CPU_ARM926T
+	select IMX_HAVE_IOMUX_V1
 	help
 	  This enables support for systems based on the Freescale i.MX2 family
 
@@ -68,6 +70,9 @@ config MXC_ULPI
 config ARCH_HAS_RNGA
 	bool
 
+config IMX_HAVE_IOMUX_V1
+	bool
+
 config ARCH_MXC_IOMUX_V3
 	bool
 
diff --git a/arch/arm/plat-mxc/Makefile b/arch/arm/plat-mxc/Makefile
index 4074c18..41d3176 100644
--- a/arch/arm/plat-mxc/Makefile
+++ b/arch/arm/plat-mxc/Makefile
@@ -5,9 +5,10 @@
 # Common support
 obj-y := irq.o clock.o gpio.o time.o devices.o cpu.o system.o
 
-obj-$(CONFIG_ARCH_MX1) += iomux-mx1-mx2.o dma-mx1-mx2.o
-obj-$(CONFIG_ARCH_MX2) += iomux-mx1-mx2.o dma-mx1-mx2.o
-CFLAGS_iomux-mx1-mx2.o = -DIMX_NEEDS_DEPRECATED_SYMBOLS
+obj-$(CONFIG_ARCH_MX1) += dma-mx1-mx2.o
+obj-$(CONFIG_ARCH_MX2) += dma-mx1-mx2.o
+obj-$(CONFIG_IMX_HAVE_IOMUX_V1) += iomux-v1.o
+CFLAGS_iomux-v1.o = -DIMX_NEEDS_DEPRECATED_SYMBOLS
 obj-$(CONFIG_ARCH_MXC_IOMUX_V3) += iomux-v3.o
 obj-$(CONFIG_MXC_PWM)  += pwm.o
 obj-$(CONFIG_USB_EHCI_MXC) += ehci.o
diff --git a/arch/arm/plat-mxc/iomux-mx1-mx2.c b/arch/arm/plat-mxc/iomux-v1.c
similarity index 96%
rename from arch/arm/plat-mxc/iomux-mx1-mx2.c
rename to arch/arm/plat-mxc/iomux-v1.c
index a37163c..0b74568 100644
--- a/arch/arm/plat-mxc/iomux-mx1-mx2.c
+++ b/arch/arm/plat-mxc/iomux-v1.c
@@ -1,11 +1,11 @@
 /*
- *  arch/arm/mach-mxc/generic.c
+ * arch/arm/plat-mxc/iomux-v1.c
  *
- *  author: Sascha Hauer
- *  Created: april 20th, 2004
- *  Copyright: Synertronixx GmbH
+ * author: Sascha Hauer
+ * Created: april 20th, 2004
+ * Copyright: Synertronixx GmbH
  *
- *  Common code for i.MX machines
+ * Common code for i.MX1, i.MX21 and i.MX27
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -154,4 +154,3 @@ void mxc_gpio_release_multiple_pins(const int *pin_list, int count)
 
 }
 EXPORT_SYMBOL(mxc_gpio_release_multiple_pins);
-
-- 
1.6.6.2
