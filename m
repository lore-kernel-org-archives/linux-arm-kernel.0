From: jbrunet@baylibre.com (Jerome Brunet)
Date: Wed, 16 May 2018 17:52:02 +0200
Subject: [PATCH 1/2] ARM64: dts: meson-axg: clean-up i2c nodes
In-Reply-To: <20180516155203.24922-1-jbrunet@baylibre.com>
References: <20180516155203.24922-1-jbrunet@baylibre.com>
Message-ID: <20180516155203.24922-2-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove undocumented and unused "clk_i2c" clock name and second interrupt
from i2c nodes of meson-axg platform

Those seems to have been copy/pasted from the vendor kernel

Fixes: dc6f858e2690 ("ARM64: dts: meson-axg: add I2C DT info for Meson-AXG SoC")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 37 +++++++++++-------------------
 1 file changed, 14 insertions(+), 23 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index 381bd2c707a7..b59f341104d7 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -214,50 +214,42 @@
 
 			i2c0: i2c at 1f000 {
 				compatible = "amlogic,meson-axg-i2c";
-				status = "disabled";
 				reg = <0x0 0x1f000 0x0 0x20>;
-				interrupts = <GIC_SPI 21 IRQ_TYPE_EDGE_RISING>,
-					<GIC_SPI 47 IRQ_TYPE_EDGE_RISING>;
+				interrupts = <GIC_SPI 21 IRQ_TYPE_EDGE_RISING>;
+				clocks = <&clkc CLKID_I2C>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				clocks = <&clkc CLKID_I2C>;
-				clock-names = "clk_i2c";
+				status = "disabled";
 			};
 
 			i2c1: i2c at 1e000 {
 				compatible = "amlogic,meson-axg-i2c";
+				reg = <0x0 0x1e000 0x0 0x20>;
+				interrupts = <GIC_SPI 214 IRQ_TYPE_EDGE_RISING>;
+				clocks = <&clkc CLKID_I2C>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				reg = <0x0 0x1e000 0x0 0x20>;
 				status = "disabled";
-				interrupts = <GIC_SPI 214 IRQ_TYPE_EDGE_RISING>,
-					<GIC_SPI 48 IRQ_TYPE_EDGE_RISING>;
-				clocks = <&clkc CLKID_I2C>;
-				clock-names = "clk_i2c";
 			};
 
 			i2c2: i2c at 1d000 {
 				compatible = "amlogic,meson-axg-i2c";
-				status = "disabled";
 				reg = <0x0 0x1d000 0x0 0x20>;
-				interrupts = <GIC_SPI 215 IRQ_TYPE_EDGE_RISING>,
-					<GIC_SPI 49 IRQ_TYPE_EDGE_RISING>;
+				interrupts = <GIC_SPI 215 IRQ_TYPE_EDGE_RISING>;
+				clocks = <&clkc CLKID_I2C>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				clocks = <&clkc CLKID_I2C>;
-				clock-names = "clk_i2c";
+				status = "disabled";
 			};
 
 			i2c3: i2c at 1c000 {
 				compatible = "amlogic,meson-axg-i2c";
-				status = "disabled";
 				reg = <0x0 0x1c000 0x0 0x20>;
-				interrupts = <GIC_SPI 39 IRQ_TYPE_EDGE_RISING>,
-					<GIC_SPI 50 IRQ_TYPE_EDGE_RISING>;
+				interrupts = <GIC_SPI 39 IRQ_TYPE_EDGE_RISING>;
+				clocks = <&clkc CLKID_I2C>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				clocks = <&clkc CLKID_I2C>;
-				clock-names = "clk_i2c";
+				status = "disabled";
 			};
 
 			uart_A: serial at 24000 {
@@ -1116,13 +1108,12 @@
 
 			i2c_AO: i2c at 5000 {
 				compatible = "amlogic,meson-axg-i2c";
-				status = "disabled";
 				reg = <0x0 0x05000 0x0 0x20>;
 				interrupts = <GIC_SPI 195 IRQ_TYPE_EDGE_RISING>;
+				clocks = <&clkc CLKID_I2C>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				clocks = <&clkc CLKID_I2C>;
-				clock-names = "clk_i2c";
+				status = "disabled";
 			};
 
 			uart_AO: serial at 3000 {
-- 
2.14.3
