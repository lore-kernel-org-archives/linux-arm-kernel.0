From: peda@axentia.se (Peter Rosin)
Date: Thu, 10 Nov 2016 08:46:40 +0100
Subject: [PATCH] ARM: dts: at91: sama5d3_uart: fix reg sizes to match
 documentation
Message-ID: <1478764000-32233-1-git-send-email-peda@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The new size (0x100) also matches the size given in sama5d3.dtsi

Documentation reference: section 43.6 "Universal Asynchronous
Receiver Transmitter (UART) User Interface", table 43-4 "Register
Mapping" in [1].

[1] Atmel-11121F-ATARM-SAMA5D3-Series-Datasheet_02-Feb-16

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 arch/arm/boot/dts/sama5d3_uart.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sama5d3_uart.dtsi b/arch/arm/boot/dts/sama5d3_uart.dtsi
index 2511d748867b..186377d41c91 100644
--- a/arch/arm/boot/dts/sama5d3_uart.dtsi
+++ b/arch/arm/boot/dts/sama5d3_uart.dtsi
@@ -55,7 +55,7 @@
 
 			uart0: serial at f0024000 {
 				compatible = "atmel,at91sam9260-usart";
-				reg = <0xf0024000 0x200>;
+				reg = <0xf0024000 0x100>;
 				interrupts = <16 IRQ_TYPE_LEVEL_HIGH 5>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_uart0>;
@@ -66,7 +66,7 @@
 
 			uart1: serial at f8028000 {
 				compatible = "atmel,at91sam9260-usart";
-				reg = <0xf8028000 0x200>;
+				reg = <0xf8028000 0x100>;
 				interrupts = <17 IRQ_TYPE_LEVEL_HIGH 5>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_uart1>;
-- 
2.1.4
