From: pebolle@tiscali.nl (Paul Bolle)
Date: Sun, 16 Feb 2014 19:03:31 +0100
Subject: [PATCH] arm: imx: remove MACH_MXLADS
Message-ID: <1392573811.28866.22.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Kconfig symbol MACH_MXLADS was added in v2.6.29. It has never been
used. Setting it has no effect. There are no calls for
machine_is_mxlads(). This symbol can safely be removed.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
Tested with "git grep".

 arch/arm/mach-imx/Kconfig | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 33567aa..f564be8 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -144,14 +144,10 @@ config	SOC_IMX51
 if ARCH_MULTI_V4T
 
 comment "MX1 platforms:"
-config MACH_MXLADS
-	bool
-
 config ARCH_MX1ADS
 	bool "MX1ADS platform"
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_UART
-	select MACH_MXLADS
 	select SOC_IMX1
 	help
 	  Say Y here if you are using Motorola MX1ADS/MXLADS boards
-- 
1.8.5.3
