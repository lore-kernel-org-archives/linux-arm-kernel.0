From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 30 Nov 2016 18:36:29 +0100
Subject: [PATCH 1/2] ARM: dts: at91: sama5d4: change DMA allocation for secure
 peripherals
Message-ID: <20161130173630.11944-1-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some peripherals are "Programmable Secure" but left as "Secure" by default.
If tried to be connected to Non-Secure DMA controller, the possibility to
leak secure data is prevented so using these peripherals with DMA1 is not
possible with this default configuration (MATRIX_SPSELR registers setup by
bootloader).
Move them to DMA0 which is an "Always-Secure" DMA controller.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/sama5d4.dtsi | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5d4.dtsi
index 4f60c1b7b137..d3889c9d25a9 100644
--- a/arch/arm/boot/dts/sama5d4.dtsi
+++ b/arch/arm/boot/dts/sama5d4.dtsi
@@ -854,10 +854,10 @@
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xf8004000 0x100>;
 				interrupts = <27 IRQ_TYPE_LEVEL_HIGH 5>;
-				dmas = <&dma1
+				dmas = <&dma0
 					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1)
 					| AT91_XDMAC_DT_PERID(22))>,
-				       <&dma1
+				       <&dma0
 					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1)
 					| AT91_XDMAC_DT_PERID(23))>;
 				dma-names = "tx", "rx";
@@ -938,10 +938,10 @@
 				compatible = "atmel,sama5d4-i2c";
 				reg = <0xf8018000 0x4000>;
 				interrupts = <33 IRQ_TYPE_LEVEL_HIGH 6>;
-				dmas = <&dma1
+				dmas = <&dma0
 					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1)
 					| AT91_XDMAC_DT_PERID(4))>,
-				       <&dma1
+				       <&dma0
 					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1)
 					| AT91_XDMAC_DT_PERID(5))>;
 				dma-names = "tx", "rx";
@@ -1055,10 +1055,10 @@
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xfc004000 0x100>;
 				interrupts = <28 IRQ_TYPE_LEVEL_HIGH 5>;
-				dmas = <&dma1
+				dmas = <&dma0
 					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1)
 					| AT91_XDMAC_DT_PERID(24))>,
-				       <&dma1
+				       <&dma0
 					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1)
 					| AT91_XDMAC_DT_PERID(25))>;
 				dma-names = "tx", "rx";
@@ -1167,10 +1167,10 @@
 				compatible = "atmel,at91rm9200-spi";
 				reg = <0xfc01c000 0x100>;
 				interrupts = <39 IRQ_TYPE_LEVEL_HIGH 3>;
-				dmas = <&dma1
+				dmas = <&dma0
 					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1)
 					| AT91_XDMAC_DT_PERID(14))>,
-				       <&dma1
+				       <&dma0
 					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1)
 					| AT91_XDMAC_DT_PERID(15))>;
 				dma-names = "tx", "rx";
-- 
2.9.0
