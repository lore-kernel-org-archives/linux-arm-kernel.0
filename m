From: jiri.prchal@aksignal.cz (Jiri Prchal)
Date: Fri, 10 Oct 2014 08:35:56 +0200
Subject: [PATCH] at91: sam9x5 dt: add usart dma definitions to dt
Message-ID: <775af3ca3993517ceeb45da786dd69a4d000829b.1412922258.git.jiri.prchal@aksignal.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds usart dma definitions to both dtsi for sam9x5 chips. Without
usage of dma it's unable to catch all bytes on usart receiver.

Signed-off-by: Jiri Prchal <jiri.prchal@aksignal.cz>
---
 arch/arm/boot/dts/at91sam9x5.dtsi        | 20 ++++++++++++++++++++
 arch/arm/boot/dts/at91sam9x5_usart3.dtsi |  5 +++++
 2 files changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index 726274f..f9acf6d 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -860,6 +860,11 @@
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_dbgu>;
+				atmel,use-dma-tx;
+				atmel,use-dma-rx;
+				dmas = <&dma1 1 AT91_DMA_CFG_PER_ID(8)>,
+				       <&dma1 1 (AT91_DMA_CFG_PER_ID(9) | AT91_DMA_CFG_FIFOCFG_ASAP)>;
+				dma-names = "tx", "rx";
 				clocks = <&mck>;
 				clock-names = "usart";
 				status = "disabled";
@@ -871,6 +876,11 @@
 				interrupts = <5 IRQ_TYPE_LEVEL_HIGH 5>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_usart0>;
+				atmel,use-dma-rx;
+				atmel,use-dma-tx;
+				dmas = <&dma0 1 AT91_DMA_CFG_PER_ID(3)>,
+				       <&dma0 1 (AT91_DMA_CFG_PER_ID(4) | AT91_DMA_CFG_FIFOCFG_ASAP)>;
+				dma-names = "tx", "rx";
 				clocks = <&usart0_clk>;
 				clock-names = "usart";
 				status = "disabled";
@@ -882,6 +892,11 @@
 				interrupts = <6 IRQ_TYPE_LEVEL_HIGH 5>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_usart1>;
+				atmel,use-dma-rx;
+				atmel,use-dma-tx;
+				dmas = <&dma0 1 AT91_DMA_CFG_PER_ID(5)>,
+				       <&dma0 1 (AT91_DMA_CFG_PER_ID(6) | AT91_DMA_CFG_FIFOCFG_ASAP)>;
+				dma-names = "tx", "rx";
 				clocks = <&usart1_clk>;
 				clock-names = "usart";
 				status = "disabled";
@@ -893,6 +908,11 @@
 				interrupts = <7 IRQ_TYPE_LEVEL_HIGH 5>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_usart2>;
+				atmel,use-dma-rx;
+				atmel,use-dma-tx;
+				dmas = <&dma1 1 AT91_DMA_CFG_PER_ID(12)>,
+				       <&dma1 1 (AT91_DMA_CFG_PER_ID(13) | AT91_DMA_CFG_FIFOCFG_ASAP)>;
+				dma-names = "tx", "rx";
 				clocks = <&usart2_clk>;
 				clock-names = "usart";
 				status = "disabled";
diff --git a/arch/arm/boot/dts/at91sam9x5_usart3.dtsi b/arch/arm/boot/dts/at91sam9x5_usart3.dtsi
index 140217a5..731da0e 100644
--- a/arch/arm/boot/dts/at91sam9x5_usart3.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5_usart3.dtsi
@@ -57,6 +57,11 @@
 				interrupts = <8 IRQ_TYPE_LEVEL_HIGH 5>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_usart3>;
+				atmel,use-dma-rx;
+				atmel,use-dma-tx;
+				dmas = <&dma1 1 AT91_DMA_CFG_PER_ID(14)>,
+				       <&dma1 1 (AT91_DMA_CFG_PER_ID(15) | AT91_DMA_CFG_FIFOCFG_ASAP)>;
+				dma-names = "tx", "rx";
 				clocks = <&usart3_clk>;
 				clock-names = "usart";
 				status = "disabled";
--
1.9.1
