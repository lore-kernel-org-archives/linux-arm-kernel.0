From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 28 Sep 2017 16:14:59 -0700
Subject: [PATCH v2 07/10] ARM: debug: Add Hurricane 2 UART2 debug addresses
In-Reply-To: <20170928231502.27069-1-f.fainelli@gmail.com>
References: <20170928231502.27069-1-f.fainelli@gmail.com>
Message-ID: <20170928231502.27069-8-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Broadcom Hurricane 2 SoCs typically use their secondary UART for
debug/console, provide a known good location for that.

Acked-by: Jon Mason <jon.mason@broadcom.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/Kconfig.debug | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 6dcea8e8e941..0346805fe33c 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -169,6 +169,11 @@ choice
 		depends on ARCH_BCM_5301X || ARCH_BCM_NSP
 		select DEBUG_UART_8250
 
+	config DEBUG_BCM_HR2
+		bool "Kernel low-level debugging on Hurricane 2 UART2"
+		depends on ARCH_BCM_HR2
+		select DEBUG_UART_8250
+
 	config DEBUG_BCM_KONA_UART
 		bool "Kernel low-level debugging messages via BCM KONA UART"
 		depends on ARCH_BCM_MOBILE
@@ -1508,6 +1513,7 @@ config DEBUG_UART_PHYS
 	default 0x11009000 if DEBUG_MT8135_UART3
 	default 0x16000000 if DEBUG_INTEGRATOR
 	default 0x18000300 if DEBUG_BCM_5301X
+	default 0x18000400 if DEBUG_BCM_HR2
 	default 0x18010000 if DEBUG_SIRFATLAS7_UART0
 	default 0x18020000 if DEBUG_SIRFATLAS7_UART1
 	default 0x1c090000 if DEBUG_VEXPRESS_UART0_RS1
@@ -1623,6 +1629,7 @@ config DEBUG_UART_VIRT
 	default 0xf01fb000 if DEBUG_NOMADIK_UART
 	default 0xf0201000 if DEBUG_BCM2835 || DEBUG_BCM2836
 	default 0xf1000300 if DEBUG_BCM_5301X
+	default 0xf1000400 if DEBUG_BCM_HR2
 	default 0xf1002000 if DEBUG_MT8127_UART0
 	default 0xf1006000 if DEBUG_MT6589_UART0
 	default 0xf1009000 if DEBUG_MT8135_UART3
@@ -1728,7 +1735,8 @@ config DEBUG_UART_8250_SHIFT
 	int "Register offset shift for the 8250 debug UART"
 	depends on DEBUG_LL_UART_8250 || DEBUG_UART_8250
 	default 0 if DEBUG_FOOTBRIDGE_COM1 || ARCH_IOP32X || DEBUG_BCM_5301X || \
-		DEBUG_OMAP7XXUART1 || DEBUG_OMAP7XXUART2 || DEBUG_OMAP7XXUART3
+		DEBUG_BCM_HR2 || DEBUG_OMAP7XXUART1 || DEBUG_OMAP7XXUART2 || \
+		DEBUG_OMAP7XXUART3
 	default 2
 
 config DEBUG_UART_8250_WORD
-- 
2.14.1
