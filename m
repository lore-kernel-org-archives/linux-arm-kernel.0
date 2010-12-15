From: aaro.koskinen@nokia.com (Aaro Koskinen)
Date: Wed, 15 Dec 2010 14:49:11 +0200
Subject: [PATCH 1/2] arm: mach-omap2: Kconfig: fix incorrect option
Message-ID: <1292417352-18082-1-git-send-email-aaro.koskinen@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no MFD config option, MFD_SUPPORT should be selected instead.
This will prevent build errors when trying out different configurations.

Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
---
 arch/arm/mach-omap2/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index ab784bf..db20351 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -15,7 +15,7 @@ config ARCH_OMAP2PLUS_TYPICAL
 	select SERIAL_OMAP_CONSOLE
 	select I2C
 	select I2C_OMAP
-	select MFD
+	select MFD_SUPPORT
 	select MENELAUS if ARCH_OMAP2
 	select TWL4030_CORE if ARCH_OMAP3 || ARCH_OMAP4
 	select TWL4030_POWER if ARCH_OMAP3 || ARCH_OMAP4
-- 
1.5.6.5
