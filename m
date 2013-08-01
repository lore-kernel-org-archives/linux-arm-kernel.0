From: b.brezillon@overkiz.com (Boris BREZILLON)
Date: Thu,  1 Aug 2013 08:58:24 +0200
Subject: [PATCH 6/8] ARM: at91/dt: use periph id macros for at91sam9n12
 interrupt definitions
In-Reply-To: <1375339733-3488-1-git-send-email-b.brezillon@overkiz.com>
References: <1375339733-3488-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <1375340304-3843-1-git-send-email-b.brezillon@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch make use of the peripheral id macros defined in
dt-bindings/at91/at91sam9n12/peripherals.h to register peripheral
interrupts.

Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
---
 arch/arm/boot/dts/at91sam9n12.dtsi |   43 ++++++++++++++++++------------------
 1 file changed, 22 insertions(+), 21 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9n12.dtsi b/arch/arm/boot/dts/at91sam9n12.dtsi
index bb7f564..5e082f4 100644
--- a/arch/arm/boot/dts/at91sam9n12.dtsi
+++ b/arch/arm/boot/dts/at91sam9n12.dtsi
@@ -12,6 +12,7 @@
 #include <dt-bindings/pinctrl/at91.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/at91/at91sam9n12/peripherals.h>
 
 / {
 	model = "Atmel AT91SAM9N12 SoC";
@@ -65,7 +66,7 @@
 				compatible = "atmel,at91rm9200-aic";
 				interrupt-controller;
 				reg = <0xfffff000 0x200>;
-				atmel,external-irqs = <31>;
+				atmel,external-irqs = <AT91SAM9N12_ID_IRQ0>;
 			};
 
 			ramc0: ramc at ffffe800 {
@@ -86,7 +87,7 @@
 			pit: timer at fffffe30 {
 				compatible = "atmel,at91sam9260-pit";
 				reg = <0xfffffe30 0xf>;
-				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+				interrupts = <AT91_ID_SYS IRQ_TYPE_LEVEL_HIGH 7>;
 			};
 
 			shdwc at fffffe10 {
@@ -97,7 +98,7 @@
 			mmc0: mmc at f0008000 {
 				compatible = "atmel,hsmci";
 				reg = <0xf0008000 0x600>;
-				interrupts = <12 IRQ_TYPE_LEVEL_HIGH 0>;
+				interrupts = <AT91SAM9N12_ID_MCI IRQ_TYPE_LEVEL_HIGH 0>;
 				dmas = <&dma 1 AT91_DMA_CFG_PER_ID(0)>;
 				dma-names = "rxtx";
 				#address-cells = <1>;
@@ -108,19 +109,19 @@
 			tcb0: timer at f8008000 {
 				compatible = "atmel,at91sam9x5-tcb";
 				reg = <0xf8008000 0x100>;
-				interrupts = <17 IRQ_TYPE_LEVEL_HIGH 0>;
+				interrupts = <AT91SAM9N12_ID_TCB IRQ_TYPE_LEVEL_HIGH 0>;
 			};
 
 			tcb1: timer at f800c000 {
 				compatible = "atmel,at91sam9x5-tcb";
 				reg = <0xf800c000 0x100>;
-				interrupts = <17 IRQ_TYPE_LEVEL_HIGH 0>;
+				interrupts = <AT91SAM9N12_ID_TCB IRQ_TYPE_LEVEL_HIGH 0>;
 			};
 
 			dma: dma-controller at ffffec00 {
 				compatible = "atmel,at91sam9g45-dma";
 				reg = <0xffffec00 0x200>;
-				interrupts = <20 IRQ_TYPE_LEVEL_HIGH 0>;
+				interrupts = <AT91SAM9N12_ID_DMA IRQ_TYPE_LEVEL_HIGH 0>;
 				#dma-cells = <2>;
 			};
 
@@ -370,7 +371,7 @@
 				pioA: gpio at fffff400 {
 					compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
 					reg = <0xfffff400 0x200>;
-					interrupts = <2 IRQ_TYPE_LEVEL_HIGH 1>;
+					interrupts = <AT91SAM9N12_ID_PIOAB IRQ_TYPE_LEVEL_HIGH 1>;
 					#gpio-cells = <2>;
 					gpio-controller;
 					interrupt-controller;
@@ -380,7 +381,7 @@
 				pioB: gpio at fffff600 {
 					compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
 					reg = <0xfffff600 0x200>;
-					interrupts = <2 IRQ_TYPE_LEVEL_HIGH 1>;
+					interrupts = <AT91SAM9N12_ID_PIOAB IRQ_TYPE_LEVEL_HIGH 1>;
 					#gpio-cells = <2>;
 					gpio-controller;
 					interrupt-controller;
@@ -390,7 +391,7 @@
 				pioC: gpio at fffff800 {
 					compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
 					reg = <0xfffff800 0x200>;
-					interrupts = <3 IRQ_TYPE_LEVEL_HIGH 1>;
+					interrupts = <AT91SAM9N12_ID_PIOCD IRQ_TYPE_LEVEL_HIGH 1>;
 					#gpio-cells = <2>;
 					gpio-controller;
 					interrupt-controller;
@@ -400,7 +401,7 @@
 				pioD: gpio at fffffa00 {
 					compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
 					reg = <0xfffffa00 0x200>;
-					interrupts = <3 IRQ_TYPE_LEVEL_HIGH 1>;
+					interrupts = <AT91SAM9N12_ID_PIOCD IRQ_TYPE_LEVEL_HIGH 1>;
 					#gpio-cells = <2>;
 					gpio-controller;
 					interrupt-controller;
@@ -411,7 +412,7 @@
 			dbgu: serial at fffff200 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xfffff200 0x200>;
-				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+				interrupts = <AT91_ID_SYS IRQ_TYPE_LEVEL_HIGH 7>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_dbgu>;
 				status = "disabled";
@@ -420,7 +421,7 @@
 			ssc0: ssc at f0010000 {
 				compatible = "atmel,at91sam9g45-ssc";
 				reg = <0xf0010000 0x4000>;
-				interrupts = <28 IRQ_TYPE_LEVEL_HIGH 5>;
+				interrupts = <AT91SAM9N12_ID_SSC IRQ_TYPE_LEVEL_HIGH 5>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_ssc0_tx &pinctrl_ssc0_rx>;
 				status = "disabled";
@@ -429,7 +430,7 @@
 			usart0: serial at f801c000 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xf801c000 0x4000>;
-				interrupts = <5 IRQ_TYPE_LEVEL_HIGH 5>;
+				interrupts = <AT91SAM9N12_ID_USART0 IRQ_TYPE_LEVEL_HIGH 5>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_usart0>;
 				status = "disabled";
@@ -438,7 +439,7 @@
 			usart1: serial at f8020000 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xf8020000 0x4000>;
-				interrupts = <6 IRQ_TYPE_LEVEL_HIGH 5>;
+				interrupts = <AT91SAM9N12_ID_USART1 IRQ_TYPE_LEVEL_HIGH 5>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_usart1>;
 				status = "disabled";
@@ -447,7 +448,7 @@
 			usart2: serial at f8024000 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xf8024000 0x4000>;
-				interrupts = <7 IRQ_TYPE_LEVEL_HIGH 5>;
+				interrupts = <AT91SAM9N12_ID_USART2 IRQ_TYPE_LEVEL_HIGH 5>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_usart2>;
 				status = "disabled";
@@ -456,7 +457,7 @@
 			usart3: serial at f8028000 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xf8028000 0x4000>;
-				interrupts = <8 IRQ_TYPE_LEVEL_HIGH 5>;
+				interrupts = <AT91SAM9N12_ID_USART3 IRQ_TYPE_LEVEL_HIGH 5>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_usart3>;
 				status = "disabled";
@@ -465,7 +466,7 @@
 			i2c0: i2c at f8010000 {
 				compatible = "atmel,at91sam9x5-i2c";
 				reg = <0xf8010000 0x100>;
-				interrupts = <9 IRQ_TYPE_LEVEL_HIGH 6>;
+				interrupts = <AT91SAM9N12_ID_TWI0 IRQ_TYPE_LEVEL_HIGH 6>;
 				dmas = <&dma 1 AT91_DMA_CFG_PER_ID(13)>,
 				       <&dma 1 AT91_DMA_CFG_PER_ID(14)>;
 				dma-names = "tx", "rx";
@@ -477,7 +478,7 @@
 			i2c1: i2c at f8014000 {
 				compatible = "atmel,at91sam9x5-i2c";
 				reg = <0xf8014000 0x100>;
-				interrupts = <10 IRQ_TYPE_LEVEL_HIGH 6>;
+				interrupts = <AT91SAM9N12_ID_TWI1 IRQ_TYPE_LEVEL_HIGH 6>;
 				dmas = <&dma 1 AT91_DMA_CFG_PER_ID(15)>,
 				       <&dma 1 AT91_DMA_CFG_PER_ID(16)>;
 				dma-names = "tx", "rx";
@@ -491,7 +492,7 @@
 				#size-cells = <0>;
 				compatible = "atmel,at91rm9200-spi";
 				reg = <0xf0000000 0x100>;
-				interrupts = <13 IRQ_TYPE_LEVEL_HIGH 3>;
+				interrupts = <AT91SAM9N12_ID_SPI0 IRQ_TYPE_LEVEL_HIGH 3>;
 				dmas = <&dma 1 AT91_DMA_CFG_PER_ID(1)>,
 				       <&dma 1 AT91_DMA_CFG_PER_ID(2)>;
 				dma-names = "tx", "rx";
@@ -505,7 +506,7 @@
 				#size-cells = <0>;
 				compatible = "atmel,at91rm9200-spi";
 				reg = <0xf0004000 0x100>;
-				interrupts = <14 IRQ_TYPE_LEVEL_HIGH 3>;
+				interrupts = <AT91SAM9N12_ID_SPI1 IRQ_TYPE_LEVEL_HIGH 3>;
 				dmas = <&dma 1 AT91_DMA_CFG_PER_ID(3)>,
 				       <&dma 1 AT91_DMA_CFG_PER_ID(4)>;
 				dma-names = "tx", "rx";
@@ -545,7 +546,7 @@
 		usb0: ohci at 00500000 {
 			compatible = "atmel,at91rm9200-ohci", "usb-ohci";
 			reg = <0x00500000 0x00100000>;
-			interrupts = <22 IRQ_TYPE_LEVEL_HIGH 2>;
+			interrupts = <AT91SAM9N12_ID_UHP IRQ_TYPE_LEVEL_HIGH 2>;
 			status = "disabled";
 		};
 	};
-- 
1.7.9.5
