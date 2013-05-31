From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri, 31 May 2013 11:18:57 +0200
Subject: [PATCH 22/39] ARM: u300: move debugmacro to debug includes
In-Reply-To: <1369991954-17406-1-git-send-email-linus.walleij@stericsson.com>
References: <1369991954-17406-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <1369991954-17406-23-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

This moves the U300 debug macro to the debug headers to
make way for multiplatform support.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/Kconfig.debug                                            | 8 ++++++++
 .../include/mach/debug-macro.S => include/debug/u300.S}           | 0
 2 files changed, 8 insertions(+)
 rename arch/arm/{mach-u300/include/mach/debug-macro.S => include/debug/u300.S} (100%)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 1d41908..2708ed9 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -443,6 +443,13 @@ choice
 		  Say Y here if you want the debug print routines to direct
 		  their output to the uart1 port on SiRFmarco devices.
 
+	config DEBUG_U300_UART
+		bool "Kernel low-level debugging messages via U300 UART0"
+		depends on ARCH_U300
+		help
+		  Say Y here if you want the debug print routines to direct
+		  their output to the uart port on U300 devices.
+
 	config DEBUG_UX500_UART
 		depends on ARCH_U8500
 		bool "Use Ux500 UART for low-level debug"
@@ -643,6 +650,7 @@ config DEBUG_LL_INCLUDE
 	default "debug/socfpga.S" if DEBUG_SOCFPGA_UART
 	default "debug/sunxi.S" if DEBUG_SUNXI_UART0 || DEBUG_SUNXI_UART1
 	default "debug/tegra.S" if DEBUG_TEGRA_UART
+	default "debug/u300.S" if DEBUG_U300_UART
 	default "debug/ux500.S" if DEBUG_UX500_UART
 	default "debug/vexpress.S" if DEBUG_VEXPRESS_UART0_DETECT || \
 		DEBUG_VEXPRESS_UART0_CA9 || DEBUG_VEXPRESS_UART0_RS1
diff --git a/arch/arm/mach-u300/include/mach/debug-macro.S b/arch/arm/include/debug/u300.S
similarity index 100%
rename from arch/arm/mach-u300/include/mach/debug-macro.S
rename to arch/arm/include/debug/u300.S
-- 
1.7.11.3
