From: robherring2@gmail.com (Rob Herring)
Date: Thu, 16 May 2013 08:29:10 -0500
Subject: [PATCH] ARM: omap2: remove CONFIG_ARCH_OMAP2PLUS_TYPICAL
Message-ID: <1368710950-2306-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

CONFIG_ARCH_OMAP2PLUS_TYPICAL is selecting user defined features, not h/w
required options. This does not play well with multi-platform kernels and
belongs in a defconfig.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: linux-omap at vger.kernel.org
---
 arch/arm/mach-omap2/Kconfig | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index f49cd51..9d4b5f7 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -26,23 +26,6 @@ if ARCH_OMAP2PLUS
 
 menu "TI OMAP2/3/4 Specific Features"
 
-config ARCH_OMAP2PLUS_TYPICAL
-	bool "Typical OMAP configuration"
-	default y
-	select AEABI
-	select HIGHMEM
-	select I2C
-	select I2C_OMAP
-	select MENELAUS if ARCH_OMAP2
-	select NEON if ARCH_OMAP3 || ARCH_OMAP4 || SOC_OMAP5
-	select PM_RUNTIME
-	select REGULATOR
-	select TWL4030_CORE if ARCH_OMAP3 || ARCH_OMAP4
-	select TWL4030_POWER if ARCH_OMAP3 || ARCH_OMAP4
-	select VFP
-	help
-	  Compile a kernel suitable for booting most boards
-
 config SOC_HAS_OMAP2_SDRC
 	bool "OMAP2 SDRAM Controller support"
 
-- 
1.8.1.2
