From: b.brezillon@overkiz.com (Boris BREZILLON)
Date: Thu,  1 Aug 2013 08:53:25 +0200
Subject: [PATCH 2/8] ARM: at91/dt: use periph id macros for at91rm9200
 interrupt definitions
In-Reply-To: <1375339733-3488-1-git-send-email-b.brezillon@overkiz.com>
References: <1375339733-3488-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <1375340005-3683-1-git-send-email-b.brezillon@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch make use of the peripheral id macros defined in
dt-bindings/at91/at91rm9200/peripherals.h to register peripheral
interrupts.

Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
---
 arch/arm/boot/dts/at91rm9200.dtsi |   59 +++++++++++++++++++++----------------
 1 file changed, 33 insertions(+), 26 deletions(-)

diff --git a/arch/arm/boot/dts/at91rm9200.dtsi b/arch/arm/boot/dts/at91rm9200.dtsi
index 92b9e21..25c4ab2 100644
--- a/arch/arm/boot/dts/at91rm9200.dtsi
+++ b/arch/arm/boot/dts/at91rm9200.dtsi
@@ -14,6 +14,7 @@
 #include <dt-bindings/pinctrl/at91.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/at91/at91rm9200/peripherals.h>
 
 / {
 	model = "Atmel AT91RM9200 family SoC";
@@ -68,7 +69,13 @@
 				compatible = "atmel,at91rm9200-aic";
 				interrupt-controller;
 				reg = <0xfffff000 0x200>;
-				atmel,external-irqs = <25 26 27 28 29 30 31>;
+				atmel,external-irqs = <AT91RM9200_ID_IRQ0
+						       AT91RM9200_ID_IRQ1
+						       AT91RM9200_ID_IRQ2
+						       AT91RM9200_ID_IRQ3
+						       AT91RM9200_ID_IRQ4
+						       AT91RM9200_ID_IRQ5
+						       AT91RM9200_ID_IRQ6>;
 			};
 
 			ramc0: ramc at ffffff00 {
@@ -84,29 +91,29 @@
 			st: timer at fffffd00 {
 				compatible = "atmel,at91rm9200-st";
 				reg = <0xfffffd00 0x100>;
-				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+				interrupts = <AT91_ID_SYS IRQ_TYPE_LEVEL_HIGH 7>;
 			};
 
 			tcb0: timer at fffa0000 {
 				compatible = "atmel,at91rm9200-tcb";
 				reg = <0xfffa0000 0x100>;
-				interrupts = <17 IRQ_TYPE_LEVEL_HIGH 0
-					      18 IRQ_TYPE_LEVEL_HIGH 0
-					      19 IRQ_TYPE_LEVEL_HIGH 0>;
+				interrupts = <AT91RM9200_ID_TC0 IRQ_TYPE_LEVEL_HIGH 0
+					      AT91RM9200_ID_TC1 IRQ_TYPE_LEVEL_HIGH 0
+					      AT91RM9200_ID_TC2 IRQ_TYPE_LEVEL_HIGH 0>;
 			};
 
 			tcb1: timer at fffa4000 {
 				compatible = "atmel,at91rm9200-tcb";
 				reg = <0xfffa4000 0x100>;
-				interrupts = <20 IRQ_TYPE_LEVEL_HIGH 0
-					      21 IRQ_TYPE_LEVEL_HIGH 0
-					      22 IRQ_TYPE_LEVEL_HIGH 0>;
+				interrupts = <AT91RM9200_ID_TC3 IRQ_TYPE_LEVEL_HIGH 0
+					      AT91RM9200_ID_TC4 IRQ_TYPE_LEVEL_HIGH 0
+					      AT91RM9200_ID_TC5 IRQ_TYPE_LEVEL_HIGH 0>;
 			};
 
 			i2c0: i2c at fffb8000 {
 				compatible = "atmel,at91rm9200-i2c";
 				reg = <0xfffb8000 0x4000>;
-				interrupts = <12 IRQ_TYPE_LEVEL_HIGH 6>;
+				interrupts = <AT91RM9200_ID_TWI IRQ_TYPE_LEVEL_HIGH 6>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_twi>;
 				#address-cells = <1>;
@@ -117,7 +124,7 @@
 			mmc0: mmc at fffb4000 {
 				compatible = "atmel,hsmci";
 				reg = <0xfffb4000 0x4000>;
-				interrupts = <10 IRQ_TYPE_LEVEL_HIGH 0>;
+				interrupts = <AT91RM9200_ID_MCI IRQ_TYPE_LEVEL_HIGH 0>;
 				#address-cells = <1>;
 				#size-cells = <0>;
 				status = "disabled";
@@ -126,7 +133,7 @@
 			ssc0: ssc at fffd0000 {
 				compatible = "atmel,at91rm9200-ssc";
 				reg = <0xfffd0000 0x4000>;
-				interrupts = <14 IRQ_TYPE_LEVEL_HIGH 5>;
+				interrupts = <AT91RM9200_ID_SSC0 IRQ_TYPE_LEVEL_HIGH 5>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_ssc0_tx &pinctrl_ssc0_rx>;
 				status = "disable";
@@ -135,7 +142,7 @@
 			ssc1: ssc at fffd4000 {
 				compatible = "atmel,at91rm9200-ssc";
 				reg = <0xfffd4000 0x4000>;
-				interrupts = <15 IRQ_TYPE_LEVEL_HIGH 5>;
+				interrupts = <AT91RM9200_ID_SSC1 IRQ_TYPE_LEVEL_HIGH 5>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_ssc1_tx &pinctrl_ssc1_rx>;
 				status = "disable";
@@ -144,7 +151,7 @@
 			ssc2: ssc at fffd8000 {
 				compatible = "atmel,at91rm9200-ssc";
 				reg = <0xfffd8000 0x4000>;
-				interrupts = <16 IRQ_TYPE_LEVEL_HIGH 5>;
+				interrupts = <AT91RM9200_ID_SSC2 IRQ_TYPE_LEVEL_HIGH 5>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_ssc2_tx &pinctrl_ssc2_rx>;
 				status = "disable";
@@ -153,7 +160,7 @@
 			macb0: ethernet at fffbc000 {
 				compatible = "cdns,at91rm9200-emac", "cdns,emac";
 				reg = <0xfffbc000 0x4000>;
-				interrupts = <24 IRQ_TYPE_LEVEL_HIGH 3>;
+				interrupts = <AT91RM9200_ID_EMAC IRQ_TYPE_LEVEL_HIGH 3>;
 				phy-mode = "rmii";
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_macb_rmii>;
@@ -490,7 +497,7 @@
 				pioA: gpio at fffff400 {
 					compatible = "atmel,at91rm9200-gpio";
 					reg = <0xfffff400 0x200>;
-					interrupts = <2 IRQ_TYPE_LEVEL_HIGH 1>;
+					interrupts = <AT91RM9200_ID_PIOA IRQ_TYPE_LEVEL_HIGH 1>;
 					#gpio-cells = <2>;
 					gpio-controller;
 					interrupt-controller;
@@ -500,7 +507,7 @@
 				pioB: gpio at fffff600 {
 					compatible = "atmel,at91rm9200-gpio";
 					reg = <0xfffff600 0x200>;
-					interrupts = <3 IRQ_TYPE_LEVEL_HIGH 1>;
+					interrupts = <AT91RM9200_ID_PIOB IRQ_TYPE_LEVEL_HIGH 1>;
 					#gpio-cells = <2>;
 					gpio-controller;
 					interrupt-controller;
@@ -510,7 +517,7 @@
 				pioC: gpio at fffff800 {
 					compatible = "atmel,at91rm9200-gpio";
 					reg = <0xfffff800 0x200>;
-					interrupts = <4 IRQ_TYPE_LEVEL_HIGH 1>;
+					interrupts = <AT91RM9200_ID_PIOC IRQ_TYPE_LEVEL_HIGH 1>;
 					#gpio-cells = <2>;
 					gpio-controller;
 					interrupt-controller;
@@ -520,7 +527,7 @@
 				pioD: gpio at fffffa00 {
 					compatible = "atmel,at91rm9200-gpio";
 					reg = <0xfffffa00 0x200>;
-					interrupts = <5 IRQ_TYPE_LEVEL_HIGH 1>;
+					interrupts = <AT91RM9200_ID_PIOD IRQ_TYPE_LEVEL_HIGH 1>;
 					#gpio-cells = <2>;
 					gpio-controller;
 					interrupt-controller;
@@ -531,7 +538,7 @@
 			dbgu: serial at fffff200 {
 				compatible = "atmel,at91rm9200-usart";
 				reg = <0xfffff200 0x200>;
-				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+				interrupts = <AT91_ID_SYS IRQ_TYPE_LEVEL_HIGH 7>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_dbgu>;
 				status = "disabled";
@@ -540,7 +547,7 @@
 			usart0: serial at fffc0000 {
 				compatible = "atmel,at91rm9200-usart";
 				reg = <0xfffc0000 0x200>;
-				interrupts = <6 IRQ_TYPE_LEVEL_HIGH 5>;
+				interrupts = <AT91RM9200_ID_US0 IRQ_TYPE_LEVEL_HIGH 5>;
 				atmel,use-dma-rx;
 				atmel,use-dma-tx;
 				pinctrl-names = "default";
@@ -551,7 +558,7 @@
 			usart1: serial at fffc4000 {
 				compatible = "atmel,at91rm9200-usart";
 				reg = <0xfffc4000 0x200>;
-				interrupts = <7 IRQ_TYPE_LEVEL_HIGH 5>;
+				interrupts = <AT91RM9200_ID_US1 IRQ_TYPE_LEVEL_HIGH 5>;
 				atmel,use-dma-rx;
 				atmel,use-dma-tx;
 				pinctrl-names = "default";
@@ -562,7 +569,7 @@
 			usart2: serial at fffc8000 {
 				compatible = "atmel,at91rm9200-usart";
 				reg = <0xfffc8000 0x200>;
-				interrupts = <8 IRQ_TYPE_LEVEL_HIGH 5>;
+				interrupts = <AT91RM9200_ID_US2 IRQ_TYPE_LEVEL_HIGH 5>;
 				atmel,use-dma-rx;
 				atmel,use-dma-tx;
 				pinctrl-names = "default";
@@ -573,7 +580,7 @@
 			usart3: serial at fffcc000 {
 				compatible = "atmel,at91rm9200-usart";
 				reg = <0xfffcc000 0x200>;
-				interrupts = <23 IRQ_TYPE_LEVEL_HIGH 5>;
+				interrupts = <AT91RM9200_ID_US3 IRQ_TYPE_LEVEL_HIGH 5>;
 				atmel,use-dma-rx;
 				atmel,use-dma-tx;
 				pinctrl-names = "default";
@@ -584,7 +591,7 @@
 			usb1: gadget at fffb0000 {
 				compatible = "atmel,at91rm9200-udc";
 				reg = <0xfffb0000 0x4000>;
-				interrupts = <11 IRQ_TYPE_LEVEL_HIGH 2>;
+				interrupts = <AT91RM9200_ID_UDP IRQ_TYPE_LEVEL_HIGH 2>;
 				status = "disabled";
 			};
 
@@ -593,7 +600,7 @@
 				#size-cells = <0>;
 				compatible = "atmel,at91rm9200-spi";
 				reg = <0xfffe0000 0x200>;
-				interrupts = <13 IRQ_TYPE_LEVEL_HIGH 3>;
+				interrupts = <AT91RM9200_ID_SPI IRQ_TYPE_LEVEL_HIGH 3>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_spi0>;
 				status = "disabled";
@@ -620,7 +627,7 @@
 		usb0: ohci at 00300000 {
 			compatible = "atmel,at91rm9200-ohci", "usb-ohci";
 			reg = <0x00300000 0x100000>;
-			interrupts = <23 IRQ_TYPE_LEVEL_HIGH 2>;
+			interrupts = <AT91RM9200_ID_UHP IRQ_TYPE_LEVEL_HIGH 2>;
 			status = "disabled";
 		};
 	};
-- 
1.7.9.5
