From: yixun.lan@amlogic.com (Yixun Lan)
Date: Tue, 28 Nov 2017 21:29:26 +0800
Subject: [PATCH 3/3] ARM64: dts: meson-axg: add the SPICC controller
In-Reply-To: <20171128132926.19051-1-yixun.lan@amlogic.com>
References: <20171128132926.19051-1-yixun.lan@amlogic.com>
Message-ID: <20171128132926.19051-4-yixun.lan@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sunny Luo <sunny.luo@amlogic.com>

Add DT info for the SPICC controller which found in
the Amlogic's Meson-AXG SoC.

Signed-off-by: Sunny Luo <sunny.luo@amlogic.com>
Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 92 ++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index fe3878f7718c..021b929d8d6e 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -208,6 +208,28 @@
 				interrupts = <GIC_SPI 75 IRQ_TYPE_EDGE_RISING>;
 				status = "disabled";
 			};
+
+			spicc_a: spi at 13000 {
+				compatible = "amlogic,meson-axg-spicc";
+				reg = <0x0 0x13000 0x0 0x3c>;
+				interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clkc CLKID_SPICC0>;
+				clock-names = "core";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			spicc_b: spi at 15000 {
+				compatible = "amlogic,meson-axg-spicc";
+				reg = <0x0 0x15000 0x0 0x3c>;
+				interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clkc CLKID_SPICC1>;
+				clock-names = "core";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
 		};
 
 		gic: interrupt-controller at ffc01000 {
@@ -470,6 +492,76 @@
 						function = "pwm_d";
 					};
 				};
+
+				spi_a_pins: spi_a {
+					mux {
+						groups = "spi_miso_a",
+							"spi_mosi_a",
+							"spi_clk_a";
+						function = "spi_a";
+					};
+				};
+
+				spi_ss0_a_pins: spi_ss0_a {
+					mux {
+						groups = "spi_ss0_a";
+						function = "spi_a";
+					};
+				};
+
+				spi_ss1_a_pins: spi_ss1_a {
+					mux {
+						groups = "spi_ss1_a";
+						function = "spi_a";
+					};
+				};
+
+				spi_ss2_a_pins: spi_ss2_a {
+					mux {
+						groups = "spi_ss2_a";
+						function = "spi_a";
+					};
+				};
+
+
+				spi_b_a_pins: spi_b_a {
+					mux {
+						groups = "spi_miso_b_a",
+							"spi_mosi_b_a",
+							"spi_clk_b_a";
+						function = "spi_b";
+					};
+				};
+
+				spi_ss0_b_a_pins: spi_ss0_b_a {
+					mux {
+						groups = "spi_ss0_b_a";
+						function = "spi_b";
+					};
+				};
+
+				spi_ss1_b_pins: spi_ss1_b {
+					mux {
+						groups = "spi_ss1_b";
+						function = "spi_b";
+					};
+				};
+
+				spi_b_x_pins: spi_b_x {
+					mux {
+						groups = "spi_miso_b_x",
+							"spi_mosi_b_x",
+							"spi_clk_b_x";
+						function = "spi_b";
+					};
+				};
+
+				spi_ss0_b_x_pins: spi_ss0_b_x {
+					mux {
+						groups = "spi_ss0_b_x";
+						function = "spi_b";
+					};
+				};
 			};
 		};
 
-- 
2.15.0
