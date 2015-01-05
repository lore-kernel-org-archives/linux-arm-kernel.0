From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Mon,  5 Jan 2015 12:40:23 +0000
Subject: [PATCH 3.19-rc2 v15 7/8] arm: Seperate DEBUG_UART_PHYS from DEBUG_LL
 on EP93XX
In-Reply-To: <1420461624-4410-1-git-send-email-daniel.thompson@linaro.org>
References: <1420461624-4410-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <1420461624-4410-8-git-send-email-daniel.thompson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On EP93XX uncompress.h uses CONFIG_DEBUG_UART_PHYS instead of a hard
coded serial port. This means the build breaks when DEBUG_LL
(and DEBUG_LL_UART_PL01X) is not enabled.

This is fixed by adding a new dependency.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig.debug | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index ff43ea38fe1f..e250505b9ae1 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -1370,7 +1370,8 @@ config DEBUG_UART_PHYS
 	default 0xfffb9800 if DEBUG_OMAP1UART3 || DEBUG_OMAP7XXUART3
 	default 0xfffe8600 if DEBUG_UART_BCM63XX
 	default 0xfffff700 if ARCH_IOP33X
-	depends on DEBUG_LL_UART_8250 || DEBUG_LL_UART_PL01X || \
+	depends on ARCH_EP93XX || \
+	        DEBUG_LL_UART_8250 || DEBUG_LL_UART_PL01X || \
 		DEBUG_LL_UART_EFM32 || \
 		DEBUG_UART_8250 || DEBUG_UART_PL01X || DEBUG_MESON_UARTAO || \
 		DEBUG_MSM_UART || DEBUG_NETX_UART || \
-- 
1.9.3
