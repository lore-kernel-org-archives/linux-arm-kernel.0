From: tony@atomide.com (Tony Lindgren)
Date: Mon, 22 Oct 2012 13:34:07 -0700
Subject: [PATCH 1/2] ARM: OMAP2+: Fix location of select PINCTRL
In-Reply-To: <20121022203324.22746.54210.stgit@muffinssi.local>
References: <20121022203324.22746.54210.stgit@muffinssi.local>
Message-ID: <20121022203407.22746.69088.stgit@muffinssi.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 8f31cefe (ARM: OMAP2+: select PINCTRL in Kconfig)
added select PINCTRL, but accdentally added it to a wrong
location.

We want to select if for ARCH_OMAP2PLUS, not for
ARCH_OMAP2PLUS_TYPICAL.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 0 files changed

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 2a1a898..d669e22 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -11,7 +11,6 @@ config ARCH_OMAP2PLUS_TYPICAL
 	select I2C_OMAP
 	select MENELAUS if ARCH_OMAP2
 	select NEON if ARCH_OMAP3 || ARCH_OMAP4 || SOC_OMAP5
-	select PINCTRL
 	select PM_RUNTIME
 	select REGULATOR
 	select SERIAL_OMAP
diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index 7cd56ed..82fcb20 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -26,6 +26,7 @@ config ARCH_OMAP2PLUS
 	select CLKDEV_LOOKUP
 	select GENERIC_IRQ_CHIP
 	select OMAP_DM_TIMER
+	select PINCTRL
 	select PROC_DEVICETREE if PROC_FS
 	select SPARSE_IRQ
 	select USE_OF
