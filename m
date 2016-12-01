From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 1 Dec 2016 11:49:47 +0100
Subject: [PATCH 1/3] ARM: dts: at91: add dma1 definition to sama5d2
Message-ID: <20161201104949.23985-1-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sama5d2 SoC has a second DMA controller and can be used just like DMA0.
By default both DMA controllers are configured as "Secure" in
MATRIX_SPSELR so we can use whichever we want in a "single Secure World"
configuration.
Surprisingly the DMA1 has a lower address than DMA0. To avoid confusion
place it after DMA0 node anyway.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/sama5d2.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
index ceb9783ff7e1..c791ce9c750c 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -395,6 +395,16 @@
 				clock-names = "dma_clk";
 			};
 
+			/* Place dma1 here despite its address */
+			dma1: dma-controller at f0004000 {
+				compatible = "atmel,sama5d4-dma";
+				reg = <0xf0004000 0x1000>;
+				interrupts = <7 IRQ_TYPE_LEVEL_HIGH 0>;
+				#dma-cells = <1>;
+				clocks = <&dma1_clk>;
+				clock-names = "dma_clk";
+			};
+
 			pmc: pmc at f0014000 {
 				compatible = "atmel,sama5d2-pmc", "syscon";
 				reg = <0xf0014000 0x160>;
-- 
2.9.0
