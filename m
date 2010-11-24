From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Wed, 24 Nov 2010 12:04:50 +0200
Subject: [PATCH] omap: boards w/ wl12xx should select REGULATOR_FIXED_VOLTAGE
Message-ID: <1290593090-6288-1-git-send-email-ohad@wizery.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Power to the wl12xx wlan device is controlled by a fixed regulator.

Boards that have the wl12xx should select REGULATOR_FIXED_VOLTAGE so
users will not be baffled.

Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
---
 arch/arm/mach-omap2/Kconfig |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index fc3a181..cc386da 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -190,6 +190,7 @@ config MACH_OMAP3_PANDORA
 	depends on ARCH_OMAP3
 	default y
 	select OMAP_PACKAGE_CBB
+	select REGULATOR_FIXED_VOLTAGE
 
 config MACH_OMAP3_TOUCHBOOK
 	bool "OMAP3 Touch Book"
@@ -235,6 +236,7 @@ config MACH_OMAP_ZOOM2
 	select SERIAL_8250
 	select SERIAL_CORE_CONSOLE
 	select SERIAL_8250_CONSOLE
+	select REGULATOR_FIXED_VOLTAGE
 
 config MACH_OMAP_ZOOM3
 	bool "OMAP3630 Zoom3 board"
@@ -244,6 +246,7 @@ config MACH_OMAP_ZOOM3
 	select SERIAL_8250
 	select SERIAL_CORE_CONSOLE
 	select SERIAL_8250_CONSOLE
+	select REGULATOR_FIXED_VOLTAGE
 
 config MACH_CM_T35
 	bool "CompuLab CM-T35 module"
-- 
1.7.0.4
