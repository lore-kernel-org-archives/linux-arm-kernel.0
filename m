From: peter.griffin@linaro.org (Peter Griffin)
Date: Thu, 21 Apr 2016 12:04:23 +0100
Subject: [PATCH 06/18] ARM: STi: DT: STiH407: Add FDMA driver dt nodes.
In-Reply-To: <1461236675-10176-1-git-send-email-peter.griffin@linaro.org>
References: <1461236675-10176-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1461236675-10176-7-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These nodes are required to get the fdma driver working
on STiH407 based silicon.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 arch/arm/boot/dts/stih407-family.dtsi | 51 +++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
index 81f8121..a77008f 100644
--- a/arch/arm/boot/dts/stih407-family.dtsi
+++ b/arch/arm/boot/dts/stih407-family.dtsi
@@ -694,5 +694,56 @@
 			clocks          = <&clk_sysin>;
 			status		= "okay";
 		};
+
+		/* fdma audio */
+		fdma0: dma-controller at 8e20000 {
+			compatible = "st,stih407-fdma-mpe31-11";
+			reg = <0x8e20000 0x20000>;
+			interrupts = <GIC_SPI 5 IRQ_TYPE_NONE>;
+			dma-channels = <16>;
+			#dma-cells = <3>;
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
+		/* fdma app */
+		fdma1: dma-controller at 8e40000 {
+			compatible = "st,stih407-fdma-mpe31-12";
+			reg = <0x8e40000 0x20000>;
+			interrupts = <GIC_SPI 7 IRQ_TYPE_NONE>;
+			dma-channels = <16>;
+			#dma-cells = <3>;
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
+		/* fdma free running */
+		fdma2: dma-controller at 8e60000 {
+			compatible = "st,stih407-fdma-mpe31-13";
+			reg = <0x8e60000 0x20000>;
+			interrupts = <GIC_SPI 9 IRQ_TYPE_NONE>;
+			dma-channels = <16>;
+			#dma-cells = <3>;
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
