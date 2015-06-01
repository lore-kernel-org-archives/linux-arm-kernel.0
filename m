From: eddie.huang@mediatek.com (Eddie Huang)
Date: Mon, 1 Jun 2015 14:29:13 +0800
Subject: [PATCH 2/2] arm64: dts: mt8173: Add I2C device node
In-Reply-To: <1433140153-22436-1-git-send-email-eddie.huang@mediatek.com>
References: <1433140153-22436-1-git-send-email-eddie.huang@mediatek.com>
Message-ID: <1433140153-22436-3-git-send-email-eddie.huang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add MT8173 I2C device nodes, include I2C controllers and pins.
MT8173 has six I2C controllers, from i2c0 to i2c6, exclude i2c5.
The 6th I2C controller register base doesn't next to 5th I2C,
and there is a hardware between 5th and 6th I2C controller. So
SoC designer name 6th controller as "i2c6", not "i2c5".

Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8173.dtsi | 119 +++++++++++++++++++++++++++++++
 1 file changed, 119 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index b52ec43..72d9ab1 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -158,6 +158,53 @@
 			interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
 						<GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
 						<GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>;
+			i2c0_pins_a: i2c0 at 0 {
+				pins1 {
+					pinmux = <MT8173_PIN_45_SDA0__FUNC_SDA0>,
+						 <MT8173_PIN_46_SCL0__FUNC_SCL0>;
+					bias-disable;
+				};
+			};
+
+			i2c1_pins_a: i2c1 at 0 {
+				pins1 {
+					pinmux = <MT8173_PIN_125_SDA1__FUNC_SDA1>,
+						 <MT8173_PIN_126_SCL1__FUNC_SCL1>;
+					bias-disable;
+				};
+			};
+
+			i2c2_pins_a: i2c2 at 0 {
+				pins1 {
+					pinmux = <MT8173_PIN_43_SDA2__FUNC_SDA2>,
+						 <MT8173_PIN_44_SCL2__FUNC_SCL2>;
+					bias-disable;
+				};
+			};
+
+			i2c3_pins_a: i2c3 at 0 {
+				pins1 {
+					pinmux = <MT8173_PIN_106_SDA3__FUNC_SDA3>,
+						 <MT8173_PIN_107_SCL3__FUNC_SCL3>;
+					bias-disable;
+				};
+			};
+
+			i2c4_pins_a: i2c4 at 0 {
+				pins1 {
+					pinmux = <MT8173_PIN_133_SDA4__FUNC_SDA4>,
+						 <MT8173_PIN_134_SCL4__FUNC_SCL4>;
+					bias-disable;
+				};
+			};
+
+			i2c6_pins_a: i2c6 at 0 {
+				pins1 {
+					pinmux = <MT8173_PIN_100_MSDC2_DAT0__FUNC_SDA5>,
+						 <MT8173_PIN_101_MSDC2_DAT1__FUNC_SCL5>;
+					bias-disable;
+				};
+			};
 		};
 
 		watchdog: watchdog at 10007000 {
@@ -194,6 +241,78 @@
 				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
 		};
 
+		i2c0: i2c at 11007000 {
+			compatible = "mediatek,mt8173-i2c";
+			reg = <0 0x11007000 0 0x70>,
+			      <0 0x11000100 0 0x80>;
+			interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_LOW>;
+			clock-div = <16>;
+			clocks = <&pericfg CLK_PERI_I2C0>,
+				 <&pericfg CLK_PERI_AP_DMA>;
+			clock-names = "main", "dma";
+			status = "disabled";
+		};
+
+		i2c1: i2c at 11008000 {
+			compatible = "mediatek,mt8173-i2c";
+			reg = <0 0x11008000 0 0x70>,
+			      <0 0x11000180 0 0x80>;
+			interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_LOW>;
+			clock-div = <16>;
+			clocks = <&pericfg CLK_PERI_I2C1>,
+				 <&pericfg CLK_PERI_AP_DMA>;
+			clock-names = "main", "dma";
+			status = "disabled";
+		};
+
+		i2c2: i2c at 11009000 {
+			compatible = "mediatek,mt8173-i2c";
+			reg = <0 0x11009000 0 0x70>,
+			      <0 0x11000200 0 0x80>;
+			interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_LOW>;
+			clock-div = <16>;
+			clocks = <&pericfg CLK_PERI_I2C2>,
+				 <&pericfg CLK_PERI_AP_DMA>;
+			clock-names = "main", "dma";
+			status = "disabled";
+		};
+
+		i2c3: i2c3 at 11010000 {
+			compatible = "mediatek,mt8173-i2c";
+			reg = <0 0x11010000 0 0x70>,
+			      <0 0x11000280 0 0x80>;
+			interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_LOW>;
+			clock-div = <16>;
+			clocks = <&pericfg CLK_PERI_I2C3>,
+				 <&pericfg CLK_PERI_AP_DMA>;
+			clock-names = "main", "dma";
+			status = "disabled";
+		};
+
+		i2c4: i2c4 at 11011000 {
+			compatible = "mediatek,mt8173-i2c";
+			reg = <0 0x11011000 0 0x70>,
+			      <0 0x11000300 0 0x80>;
+			interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_LOW>;
+			clock-div = <16>;
+			clocks = <&pericfg CLK_PERI_I2C4>,
+				 <&pericfg CLK_PERI_AP_DMA>;
+			clock-names = "main", "dma";
+			status = "disabled";
+		};
+
+		i2c6: i2c6 at 11013000 {
+			compatible = "mediatek,mt8173-i2c";
+			reg = <0 0x11013000 0 0x70>,
+			      <0 0x11000080 0 0x80>;
+			interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_LOW>;
+			clock-div = <16>;
+			clocks = <&pericfg CLK_PERI_I2C6>,
+				 <&pericfg CLK_PERI_AP_DMA>;
+			clock-names = "main", "dma";
+			status = "disabled";
+		};
+
 		uart0: serial at 11002000 {
 			compatible = "mediatek,mt8173-uart",
 					"mediatek,mt6577-uart";
-- 
1.8.1.1.dirty
