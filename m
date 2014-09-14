From: hauke@hauke-m.de (Hauke Mehrtens)
Date: Sun, 14 Sep 2014 21:43:40 +0200
Subject: [PATCH] ARM: BCM5301X: fix early serial console
Message-ID: <1410723820-23813-1-git-send-email-hauke@hauke-m.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This device actually has a 8250 serial with a shift of 0.
Tested this on a BCM4708.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 arch/arm/Kconfig.debug | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index b11ad54..ac14418 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -109,7 +109,7 @@ choice
 	config DEBUG_BCM_5301X
 		bool "Kernel low-level debugging on BCM5301X UART1"
 		depends on ARCH_BCM_5301X
-		select DEBUG_UART_PL01X
+		select DEBUG_UART_8250
 
 	config DEBUG_BCM_KONA_UART
 		bool "Kernel low-level debugging messages via BCM KONA UART"
@@ -1199,7 +1199,7 @@ config DEBUG_UART_VIRT
 config DEBUG_UART_8250_SHIFT
 	int "Register offset shift for the 8250 debug UART"
 	depends on DEBUG_LL_UART_8250 || DEBUG_UART_8250
-	default 0 if FOOTBRIDGE || ARCH_IOP32X
+	default 0 if FOOTBRIDGE || ARCH_IOP32X || DEBUG_BCM_5301X
 	default 2
 
 config DEBUG_UART_8250_WORD
-- 
1.9.1
