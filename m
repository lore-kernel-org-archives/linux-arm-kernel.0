From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri, 5 Apr 2013 16:22:43 +0200
Subject: [PATCH 01/14] ARM: ux500: move debugmacro to debug includes
In-Reply-To: <1365171776-8463-1-git-send-email-linus.walleij@stericsson.com>
References: <1365171776-8463-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <1365171776-8463-2-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

This moves the Ux500 debug macro to the debug headers to
make way for multiplatform support.

Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/Kconfig.debug                                            | 8 ++++++++
 .../include/mach/debug-macro.S => include/debug/ux500.S}          | 0
 2 files changed, 8 insertions(+)
 rename arch/arm/{mach-ux500/include/mach/debug-macro.S => include/debug/ux500.S} (100%)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index acdddda..a7b6f8b 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -414,6 +414,13 @@ choice
 		  Say Y here if you want the debug print routines to direct
 		  their output to the uart1 port on SiRFmarco devices.
 
+	config DEBUG_UX500_UART
+		depends on ARCH_U8500
+		bool "Use Ux500 UART for low-level debug"
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on Ux500 based platforms.
+
 	config DEBUG_VEXPRESS_UART0_DETECT
 		bool "Autodetect UART0 on Versatile Express Cortex-A core tiles"
 		depends on ARCH_VEXPRESS && CPU_CP15_MMU
@@ -598,6 +605,7 @@ config DEBUG_LL_INCLUDE
 		DEBUG_VEXPRESS_UART0_CA9 || DEBUG_VEXPRESS_UART0_RS1
 	default "debug/vt8500.S" if DEBUG_VT8500_UART0
 	default "debug/tegra.S" if DEBUG_TEGRA_UART
+	default "debug/ux500.S" if DEBUG_UX500_UART
 	default "debug/zynq.S" if DEBUG_ZYNQ_UART0 || DEBUG_ZYNQ_UART1
 	default "mach/debug-macro.S"
 
diff --git a/arch/arm/mach-ux500/include/mach/debug-macro.S b/arch/arm/include/debug/ux500.S
similarity index 100%
rename from arch/arm/mach-ux500/include/mach/debug-macro.S
rename to arch/arm/include/debug/ux500.S
-- 
1.7.11.3
