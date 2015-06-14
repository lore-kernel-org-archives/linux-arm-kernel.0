From: linux@roeck-us.net (Guenter Roeck)
Date: Sun, 14 Jun 2015 13:19:45 -0700
Subject: [PATCH 1/2] ARM: debug: Limit range of DEBUG_UART_8250_SHIFT
Message-ID: <1434313186-22150-1-git-send-email-linux@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The useful range for DEBUG_UART_8250_SHIFT is 0..31.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/arm/Kconfig.debug | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index f1b157971366..6608121c6ea5 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -1566,6 +1566,7 @@ config DEBUG_UART_VIRT
 config DEBUG_UART_8250_SHIFT
 	int "Register offset shift for the 8250 debug UART"
 	depends on DEBUG_LL_UART_8250 || DEBUG_UART_8250
+	range 0 31
 	default 0 if FOOTBRIDGE || ARCH_IOP32X || DEBUG_BCM_5301X || \
 		DEBUG_OMAP7XXUART1 || DEBUG_OMAP7XXUART2 || DEBUG_OMAP7XXUART3
 	default 2
-- 
2.1.0
