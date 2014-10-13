From: jiri.prchal@aksignal.cz (Jiri Prchal)
Date: Mon, 13 Oct 2014 11:02:16 +0200
Subject: [PATCH] at91: sam9x5 dt: add usart dma definitions to dt
Message-ID: <e2dd545ccf0051e1089b1a313205547c44df5c12.1413190828.git.jiri.prchal@aksignal.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds usart dma definitions to both dtsi for sam9x5 chips. Without
usage of dma it's unable to catch all bytes on usart receiver.

Signed-off-by: Jiri Prchal <jiri.prchal@aksignal.cz>

v2: Add only definitions, enable them in board file.
---
 arch/arm/boot/dts/at91sam9x5.dtsi        | 12 ++++++++++++
 arch/arm/boot/dts/at91sam9x5_usart3.dtsi |  3 +++
 2 files changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index 726274f..bbb3ba6 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -860,6 +860,9 @@
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_dbgu>;
+				dmas = <&dma1 1 AT91_DMA_CFG_PER_ID(8)>,
+				       <&dma1 1 (AT91_DMA_CFG_PER_ID(9) | AT91_DMA_CFG_FIFOCFG_ASAP)>;
+				dma-names = "tx", "rx";
 				clocks = <&mck>;
 				clock-names = "usart";
 				status = "disabled";
@@ -871,6 +874,9 @@
 				interrupts = <5 IRQ_TYPE_LEVEL_HIGH 5>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_usart0>;
+				dmas = <&dma0 1 AT91_DMA_CFG_PER_ID(3)>,
+				       <&dma0 1 (AT91_DMA_CFG_PER_ID(4) | AT91_DMA_CFG_FIFOCFG_ASAP)>;
+				dma-names = "tx", "rx";
 				clocks = <&usart0_clk>;
 				clock-names = "usart";
 				status = "disabled";
@@ -882,6 +888,9 @@
 				interrupts = <6 IRQ_TYPE_LEVEL_HIGH 5>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_usart1>;
+				dmas = <&dma0 1 AT91_DMA_CFG_PER_ID(5)>,
+				       <&dma0 1 (AT91_DMA_CFG_PER_ID(6) | AT91_DMA_CFG_FIFOCFG_ASAP)>;
+				dma-names = "tx", "rx";
 				clocks = <&usart1_clk>;
 				clock-names = "usart";
 				status = "disabled";
@@ -893,6 +902,9 @@
 				interrupts = <7 IRQ_TYPE_LEVEL_HIGH 5>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_usart2>;
+				dmas = <&dma1 1 AT91_DMA_CFG_PER_ID(12)>,
+				       <&dma1 1 (AT91_DMA_CFG_PER_ID(13) | AT91_DMA_CFG_FIFOCFG_ASAP)>;
+				dma-names = "tx", "rx";
 				clocks = <&usart2_clk>;
 				clock-names = "usart";
 				status = "disabled";
diff --git a/arch/arm/boot/dts/at91sam9x5_usart3.dtsi b/arch/arm/boot/dts/at91sam9x5_usart3.dtsi
index 140217a5..43bb5b5 100644
--- a/arch/arm/boot/dts/at91sam9x5_usart3.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5_usart3.dtsi
@@ -57,6 +57,9 @@
 				interrupts = <8 IRQ_TYPE_LEVEL_HIGH 5>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_usart3>;
+				dmas = <&dma1 1 AT91_DMA_CFG_PER_ID(14)>,
+				       <&dma1 1 (AT91_DMA_CFG_PER_ID(15) | AT91_DMA_CFG_FIFOCFG_ASAP)>;
+				dma-names = "tx", "rx";
 				clocks = <&usart3_clk>;
 				clock-names = "usart";
 				status = "disabled";
-- 
1.9.1
