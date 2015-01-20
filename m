From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 20 Jan 2015 11:54:28 +0100
Subject: [PATCH] ARM: at91: fix Kconfig.debug by adding DEBUG_AT91_UART option
In-Reply-To: <1421745792.9655.98.camel@x220>
References: <1421745792.9655.98.camel@x220>
Message-ID: <1421751268-21401-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DEBUG_AT91_UART Kconfig option was forgotten when moving the
AT91 debug-macro.S file. Add it and use it for the at91.S compilation.

Reported-by: Paul Bolle <pebolle@tiscali.nl>
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
Hi Alexandre,
Please tell me if this patch makes sense to fix the lack of this
DEBUG_AT91_UART Kconfig option.

Paul,
Thanks for the heads up.

Bye,
  Nico.

 arch/arm/Kconfig.debug | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index e34d24949c6a..b3d388e5f4ff 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -1164,12 +1164,15 @@ config DEBUG_STI_UART
 	bool
 	depends on ARCH_STI
 
+config DEBUG_AT91_UART
+	bool
+	depends on ARCH_AT91
+
 config DEBUG_LL_INCLUDE
 	string
 	default "debug/sa1100.S" if DEBUG_SA1100
 	default "debug/8250.S" if DEBUG_LL_UART_8250 || DEBUG_UART_8250
-	default "debug/at91.S" if AT91_DEBUG_LL_DBGU0 || AT91_DEBUG_LL_DBGU1 || \
-				AT91_DEBUG_LL_DBGU2
+	default "debug/at91.S" if DEBUG_AT91_UART
 	default "debug/asm9260.S" if DEBUG_ASM9260_UART
 	default "debug/clps711x.S" if DEBUG_CLPS711X_UART1 || DEBUG_CLPS711X_UART2
 	default "debug/meson.S" if DEBUG_MESON_UARTAO
-- 
2.1.3
