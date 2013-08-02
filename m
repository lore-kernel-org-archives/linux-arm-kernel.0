From: elen.song@atmel.com (Elen Song)
Date: Fri, 2 Aug 2013 14:53:46 +0800
Subject: [PATCH] ARM: at91/DT: add serial DMA client infos
Message-ID: <1375426426-11070-1-git-send-email-elen.song@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DBGU is not enable dma now because it will occupy a dma channel which may not be necessary.

Signed-off-by: Elen Song <elen.song@atmel.com>
---
 arch/arm/boot/dts/at91sam9n12.dtsi |   53 ++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/at91sam9x5.dtsi  |   45 ++++++++++++++++++++++++++++++
 arch/arm/boot/dts/sama5d3.dtsi     |   53 ++++++++++++++++++++++++++++++++++++
 3 files changed, 151 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9n12.dtsi b/arch/arm/boot/dts/at91sam9n12.dtsi
index bb7f564..cea7acc 100644
--- a/arch/arm/boot/dts/at91sam9n12.dtsi
+++ b/arch/arm/boot/dts/at91sam9n12.dtsi
@@ -24,6 +24,8 @@
 		serial2 = &usart1;
 		serial3 = &usart2;
 		serial4 = &usart3;
+		serial5 = &uart0;
+		serial6 = &uart1;
 		gpio0 = &pioA;
 		gpio1 = &pioB;
 		gpio2 = &pioC;
@@ -412,6 +414,9 @@
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xfffff200 0x200>;
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+				dmas = <&dma 1 AT91_DMA_CFG_PER_ID(24)>,
+				       <&dma 1 (AT91_DMA_CFG_PER_ID(25) | AT91_DMA_CFG_FIFOCFG_ASAP)>;
+				dma-names = "tx", "rx";
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_dbgu>;
 				status = "disabled";
@@ -430,6 +435,11 @@
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xf801c000 0x4000>;
 				interrupts = <5 IRQ_TYPE_LEVEL_HIGH 5>;
+				atmel,use-dma-tx;
+				atmel,use-dma-rx;
+				dmas = <&dma 1 AT91_DMA_CFG_PER_ID(5)>,
+				       <&dma 1 (AT91_DMA_CFG_PER_ID(6) | AT91_DMA_CFG_FIFOCFG_ASAP)>;
+				dma-names = "tx", "rx";
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_usart0>;
 				status = "disabled";
@@ -439,6 +449,11 @@
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xf8020000 0x4000>;
 				interrupts = <6 IRQ_TYPE_LEVEL_HIGH 5>;
+				atmel,use-dma-tx;
+				atmel,use-dma-rx;
+				dmas = <&dma 1 AT91_DMA_CFG_PER_ID(7)>,
+				       <&dma 1 (AT91_DMA_CFG_PER_ID(8) | AT91_DMA_CFG_FIFOCFG_ASAP)>;
+				dma-names = "tx", "rx";
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_usart1>;
 				status = "disabled";
@@ -448,6 +463,11 @@
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xf8024000 0x4000>;
 				interrupts = <7 IRQ_TYPE_LEVEL_HIGH 5>;
+				atmel,use-dma-tx;
+				atmel,use-dma-rx;
+				dmas = <&dma 1 AT91_DMA_CFG_PER_ID(9)>,
+				       <&dma 1 (AT91_DMA_CFG_PER_ID(10) | AT91_DMA_CFG_FIFOCFG_ASAP)>;
+				dma-names = "tx", "rx";
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_usart2>;
 				status = "disabled";
@@ -457,11 +477,44 @@
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xf8028000 0x4000>;
 				interrupts = <8 IRQ_TYPE_LEVEL_HIGH 5>;
+				atmel,use-dma-tx;
+				atmel,use-dma-rx;
+				dmas = <&dma 1 AT91_DMA_CFG_PER_ID(11)>,
+				       <&dma 1 (AT91_DMA_CFG_PER_ID(12) | AT91_DMA_CFG_FIFOCFG_ASAP)>;
+				dma-names = "tx", "rx";
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_usart3>;
 				status = "disabled";
 			};
 
