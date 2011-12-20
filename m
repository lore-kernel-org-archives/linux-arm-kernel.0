From: felipe.contreras@gmail.com (Felipe Contreras)
Date: Tue, 20 Dec 2011 02:42:21 +0200
Subject: [PATCH 04/10] arm: omap2: fix regulator warnings
In-Reply-To: <1324341747-5922-1-git-send-email-felipe.contreras@gmail.com>
References: <1324341747-5922-1-git-send-email-felipe.contreras@gmail.com>
Message-ID: <1324341747-5922-5-git-send-email-felipe.contreras@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

warning: (MACH_OMAP_ZOOM2 && MACH_OMAP_ZOOM3 && MACH_OMAP_4430SDP && MACH_OMAP4_PANDA && TPS6105X) selects REGULATOR_FIXED_VOLTAGE which has unmet direct dependencies (REGULATOR)

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 arch/arm/mach-omap2/Kconfig |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index dbecb9a..04734b5 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -205,7 +205,7 @@ config MACH_OMAP3_PANDORA
 	depends on ARCH_OMAP3
 	default y
 	select OMAP_PACKAGE_CBB
-	select REGULATOR_FIXED_VOLTAGE
+	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 
 config MACH_OMAP3_TOUCHBOOK
 	bool "OMAP3 Touch Book"
@@ -256,7 +256,7 @@ config MACH_OMAP_ZOOM2
 	select SERIAL_8250
 	select SERIAL_CORE_CONSOLE
 	select SERIAL_8250_CONSOLE
-	select REGULATOR_FIXED_VOLTAGE
+	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 
 config MACH_OMAP_ZOOM3
 	bool "OMAP3630 Zoom3 board"
@@ -266,7 +266,7 @@ config MACH_OMAP_ZOOM3
 	select SERIAL_8250
 	select SERIAL_CORE_CONSOLE
 	select SERIAL_8250_CONSOLE
-	select REGULATOR_FIXED_VOLTAGE
+	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 
 config MACH_CM_T35
 	bool "CompuLab CM-T35/CM-T3730 modules"
@@ -320,7 +320,7 @@ config MACH_OMAP_4430SDP
 	depends on ARCH_OMAP4
 	select OMAP_PACKAGE_CBL
 	select OMAP_PACKAGE_CBS
-	select REGULATOR_FIXED_VOLTAGE
+	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 
 config MACH_OMAP4_PANDA
 	bool "OMAP4 Panda Board"
@@ -328,7 +328,7 @@ config MACH_OMAP4_PANDA
 	depends on ARCH_OMAP4
 	select OMAP_PACKAGE_CBL
 	select OMAP_PACKAGE_CBS
-	select REGULATOR_FIXED_VOLTAGE
+	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 
 config OMAP3_EMU
 	bool "OMAP3 debugging peripherals"
-- 
1.7.8.rc1.14.g248db
