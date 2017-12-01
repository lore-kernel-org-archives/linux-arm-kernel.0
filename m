From: yixun.lan@amlogic.com (Yixun Lan)
Date: Fri, 1 Dec 2017 09:36:12 +0800
Subject: [PATCH] ARM64: dts: meson-axg: enable IR controller
Message-ID: <20171201013612.13927-1-yixun.lan@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable IR remote controller which find in Amlogic's Meson-AXG SoC.

Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts |  6 ++++++
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi     | 14 ++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
index 0864d1ff2d9b..ca676cafdbb3 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
@@ -34,3 +34,9 @@
 	pinctrl-0 = <&i2c1_z_pins>;
 	pinctrl-names = "default";
 };
+
+&ir {
+	status = "okay";
+	pinctrl-0 = <&remote_input_ao_pins>;
+	pinctrl-names = "default";
+};
diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index 9bb85893c1b7..80d5b8c13fac 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -616,6 +616,13 @@
 					#gpio-cells = <2>;
 					gpio-ranges = <&pinctrl_aobus 0 0 15>;
 				};
+
+				remote_input_ao_pins: remote_input_ao {
+					mux {
+						groups = "remote_input_ao";
+						function = "remote_input_ao";
+					};
+				};
 			};
 
 			i2c_AO: i2c at 5000 {
@@ -664,6 +671,13 @@
 				clock-names = "xtal", "pclk", "baud";
 				status = "disabled";
 			};
+
+			ir: ir at 8000 {
+				compatible = "amlogic,meson-gx-ir", "amlogic,meson-gxbb-ir";
+				reg = <0x0 0x8000 0x0 0x20>;
+				interrupts = <GIC_SPI 196 IRQ_TYPE_EDGE_RISING>;
+				status = "disabled";
+			};
 		};
 	};
 };
-- 
2.15.0