+			uart0: serial at f8040000 {
+				compatible = "atmel,at91sam9260-usart";
+				reg = <0xf8040000 0x4000>;
+				interrupts = <15 IRQ_TYPE_LEVEL_HIGH 5>;
+				atmel,use-dma-tx;
+				atmel,use-dma-rx;
+				dmas = <&dma 1 AT91_DMA_CFG_PER_ID(17)>,
+				       <&dma 1 (AT91_DMA_CFG_PER_ID(18) | AT91_DMA_CFG_FIFOCFG_ASAP)>;
+				dma-names = "tx", "rx";
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_uart0>;
+				status = "disabled";
+			};
+
+			uart1: serial at f8044000 {
+				compatible = "atmel,at91sam9260-usart";
+				reg = <0xf8044000 0x4000>;
+				interrupts = <16 IRQ_TYPE_LEVEL_HIGH 5>;
+				atmel,use-dma-tx;
+				atmel,use-dma-rx;
+				dmas = <&dma 1 AT91_DMA_CFG_PER_ID(19)>,
+				       <&dma 1 (AT91_DMA_CFG_PER_ID(20) | AT91_DMA_CFG_FIFOCFG_ASAP)>;
+				dma-names = "tx", "rx";
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_uart1>;
+				status = "disabled";
+			};
+
 			i2c0: i2c at f8010000 {
 				compatible = "atmel,at91sam9x5-i2c";
 				reg = <0xf8010000 0x100>;
diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index 57d45f5..4821aa6 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -25,6 +25,9 @@
 		serial1 = &usart0;
 		serial2 = &usart1;
 		serial3 = &usart2;
+		serial4 = &usart3;
+		serial5 = &uart0;
+		serial6 = &uart1;
 		gpio0 = &pioA;
 		gpio1 = &pioB;
 		gpio2 = &pioC;
@@ -573,6 +576,9 @@
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xfffff200 0x200>;
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+				dmas = <&dma1 1 AT91_DMA_CFG_PER_ID(8)>,
+				       <&dma1 1 (AT91_DMA_CFG_PER_ID(9) | AT91_DMA_CFG_FIFOCFG_ASAP)>;
+				dma-names = "tx", "rx";
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_dbgu>;
 				status = "disabled";
@@ -582,6 +588,11 @@
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xf801c000 0x200>;
 				interrupts = <5 IRQ_TYPE_LEVEL_HIGH 5>;
+				atmel,use-dma-tx;
+				atmel,use-dma-rx;
+				dmas = <&dma0 1 AT91_DMA_CFG_PER_ID(3)>,
+				       <&dma0 1 (AT91_DMA_CFG_PER_ID(4) | AT91_DMA_CFG_FIFOCFG_ASAP)>;
+				dma-names = "tx", "rx";
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_usart0>;
 				status = "disabled";
@@ -591,6 +602,11 @@
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xf8020000 0x200>;
 				interrupts = <6 IRQ_TYPE_LEVEL_HIGH 5>;
+				atmel,use-dma-tx;
+				atmel,use-dma-rx;
+				dmas = <&dma0 1 AT91_DMA_CFG_PER_ID(5)>,
+				       <&dma0 1 (AT91_DMA_CFG_PER_ID(6) | AT91_DMA_CFG_FIFOCFG_ASAP)>;
+				dma-names = "tx", "rx";
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_usart1>;
 				status = "disabled";
@@ -600,11 +616,30 @@
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xf8024000 0x200>;
 				interrupts = <7 IRQ_TYPE_LEVEL_HIGH 5>;
+				atmel,use-dma-tx;
+				atmel,use-dma-rx;
+				dmas = <&dma1 1 AT91_DMA_CFG_PER_ID(12)>,
+				       <&dma1 1 (AT91_DMA_CFG_PER_ID(13) | AT91_DMA_CFG_FIFOCFG_ASAP)>;
+				dma-names = "tx", "rx";
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_usart2>;
 				status = "disabled";
 			};
 
