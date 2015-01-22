From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 22 Jan 2015 10:07:16 +0000
Subject: [PATCH 1/2] ARM: sti: Provide DT nodes for SSC[0..4]
Message-ID: <1421921237-8991-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Synchronous Serial Controller is used to provide SPI.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/stih407-family.dtsi | 54 +++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
index 3e31d32..d52347a 100644
--- a/arch/arm/boot/dts/stih407-family.dtsi
+++ b/arch/arm/boot/dts/stih407-family.dtsi
@@ -274,5 +274,59 @@
 
 			status = "disabled";
 		};
+
+		spi at 9840000 {
+			compatible = "st,comms-ssc4-spi";
+			reg = <0x9840000 0x110>;
+			interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk_s_c0_flexgen CLK_EXT2F_A9>;
+			clock-names = "ssc";
+			pinctrl-0 = <&pinctrl_spi0_default>;
+			pinctrl-names = "default";
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			status = "disabled";
+		};
+
+		spi at 9841000 {
+			compatible = "st,comms-ssc4-spi";
+			reg = <0x9841000 0x110>;
+			interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk_s_c0_flexgen CLK_EXT2F_A9>;
+			clock-names = "ssc";
+
+			status = "disabled";
+		};
+
+		spi at 9842000 {
+			compatible = "st,comms-ssc4-spi";
+			reg = <0x9842000 0x110>;
+			interrupts = <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk_s_c0_flexgen CLK_EXT2F_A9>;
+			clock-names = "ssc";
+
+			status = "disabled";
+		};
+
+		spi at 9843000 {
+			compatible = "st,comms-ssc4-spi";
+			reg = <0x9843000 0x110>;
+			interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk_s_c0_flexgen CLK_EXT2F_A9>;
+			clock-names = "ssc";
+
+			status = "disabled";
+		};
+
+		spi at 9844000 {
+			compatible = "st,comms-ssc4-spi";
+			reg = <0x9844000 0x110>;
+			interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk_s_c0_flexgen CLK_EXT2F_A9>;
+			clock-names = "ssc";
+
+			status = "disabled";
+		};
 	};
 };
-- 
1.9.1
