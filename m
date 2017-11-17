From: yixun.lan@amlogic.com (Yixun Lan)
Date: Fri, 17 Nov 2017 16:02:34 +0800
Subject: [PATCH 3/5] ARM64: dts: meson-axg: add I2C DT info for Meson-AXG SoC
In-Reply-To: <20171117080236.32504-1-yixun.lan@amlogic.com>
References: <20171117080236.32504-1-yixun.lan@amlogic.com>
Message-ID: <20171117080236.32504-4-yixun.lan@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jian Hu <jian.hu@amlogic.com>

There are four I2C masters in EE domain, and one I2C Master in
AO domain, the DT info here should describe them all.

Signed-off-by: Jian Hu <jian.hu@amlogic.com>
Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 59 ++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index 57faaa9d8013..99e967aff439 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -129,6 +129,54 @@
 				#reset-cells = <1>;
 			};
 
+			i2c_m0: i2c at 1f000 {
+				compatible = "amlogic,meson-axg-i2c";
+				status = "disabled";
+				reg = <0x0 0x1f000 0x0 0x20>;
+				interrupts = <GIC_SPI 21 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 47 IRQ_TYPE_EDGE_RISING>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				clocks = <&clkc CLKID_I2C>;
+				clock-names = "clk_i2c";
+			};
+
+			i2c_m1: i2c at 1e000 {
+				compatible = "amlogic,meson-axg-i2c";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0x0 0x1e000 0x0 0x20>;
+				status = "disabled";
+				interrupts = <GIC_SPI 214 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 48 IRQ_TYPE_EDGE_RISING>;
+				clocks = <&clkc CLKID_I2C>;
+				clock-names = "clk_i2c";
+			};
+
+			i2c_m2: i2c at 1d000 {
+				compatible = "amlogic,meson-axg-i2c";
+				status = "disabled";
+				reg = <0x0 0x1d000 0x0 0x20>;
+				interrupts = <GIC_SPI 215 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 49 IRQ_TYPE_EDGE_RISING>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				clocks = <&clkc CLKID_I2C>;
+				clock-names = "clk_i2c";
+			};
+
+			i2c_m3: i2c at 1c000 {
+				compatible = "amlogic,meson-axg-i2c";
+				status = "disabled";
+				reg = <0x0 0x1c000 0x0 0x20>;
+				interrupts = <GIC_SPI 39 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 50 IRQ_TYPE_EDGE_RISING>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				clocks = <&clkc CLKID_I2C>;
+				clock-names = "clk_i2c";
+			};
+
 			uart_A: serial at 24000 {
 				compatible = "amlogic,meson-gx-uart", "amlogic,meson-uart";
 				reg = <0x0 0x24000 0x0 0x14>;
@@ -312,6 +360,17 @@
 				};
 			};
 
+			i2c_ao: i2c at 5000 {
+				compatible = "amlogic,meson-axg-i2c";
+				status = "disabled";
+				reg = <0x0 0x05000 0x0 0x20>;
+				interrupts = <GIC_SPI 195 IRQ_TYPE_EDGE_RISING>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				clocks = <&clkc CLKID_I2C>;
+				clock-names = "clk_i2c";
+			};
+
 			uart_AO: serial at 3000 {
 				compatible = "amlogic,meson-gx-uart", "amlogic,meson-ao-uart";
 				reg = <0x0 0x3000 0x0 0x18>;
-- 
2.14.1
