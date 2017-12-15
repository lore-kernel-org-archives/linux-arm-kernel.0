From: yixun.lan@amlogic.com (Yixun Lan)
Date: Fri, 15 Dec 2017 22:42:17 +0800
Subject: [PATCH v2] ARM64: dts: meson-axg: add the SPICC controller
Message-ID: <20171215144217.223593-1-yixun.lan@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sunny Luo <sunny.luo@amlogic.com>

Add DT info for the SPICC controller which found in
the Amlogic's Meson-AXG SoC.

Signed-off-by: Sunny Luo <sunny.luo@amlogic.com>
Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>

---
Changes int v2 since [1]
 - rebase to Kevin's tree, branch v4.16/dt64
 - this patch depend on clock & pinctrl DT patch

[1]
http://lists.infradead.org/pipermail/linux-amlogic/2017-November/005495.html
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 93 ++++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index d356ce74ad89..d33721005748 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -7,6 +7,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/clock/axg-clkc.h>
 
 / {
 	compatible = "amlogic,meson-axg";
@@ -120,6 +121,28 @@
 			#size-cells = <2>;
 			ranges = <0x0 0x0 0x0 0xffd00000 0x0 0x25000>;
 
+			spicc0: spi at 13000 {
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
+			spicc1: spi at 15000 {
+				compatible = "amlogic,meson-axg-spicc";
+				reg = <0x0 0x15000 0x0 0x3c>;
+				interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clkc CLKID_SPICC1>;
+				clock-names = "core";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
 			uart_A: serial at 24000 {
 				compatible = "amlogic,meson-gx-uart", "amlogic,meson-uart";
 				reg = <0x0 0x24000 0x0 0x14>;
@@ -194,6 +217,76 @@
 					#gpio-cells = <2>;
 					gpio-ranges = <&pinctrl_periphs 0 0 86>;
 				};
+
+				spi0_pins: spi0 {
+					mux {
+						groups = "spi0_miso",
+							"spi0_mosi",
+							"spi0_clk";
+						function = "spi0";
+					};
+				};
+
+				spi0_ss0_pins: spi0_ss0 {
+					mux {
+						groups = "spi0_ss0";
+						function = "spi0";
+					};
+				};
+
+				spi0_ss1_pins: spi0_ss1 {
+					mux {
+						groups = "spi0_ss1";
+						function = "spi0";
+					};
+				};
+
+				spi0_ss2_pins: spi0_ss2 {
+					mux {
+						groups = "spi0_ss2";
+						function = "spi0";
+					};
+				};
+
+
+				spi1_a_pins: spi1_a {
+					mux {
+						groups = "spi1_miso_a",
+							"spi1_mosi_a",
+							"spi1_clk_a";
+						function = "spi1";
+					};
+				};
+
+				spi1_ss0_a_pins: spi1_ss0_a {
+					mux {
+						groups = "spi1_ss0_a";
+						function = "spi1";
+					};
+				};
+
+				spi1_ss1_pins: spi1_ss1 {
+					mux {
+						groups = "spi1_ss1";
+						function = "spi1";
+					};
+				};
+
+				spi1_x_pins: spi1_x {
+					mux {
+						groups = "spi1_miso_x",
+							"spi1_mosi_x",
+							"spi1_clk_x";
+						function = "spi1";
+					};
+				};
+
+				spi1_ss0_x_pins: spi1_ss0_x {
+					mux {
+						groups = "spi1_ss0_x";
+						function = "spi1";
+					};
+				};
 			};
 		};
 
-- 
2.15.1
