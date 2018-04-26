From: icenowy@aosc.io (Icenowy Zheng)
Date: Thu, 26 Apr 2018 22:07:27 +0800
Subject: [PATCH 2/3] arm64: allwinner: h6: add device tree nodes for MMC
 controllers
In-Reply-To: <20180426140728.43155-1-icenowy@aosc.io>
References: <20180426140728.43155-1-icenowy@aosc.io>
Message-ID: <20180426140728.43155-3-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Allwinner H6 SoC have 3 MMC controllers.

Add device tree nodes for them.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 56 ++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index 4debc3962830..3cbfc035c979 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -124,12 +124,68 @@
 			interrupt-controller;
 			#interrupt-cells = <3>;
 
+			mmc0_pins: mmc0-pins {
+				pins = "PF0", "PF1", "PF2", "PF3",
+				       "PF4", "PF5";
+				function = "mmc0";
+				drive-strength = <30>;
+				bias-pull-up;
+			};
+
+			mmc2_pins: mmc2-pins {
+				pins = "PC1", "PC4", "PC5", "PC6",
+				       "PC7", "PC8", "PC9", "PC10",
+				       "PC11", "PC12", "PC13", "PC14";
+				function = "mmc2";
+				drive-strength = <30>;
+				bias-pull-up;
+			};
+
 			uart0_ph_pins: uart0-ph {
 				pins = "PH0", "PH1";
 				function = "uart0";
 			};
 		};
 
+		mmc0: mmc at 4020000 {
+			compatible = "allwinner,sun50i-h6-mmc";
+			reg = <0x04020000 0x1000>;
+			clocks = <&ccu CLK_BUS_MMC0>, <&ccu CLK_MMC0>;
+			clock-names = "ahb", "mmc";
+			resets = <&ccu RST_BUS_MMC0>;
+			reset-names = "ahb";
+			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		mmc1: mmc at 4021000 {
+			compatible = "allwinner,sun50i-h6-mmc";
+			reg = <0x04021000 0x1000>;
+			clocks = <&ccu CLK_BUS_MMC1>, <&ccu CLK_MMC1>;
+			clock-names = "ahb", "mmc";
+			resets = <&ccu RST_BUS_MMC1>;
+			reset-names = "ahb";
+			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		mmc2: mmc at 4022000 {
+			compatible = "allwinner,sun50i-h6-emmc";
+			reg = <0x04022000 0x1000>;
+			clocks = <&ccu CLK_BUS_MMC2>, <&ccu CLK_MMC2>;
+			clock-names = "ahb", "mmc";
+			resets = <&ccu RST_BUS_MMC2>;
+			reset-names = "ahb";
+			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
 		uart0: serial at 5000000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x05000000 0x400>;
-- 
2.15.1
