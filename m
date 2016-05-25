From: peter.griffin@linaro.org (Peter Griffin)
Date: Wed, 25 May 2016 17:06:41 +0100
Subject: [PATCH v4 07/18] ARM: STi: DT: STiH407: Add FDMA driver dt nodes.
In-Reply-To: <1464192412-16386-1-git-send-email-peter.griffin@linaro.org>
References: <1464192412-16386-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1464192412-16386-9-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These nodes are required to get the fdma driver working
on STiH407 based silicon.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 arch/arm/boot/dts/stih407-family.dtsi | 52 +++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
index 81f8121..b423836 100644
--- a/arch/arm/boot/dts/stih407-family.dtsi
+++ b/arch/arm/boot/dts/stih407-family.dtsi
@@ -694,5 +694,57 @@
 			clocks          = <&clk_sysin>;
 			status		= "okay";
 		};
+
+		/* fdma audio */
+		fdma0: dma-controller at 8e20000 {
+			compatible = "st,stih407-fdma-mpe31-11", "st,xp70-rproc";
+			reg = <0x8e20000 0x8000>,
+			      <0x8e30000 0x3000>,
+			      <0x8e37000 0x1000>,
+			      <0x8e38000 0x8000>;
+			reg-names = "slimcore", "dmem", "peripherals", "imem";
+			clocks = <&clk_s_c0_flexgen CLK_FDMA>,
+				 <&clk_s_c0_flexgen CLK_EXT2F_A9>,
+				 <&clk_s_c0_flexgen CLK_EXT2F_A9>,
+				 <&clk_s_c0_flexgen CLK_EXT2F_A9>;
+			interrupts = <GIC_SPI 5 IRQ_TYPE_NONE>;
+			dma-channels = <16>;
+			#dma-cells = <3>;
+		};
+
+		/* fdma app */
+		fdma1: dma-controller at 8e40000 {
+			compatible = "st,stih407-fdma-mpe31-12", "st,xp70-rproc";
+			reg = <0x8e40000 0x8000>,
+			      <0x8e50000 0x3000>,
+			      <0x8e57000 0x1000>,
+			      <0x8e58000 0x8000>;
+			reg-names = "slimcore", "dmem", "peripherals", "imem";
+			clocks = <&clk_s_c0_flexgen CLK_FDMA>,
+				<&clk_s_c0_flexgen CLK_TX_ICN_DMU>,
+				<&clk_s_c0_flexgen CLK_TX_ICN_DMU>,
+				<&clk_s_c0_flexgen CLK_EXT2F_A9>;
+
+			interrupts = <GIC_SPI 7 IRQ_TYPE_NONE>;
+			dma-channels = <16>;
+			#dma-cells = <3>;
+		};
+
+		/* fdma free running */
+		fdma2: dma-controller at 8e60000 {
+			compatible = "st,stih407-fdma-mpe31-13", "st,xp70-rproc";
+			reg = <0x8e60000 0x8000>,
+			      <0x8e70000 0x3000>,
+			      <0x8e77000 0x1000>,
+			      <0x8e78000 0x8000>;
+			reg-names = "slimcore", "dmem", "peripherals", "imem";
+			interrupts = <GIC_SPI 9 IRQ_TYPE_NONE>;
+			dma-channels = <16>;
+			#dma-cells = <3>;
+			clocks = <&clk_s_c0_flexgen CLK_FDMA>,
+				<&clk_s_c0_flexgen CLK_EXT2F_A9>,
+				<&clk_s_c0_flexgen CLK_TX_ICN_DISP_0>,
+				<&clk_s_c0_flexgen CLK_EXT2F_A9>;
+		};
 	};
 };
-- 
1.9.1
