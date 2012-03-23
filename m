From: mathieu.poirier@linaro.org (mathieu.poirier at linaro.org)
Date: Fri, 23 Mar 2012 11:13:53 -0600
Subject: [PATCH 6/9] omap2: select twl4030 support on boards that need it
In-Reply-To: <1332522836-29517-1-git-send-email-mathieu.poirier@linaro.org>
References: <1332522836-29517-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1332522836-29517-7-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>

These three boards unconditionally use the twl4030 driver
from the board-zoom-display.c file. Make sure that the driver
is always there.
We also need to select the I2C core so we are able to build
that driver.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/Kconfig |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index e20c8ab..0279e9e 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -265,6 +265,9 @@ config MACH_OMAP_ZOOM2
 	select SERIAL_CORE_CONSOLE
 	select SERIAL_8250_CONSOLE
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
+	select TWL4030_CORE
+	select MFD_SUPPORT
+	select I2C
 
 config MACH_OMAP_ZOOM3
 	bool "OMAP3630 Zoom3 board"
@@ -275,6 +278,9 @@ config MACH_OMAP_ZOOM3
 	select SERIAL_CORE_CONSOLE
 	select SERIAL_8250_CONSOLE
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
+	select TWL4030_CORE
+	select MFD_SUPPORT
+	select I2C
 
 config MACH_CM_T35
 	bool "CompuLab CM-T35/CM-T3730 modules"
@@ -316,6 +322,9 @@ config MACH_OMAP_3630SDP
 	depends on ARCH_OMAP3
 	default y
 	select OMAP_PACKAGE_CBP
+	select TWL4030_CORE
+	select MFD_SUPPORT
+	select I2C
 
 config MACH_TI8168EVM
 	bool "TI8168 Evaluation Module"
-- 
1.7.5.4
