From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu,  8 Jan 2015 18:38:03 +0100
Subject: [PATCH v4 01/12] ARM: mvebu: Rename DEBUG_LL to indicate UART index
In-Reply-To: <1420738694-6163-1-git-send-email-gregory.clement@free-electrons.com>
References: <1420738694-6163-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1420738694-6163-2-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Maxime Ripard <maxime.ripard@free-electrons.com>

The mvebu SoCs actually have more UARTs than just the one exposed in DEBUG_LL
yet.

In order to differentiate them, Add the index in the configuration options and
their help.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Acked-by: Jason Cooper <jason@lakedaemon.net>
Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/Kconfig.debug | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 5ddd4906f7a7..eb3991cf63ab 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -455,13 +455,13 @@ choice
 		  Please adjust DEBUG_UART_PHYS and DEBUG_UART_BASE configuration
 		  options based on your needs.
 
-	config DEBUG_MVEBU_UART
-		bool "Kernel low-level debugging messages via MVEBU UART (old bootloaders)"
+	config DEBUG_MVEBU_UART0
+		bool "Kernel low-level debugging messages via MVEBU UART0 (old bootloaders)"
 		depends on ARCH_MVEBU
 		select DEBUG_UART_8250
 		help
 		  Say Y here if you want kernel low-level debugging support
-		  on MVEBU based platforms.
+		  on MVEBU based platforms on UART0.
 
 		  This option should be used with the old bootloaders
 		  that left the internal registers mapped at
@@ -474,13 +474,13 @@ choice
 		  when u-boot hands over to the kernel, the system
 		  silently crashes, with no serial output at all.
 
-	config DEBUG_MVEBU_UART_ALTERNATE
-		bool "Kernel low-level debugging messages via MVEBU UART (new bootloaders)"
+	config DEBUG_MVEBU_UART0_ALTERNATE
+		bool "Kernel low-level debugging messages via MVEBU UART0 (new bootloaders)"
 		depends on ARCH_MVEBU
 		select DEBUG_UART_8250
 		help
 		  Say Y here if you want kernel low-level debugging support
-		  on MVEBU based platforms.
+		  on MVEBU based platforms on UART0.
 
 		  This option should be used with the new bootloaders
 		  that remap the internal registers at 0xf1000000.
@@ -1282,7 +1282,7 @@ config DEBUG_UART_PHYS
 	default 0xc8000000 if ARCH_IXP4XX && !CPU_BIG_ENDIAN
 	default 0xc8000003 if ARCH_IXP4XX && CPU_BIG_ENDIAN
 	default 0xd0000000 if ARCH_SPEAR3XX || ARCH_SPEAR6XX
-	default 0xd0012000 if DEBUG_MVEBU_UART
+	default 0xd0012000 if DEBUG_MVEBU_UART0
 	default 0xc81004c0 if DEBUG_MESON_UARTAO
 	default 0xd4017000 if DEBUG_MMP_UART2
 	default 0xd4018000 if DEBUG_MMP_UART3
@@ -1296,7 +1296,7 @@ config DEBUG_UART_PHYS
 	default 0xe8008000 if DEBUG_R7S72100_SCIF2
 	default 0xf0000be0 if ARCH_EBSA110
 	default 0xf040ab00 if DEBUG_BRCMSTB_UART
-	default 0xf1012000 if DEBUG_MVEBU_UART_ALTERNATE
+	default 0xf1012000 if DEBUG_MVEBU_UART0_ALTERNATE
 	default 0xf1012000 if ARCH_DOVE || ARCH_MV78XX0 || \
 				ARCH_ORION5X
 	default 0xf7fc9000 if DEBUG_BERLIN_UART
@@ -1377,7 +1377,7 @@ config DEBUG_UART_VIRT
 	default 0xfeb30c00 if DEBUG_KEYSTONE_UART0
 	default 0xfeb31000 if DEBUG_KEYSTONE_UART1
 	default 0xfec02000 if DEBUG_SOCFPGA_UART
-	default 0xfec12000 if DEBUG_MVEBU_UART || DEBUG_MVEBU_UART_ALTERNATE
+	default 0xfec12000 if DEBUG_MVEBU_UART0 || DEBUG_MVEBU_UART0_ALTERNATE
 	default 0xfec20000 if DEBUG_DAVINCI_DMx_UART0
 	default 0xfec90000 if DEBUG_RK32_UART2
 	default 0xfed0c000 if DEBUG_DAVINCI_DA8XX_UART1
-- 
1.9.1
