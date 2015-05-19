From: manabian@gmail.com (Joachim Eastwood)
Date: Tue, 19 May 2015 20:55:03 +0200
Subject: [PATCH] ARM: lpc18xx: define low-level debug symbol for LPC18xx/43xx
Message-ID: <1432061703-29104-1-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using a dedicated symbol for low-level debugging instead of the
arch symbol will make this platform play nice when enabled on a
kernel that supports multiple platforms.

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
Hi Arnd,

As disscussed on the mailing list:
http://marc.info/?l=linux-arm-kernel&m=143202771500659&w=2

Patch should apply nicely on top of next/soc.

 arch/arm/Kconfig.debug | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index b3b6469350c1..689b524f8428 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -433,6 +433,14 @@ choice
 		  Say Y here if you want kernel low-level debugging support
 		  on KS8695.
 
+	config DEBUG_LPC18XX_UART0
+		bool "Kernel low-level debugging via LPC18xx/43xx UART0"
+		depends on ARCH_LPC18XX
+		select DEBUG_UART_8250
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on NXP LPC18xx/43xx UART0.
+
 	config DEBUG_MESON_UARTAO
 		bool "Kernel low-level debugging via Meson6 UARTAO"
 		depends on ARCH_MESON
@@ -1359,7 +1367,7 @@ config DEBUG_UART_PHYS
 	default 0x20201000 if DEBUG_BCM2835
 	default 0x3e000000 if DEBUG_BCM_KONA_UART
 	default 0x4000e400 if DEBUG_LL_UART_EFM32
-	default 0x40081000 if ARCH_LPC18XX
+	default 0x40081000 if DEBUG_LPC18XX_UART0
 	default 0x40090000 if ARCH_LPC32XX
 	default 0x40100000 if DEBUG_PXA_UART1
 	default 0x42000000 if ARCH_GEMINI
-- 
1.8.0
