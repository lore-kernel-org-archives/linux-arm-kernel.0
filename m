From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Fri,  1 Oct 2010 14:29:29 -0700
Subject: [PATCH 05/47] davinci: clean up inconsistent usage of spaces in
	Kconfig
In-Reply-To: <1285968611-26890-1-git-send-email-khilman@deeprootsystems.com>
References: <1285968611-26890-1-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1285968611-26890-6-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sekhar Nori <nsekhar@ti.com>

In arch/arm/mach-davinci/Kconfig, some of the configuration
items are indented with multiple spaces instead of tabs.

Also, in couple of places, two spaces are used in the middle
of help text where one should do.

This patch fixes both issues.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/Kconfig |   32 ++++++++++++++++----------------
 1 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-davinci/Kconfig b/arch/arm/mach-davinci/Kconfig
index 71f90f8..b291da1 100644
--- a/arch/arm/mach-davinci/Kconfig
+++ b/arch/arm/mach-davinci/Kconfig
@@ -20,17 +20,17 @@ config ARCH_DAVINCI_DM644x
 	select ARCH_DAVINCI_DMx
 
 config ARCH_DAVINCI_DM355
-        bool "DaVinci 355 based system"
+	bool "DaVinci 355 based system"
 	select AINTC
 	select ARCH_DAVINCI_DMx
 
 config ARCH_DAVINCI_DM646x
-        bool "DaVinci 646x based system"
+	bool "DaVinci 646x based system"
 	select AINTC
 	select ARCH_DAVINCI_DMx
 
 config ARCH_DAVINCI_DA830
-        bool "DA830/OMAP-L137 based system"
+	bool "DA830/OMAP-L137 based system"
 	select CP_INTC
 	select ARCH_DAVINCI_DA8XX
 	select CPU_DCACHE_WRITETHROUGH # needed on silicon revs 1.0, 1.1
@@ -140,7 +140,7 @@ config DA830_UI_LCD
 config DA830_UI_NAND
 	bool "NAND flash"
 	help
-	  Say Y here to use the NAND flash.  Do not forget to setup
+	  Say Y here to use the NAND flash. Do not forget to setup
 	  the switch correctly.
 endchoice
 
@@ -195,20 +195,20 @@ config DAVINCI_MUX
 	  say Y.
 
 config DAVINCI_MUX_DEBUG
-        bool "Multiplexing debug output"
-        depends on DAVINCI_MUX
-        help
-          Makes the multiplexing functions print out a lot of debug info.
-          This is useful if you want to find out the correct values of the
-          multiplexing registers.
+	bool "Multiplexing debug output"
+	depends on DAVINCI_MUX
+	help
+	  Makes the multiplexing functions print out a lot of debug info.
+	  This is useful if you want to find out the correct values of the
+	  multiplexing registers.
 
 config DAVINCI_MUX_WARNINGS
-        bool "Warn about pins the bootloader didn't set up"
-        depends on DAVINCI_MUX
-        help
-          Choose Y here to warn whenever driver initialization logic needs
-          to change the pin multiplexing setup.  When there are no warnings
-          printed, it's safe to deselect DAVINCI_MUX for your product.
+	bool "Warn about pins the bootloader didn't set up"
+	depends on DAVINCI_MUX
+	help
+	  Choose Y here to warn whenever driver initialization logic needs
+	  to change the pin multiplexing setup. When there are no warnings
+	  printed, it's safe to deselect DAVINCI_MUX for your product.
 
 config DAVINCI_RESET_CLOCKS
 	bool "Reset unused clocks during boot"
-- 
1.7.2.1
