From: codrin.ciubotariu@microchip.com (Codrin Ciubotariu)
Date: Fri, 25 May 2018 15:34:27 +0300
Subject: [PATCH v4 6/7] ARM: dts: at91: sama5d2: add nodes for I2S controllers
In-Reply-To: <1527251668-31396-1-git-send-email-codrin.ciubotariu@microchip.com>
References: <1527251668-31396-1-git-send-email-codrin.ciubotariu@microchip.com>
Message-ID: <1527251668-31396-7-git-send-email-codrin.ciubotariu@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Cyrille Pitchen <cyrille.pitchen@atmel.com>

This patch adds DT nodes for I2S0 and I2S1. It also adds an alias for
each I2S node.

Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
[codrin.ciubotariu at microchip.com: added phandle to new mux clock]
Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---
 arch/arm/boot/dts/sama5d2.dtsi | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
index eeb6afa..eca73ce 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -58,6 +58,8 @@
 		serial1 = &uart3;
 		tcb0 = &tcb0;
 		tcb1 = &tcb1;
+		i2s0 = &i2s0;
+		i2s1 = &i2s1;
 	};
 
 	cpus {
@@ -1313,6 +1315,22 @@
 				clocks = <&clk32k>;
 			};
 
+			i2s0: i2s at f8050000 {
+				compatible = "atmel,sama5d2-i2s";
+				reg = <0xf8050000 0x100>;
+				interrupts = <54 IRQ_TYPE_LEVEL_HIGH 7>;
+				dmas = <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
+					 AT91_XDMAC_DT_PERID(31))>,
+				       <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
+					 AT91_XDMAC_DT_PERID(32))>;
+				dma-names = "tx", "rx";
+				clocks = <&i2s0_clk>, <&i2s0_gclk>, <&audio_pll_pmc>, <&i2s0muxck>;
+				clock-names = "pclk", "gclk", "aclk", "muxclk";
+				status = "disabled";
+			};
+
 			can0: can at f8054000 {
 				compatible = "bosch,m_can";
 				reg = <0xf8054000 0x4000>, <0x210000 0x4000>;
@@ -1506,6 +1524,22 @@
 				status = "disabled";
 			};
 
+			i2s1: i2s at fc04c000 {
+				compatible = "atmel,sama5d2-i2s";
+				reg = <0xfc04c000 0x100>;
+				interrupts = <55 IRQ_TYPE_LEVEL_HIGH 7>;
+				dmas = <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
+					 AT91_XDMAC_DT_PERID(33))>,
+				       <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
+					 AT91_XDMAC_DT_PERID(34))>;
+				dma-names = "tx", "rx";
+				clocks = <&i2s1_clk>, <&i2s1_gclk>, <&audio_pll_pmc>, <&i2s1muxck>;
+				clock-names = "pclk", "gclk", "aclk", "muxclk";
+				status = "disabled";
+			};
+
 			can1: can at fc050000 {
 				compatible = "bosch,m_can";
 				reg = <0xfc050000 0x4000>, <0x210000 0x4000>;
-- 
2.7.4
