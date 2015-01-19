From: pebolle@tiscali.nl (Paul Bolle)
Date: Mon, 19 Jan 2015 20:40:25 +0100
Subject: [PATCH] [linux-next] ARM: mvebu: make DTS comments reflect DEBUG_LL
 changes
Message-ID: <1421696425.9655.65.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Kconfig symbol DEBUG_MVEBU_UART_ALTERNATE was renamed to
DEBUG_MVEBU_UART0_ALTERNATE. And the symbol DEBUG_MVEBU_UART1_ALTERNATE
was added to allow UART1 as a DEBUG_LL target. Make the comment at the
top of this DTS reflect those changes.

Since we're touching this DTS add comments to show which blocks describe
UART0 and UART1.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
Created on top of next-20150119. Untested! Note that I know nothing
about this board or about DT source files, so all changes are nothing
more than guesses.

 arch/arm/boot/dts/armada-xp-axpwifiap.dts | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/armada-xp-axpwifiap.dts b/arch/arm/boot/dts/armada-xp-axpwifiap.dts
index ca0200e20751..28174ab019f9 100644
--- a/arch/arm/boot/dts/armada-xp-axpwifiap.dts
+++ b/arch/arm/boot/dts/armada-xp-axpwifiap.dts
@@ -3,8 +3,8 @@
  *
  * Note: this board is shipped with a new generation boot loader that
  * remaps internal registers at 0xf1000000. Therefore, if earlyprintk
- * is used, the CONFIG_DEBUG_MVEBU_UART_ALTERNATE option should be
- * used.
+ * is used, the CONFIG_DEBUG_MVEBU_UART0_ALTERNATE option or the
+ * CONFIG_DEBUG_MVEBU_UART1_ALTERNATE option should be used.
  *
  * Copyright (C) 2013 Marvell
  *
@@ -60,10 +60,12 @@
 		};
 
 		internal-regs {
+			/* UART0 */
 			serial at 12000 {
 				status = "okay";
 			};
 
+			/* UART1 */
 			serial at 12100 {
 				status = "okay";
 			};
-- 
1.9.3
