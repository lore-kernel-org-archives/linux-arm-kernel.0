From: jbrunet@baylibre.com (Jerome Brunet)
Date: Wed, 14 Sep 2016 12:06:07 +0200
Subject: [PATCH 3/4] ARM64: dts: meson-gxbb: add I2C nodes
In-Reply-To: <1473847568-20163-1-git-send-email-jbrunet@baylibre.com>
References: <1473847568-20163-1-git-send-email-jbrunet@baylibre.com>
Message-ID: <1473847568-20163-4-git-send-email-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Neil Armstrong <narmstrong@baylibre.com>

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 40 +++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index 75aca5013e61..4aa59dc2beb9 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -242,6 +242,36 @@
 				clocks = <&clkc CLKID_SPI>;
 				status = "disabled";
 			};
+
+			i2c_A: i2c at 8500 {
+				compatible = "amlogic,meson-gxbb-i2c";
+				reg = <0x0 0x08500 0x0 0x20>;
+				interrupts = <GIC_SPI 21 IRQ_TYPE_EDGE_RISING>;
+				clocks = <&clkc CLKID_I2C>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			i2c_B: i2c at 87c0 {
+				compatible = "amlogic,meson-gxbb-i2c";
+				reg = <0x0 0x087c0 0x0 0x20>;
+				interrupts = <GIC_SPI 214 IRQ_TYPE_EDGE_RISING>;
+				clocks = <&clkc CLKID_I2C>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			i2c_C: i2c at 87e0 {
+				compatible = "amlogic,meson-gxbb-i2c";
+				reg = <0x0 0x087e0 0x0 0x20>;
+				interrupts = <GIC_SPI 215 IRQ_TYPE_EDGE_RISING>;
+				clocks = <&clkc CLKID_I2C>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
 		};
 
 		gic: interrupt-controller at c4301000 {
@@ -358,6 +388,16 @@
 				#pwm-cells = <3>;
 				status = "disabled";
 			};
+
+			i2c_AO: i2c at 500 {
+				compatible = "amlogic,meson-gxbb-i2c";
+				reg = <0x0 0x500 0x0 0x20>;
+				interrupts = <GIC_SPI 195 IRQ_TYPE_EDGE_RISING>;
+				clocks = <&clkc CLKID_AO_I2C>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
 		};
 
 		periphs: periphs at c8834000 {
-- 
2.7.4
