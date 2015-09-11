From: peter.griffin@linaro.org (Peter Griffin)
Date: Fri, 11 Sep 2015 15:14:29 +0100
Subject: [PATCH v2 7/9] ARM: STi: DT: STiH407: Add FDMA driver dt nodes.
In-Reply-To: <1441980871-24475-1-git-send-email-peter.griffin@linaro.org>
References: <1441980871-24475-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1441980871-24475-8-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These nodes are required to get the fdma driver working
on STiH407 based silicon.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 arch/arm/boot/dts/stih407-family.dtsi | 51 +++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
index 838b812..da07474b 100644
--- a/arch/arm/boot/dts/stih407-family.dtsi
+++ b/arch/arm/boot/dts/stih407-family.dtsi
@@ -565,5 +565,56 @@
 						  <&phy_port2 PHY_TYPE_USB3>;
 			};
 		};
+
+		fdma0: fdma0-audio at 8e20000 {
+			compatible = "st,stih407-fdma-mpe31";
+			reg = <0x8e20000 0x20000>;
+			interrupts = <GIC_SPI 5 IRQ_TYPE_NONE>;
+			dma-channels = <16>;
+			#dma-cells = <3>;
+			st,fdma-id = <0>;
+			clocks = <&clk_s_c0_flexgen CLK_FDMA>,
+				 <&clk_s_c0_flexgen CLK_EXT2F_A9>,
+				 <&clk_s_c0_flexgen CLK_EXT2F_A9>,
+				 <&clk_s_c0_flexgen CLK_EXT2F_A9>;
+			clock-names = "fdma_slim",
+				      "fdma_hi",
+				      "fdma_low",
+				      "fdma_ic";
+		};
+
+		fdma1: fdma1-app at 8e40000 {
+			compatible = "st,stih407-fdma-mpe31";
+			reg = <0x8e40000 0x20000>;
+			interrupts = <GIC_SPI 7 IRQ_TYPE_NONE>;
+			dma-channels = <16>;
+			#dma-cells = <3>;
+			st,fdma-id = <1>;
+			clocks = <&clk_s_c0_flexgen CLK_FDMA>,
+				 <&clk_s_c0_flexgen CLK_TX_ICN_DMU>,
+				 <&clk_s_c0_flexgen CLK_TX_ICN_DMU>,
+				 <&clk_s_c0_flexgen CLK_EXT2F_A9>;
+			clock-names = "fdma_slim",
+				      "fdma_hi",
+				      "fdma_low",
+				      "fdma_ic";
+		};
+
+		fdma2: fdma2-free_running at 8e60000 {
+			compatible = "st,stih407-fdma-mpe31";
+			reg = <0x8e60000 0x20000>;
+			interrupts = <GIC_SPI 9 IRQ_TYPE_NONE>;
+			dma-channels = <16>;
+			#dma-cells = <3>;
+			st,fdma-id = <2>;
+			clocks = <&clk_s_c0_flexgen CLK_FDMA>,
+				 <&clk_s_c0_flexgen CLK_EXT2F_A9>,
+				 <&clk_s_c0_flexgen CLK_TX_ICN_DISP_0>,
+				 <&clk_s_c0_flexgen CLK_EXT2F_A9>;
+			clock-names = "fdma_slim",
+				      "fdma_hi",
+				      "fdma_low",
+				      "fdma_ic";
+		};
 	};
 };
-- 
1.9.1
