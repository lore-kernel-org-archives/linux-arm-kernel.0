From: leilk.liu@mediatek.com (Leilk Liu)
Date: Wed, 29 Jul 2015 19:04:34 +0800
Subject: [PATCH v4 3/3] arm64: dts: Add spi bus dts
In-Reply-To: <1438167874-1305-1-git-send-email-leilk.liu@mediatek.com>
References: <1438167874-1305-1-git-send-email-leilk.liu@mediatek.com>
Message-ID: <1438167874-1305-4-git-send-email-leilk.liu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds MT8173 spi bus controllers into device tree.

Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8173.dtsi | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index d18ee42..2a88d93 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -220,6 +220,15 @@
 					bias-disable;
 				};
 			};
+
+			spi_pins_a: spi0 {
+				pins_spi {
+					pinmux = <MT8173_PIN_69_SPI_CK__FUNC_SPI_CK_0_>,
+						<MT8173_PIN_70_SPI_MI__FUNC_SPI_MI_0_>,
+						<MT8173_PIN_71_SPI_MO__FUNC_SPI_MO_0_>,
+						<MT8173_PIN_72_SPI_CS__FUNC_SPI_CS_0_>;
+				};
+			};
 		};
 
 		scpsys: scpsys at 10006000 {
@@ -365,6 +374,20 @@
 			status = "disabled";
 		};
 
+		spi: spi at 1100a000 {
+			compatible = "mediatek,mt8173-spi";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0 0x1100a000 0 0x1000>;
+			interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&pericfg CLK_PERI_SPI0>;
+			clock-names = "main";
+			pinctrl-names = "default";
+			pinctrl-0 = <&spi_pins_a>;
+			pad-select = <0>;
+			status = "disabled";
+		};
+
 		i2c3: i2c3 at 11010000 {
 			compatible = "mediatek,mt8173-i2c";
 			reg = <0 0x11010000 0 0x70>,
-- 
1.8.1.1.dirty