+			usart3: serial at f8028000 {
+				compatible = "atmel,at91sam9260-usart";
+				reg = <0xf8028000 0x200>;
+				interrupts = <8 IRQ_TYPE_LEVEL_HIGH 5>;
+				atmel,use-dma-tx;
+				atmel,use-dma-rx;
+				dmas = <&dma1 1 AT91_DMA_CFG_PER_ID(14)>,
+				       <&dma1 1 (AT91_DMA_CFG_PER_ID(15) | AT91_DMA_CFG_FIFOCFG_ASAP)>;
+				dma-names = "tx", "rx";
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_usart3>;
+				status = "disabled";
+			};
+
 			macb0: ethernet at f802c000 {
 				compatible = "cdns,at32ap7000-macb", "cdns,macb";
 				reg = <0xf802c000 0x100>;
@@ -667,6 +702,11 @@
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xf8040000 0x200>;
 				interrupts = <15 IRQ_TYPE_LEVEL_HIGH 5>;
+				atmel,use-dma-tx;
+				atmel,use-dma-rx;
+				dmas = <&dma0 1 AT91_DMA_CFG_PER_ID(11)>,
+				       <&dma0 1 (AT91_DMA_CFG_PER_ID(12) | AT91_DMA_CFG_FIFOCFG_ASAP)>;
+				dma-names = "tx", "rx";
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_uart0>;
 				status = "disabled";
@@ -676,6 +716,11 @@
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xf8044000 0x200>;
 				interrupts = <16 IRQ_TYPE_LEVEL_HIGH 5>;
+				atmel,use-dma-tx;
+				atmel,use-dma-rx;
+				dmas = <&dma1 1 AT91_DMA_CFG_PER_ID(10)>,
+				       <&dma1 1 (AT91_DMA_CFG_PER_ID(11) | AT91_DMA_CFG_FIFOCFG_ASAP)>;
+				dma-names = "tx", "rx";
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_uart1>;
 				status = "disabled";
diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
index a1d5e25..1260743 100644
--- a/arch/arm/boot/dts/sama5d3.dtsi
+++ b/arch/arm/boot/dts/sama5d3.dtsi
@@ -25,6 +25,8 @@
 		serial2 = &usart1;
 		serial3 = &usart2;
 		serial4 = &usart3;
+		serial5 = &uart0;
+		serial6 = &uart1;
 		gpio0 = &pioA;
 		gpio1 = &pioB;
 		gpio2 = &pioC;
@@ -147,6 +149,11 @@
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xf001c000 0x100>;
 				interrupts = <12 IRQ_TYPE_LEVEL_HIGH 5>;
+				atmel,use-dma-tx;
+				atmel,use-dma-rx;
+				dmas = <&dma0 2 AT91_DMA_CFG_PER_ID(3)>,
+				       <&dma0 2 (AT91_DMA_CFG_PER_ID(4) | AT91_DMA_CFG_FIFOCFG_ASAP)>;
+				dma-names = "tx", "rx";
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_usart0>;
 				status = "disabled";
@@ -156,6 +163,11 @@
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xf0020000 0x100>;
 				interrupts = <13 IRQ_TYPE_LEVEL_HIGH 5>;
+				atmel,use-dma-tx;
+				atmel,use-dma-rx;
+				dmas = <&dma0 2 AT91_DMA_CFG_PER_ID(5)>,
+				       <&dma0 2 (AT91_DMA_CFG_PER_ID(6) | AT91_DMA_CFG_FIFOCFG_ASAP)>;
+				dma-names = "tx", "rx";
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_usart1>;
 				status = "disabled";
@@ -322,6 +334,11 @@
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xf8020000 0x100>;
 				interrupts = <14 IRQ_TYPE_LEVEL_HIGH 5>;
+				atmel,use-dma-tx;
+				atmel,use-dma-rx;
+				dmas = <&dma1 2 AT91_DMA_CFG_PER_ID(7)>,
+				       <&dma1 2 (AT91_DMA_CFG_PER_ID(8) | AT91_DMA_CFG_FIFOCFG_ASAP)>;
+				dma-names = "tx", "rx";
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_usart2>;
 				status = "disabled";
@@ -331,11 +348,44 @@
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xf8024000 0x100>;
 				interrupts = <15 IRQ_TYPE_LEVEL_HIGH 5>;
+				atmel,use-dma-tx;
+				atmel,use-dma-rx;
+				dmas = <&dma1 2 AT91_DMA_CFG_PER_ID(9)>,
+                                       <&dma1 2 (AT91_DMA_CFG_PER_ID(10) | AT91_DMA_CFG_FIFOCFG_ASAP)>;
+                                dma-names = "tx", "rx";
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_usart3>;
 				status = "disabled";
 			};
 
+			uart0: serial at f0024000 {
+				compatible = "atmel,at91sam9260-usart";
+				reg = <0xf0024000 0x100>;
+				interrupts = <16 IRQ_TYPE_LEVEL_HIGH 5>;
+				atmel,use-dma-tx;
+				atmel,use-dma-rx;
+				dmas = <&dma0 2 AT91_DMA_CFG_PER_ID(11)>,
+				       <&dma0 2 (AT91_DMA_CFG_PER_ID(12) | AT91_DMA_CFG_FIFOCFG_ASAP)>;
+				dma-names = "tx", "rx";
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_uart0>;
+				status = "disabled";
+			};
+
+			uart1: serial at f8028000 {
+                                compatible = "atmel,at91sam9260-usart";
+                                reg = <0xf8028000 0x100>;
+                                interrupts = <17 IRQ_TYPE_LEVEL_HIGH 5>;
+				atmel,use-dma-tx;
+				atmel,use-dma-rx;
+                                dmas = <&dma1 2 AT91_DMA_CFG_PER_ID(5)>,
+                                       <&dma1 2 (AT91_DMA_CFG_PER_ID(6) | AT91_DMA_CFG_FIFOCFG_ASAP)>;
+                                dma-names = "tx", "rx";
+                                pinctrl-names = "default";
+                                pinctrl-0 = <&pinctrl_uart1>;
+                                status = "disabled";
+			};
+
 			macb1: ethernet at f802c000 {
 				compatible = "cdns,at32ap7000-macb", "cdns,macb";
 				reg = <0xf802c000 0x100>;
@@ -386,6 +436,9 @@
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xffffee00 0x200>;
 				interrupts = <2 IRQ_TYPE_LEVEL_HIGH 7>;
+				dmas = <&dma1 2 AT91_DMA_CFG_PER_ID(13)>,
+				       <&dma1 2 (AT91_DMA_CFG_PER_ID(14) | AT91_DMA_CFG_FIFOCFG_ASAP)>;
+				dma-names = "tx", "rx";
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_dbgu>;
 				status = "disabled";
-- 
1.7.9.5
