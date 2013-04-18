From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 18 Apr 2013 15:01:12 +0200
Subject: [PATCH 4/5] ARM: at91/at91-ariag25.dts: UART0/1 nodes are disabled
In-Reply-To: <cover.1366289869.git.nicolas.ferre@atmel.com>
References: <cover.1366289869.git.nicolas.ferre@atmel.com>
Message-ID: <280be558b85a251913a51c7c24824c2a8b3d7eba.1366289869.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

UART0 is moved to generic at91sam9x5.dtsi file.
Both uarts are "disabled" as the corresponding pins on
Aria documentation are shown as GPIOs.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/at91-ariag25.dts | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/at91-ariag25.dts b/arch/arm/boot/dts/at91-ariag25.dts
index 1de619c..5b07380 100644
--- a/arch/arm/boot/dts/at91-ariag25.dts
+++ b/arch/arm/boot/dts/at91-ariag25.dts
@@ -21,6 +21,7 @@
 		serial3 = &usart2;
 		serial4 = &usart3;
 		serial5 = &uart0;
+		serial6 = &uart1;
 	};
 
 	chosen {
@@ -112,13 +113,17 @@
 				status = "okay";
 			};
 
+			/*
+			 * UART0/1 pins are marked as GPIO on
+			 * Aria documentation.
+			 * Change to "okay" if you need additional serial ports
+			 */
 			uart0: serial at f8040000 {
-				compatible = "atmel,at91sam9260-usart";
-				reg = <0xf8040000 0x200>;
-				interrupts = <15 4 5>;
-				pinctrl-names = "default";
-				pinctrl-0 = <&pinctrl_uart0>;
-				status = "okay";
+				status = "disabled";
+			};
+
+			uart1: serial at f8044000 {
+				status = "disabled";
 			};
 
 			adc0: adc at f804c000 {
-- 
1.8.0
