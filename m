From: balbi@ti.com (Felipe Balbi)
Date: Thu, 19 Feb 2015 13:57:38 -0600
Subject: [PATCH] arm: boot: dts: am437x-idk: enable i2c2
Message-ID: <1424375858-26664-1-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

i2c2 goes to an expansion connector which we
want to use.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/boot/dts/am437x-idk-evm.dts | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/am437x-idk-evm.dts b/arch/arm/boot/dts/am437x-idk-evm.dts
index 2471f1ebd4ed..22c2031dea17 100644
--- a/arch/arm/boot/dts/am437x-idk-evm.dts
+++ b/arch/arm/boot/dts/am437x-idk-evm.dts
@@ -133,6 +133,20 @@
 		>;
 	};
 
+	i2c2_pins_default: i2c2_pins_default {
+		pinctrl-single,pins = <
+			0x1e8 (PIN_INPUT | SLEWCTRL_FAST | MUX_MODE3) /* cam1_data1.i2c2_scl */
+			0x1ec (PIN_INPUT | SLEWCTRL_FAST | MUX_MODE3) /* cam1_data0.i2c2_sda */
+		>;
+	};
+
+	i2c2_pins_sleep: i2c2_pins_sleep {
+		pinctrl-single,pins = <
+			0x1e8 (PIN_INPUT_PULLDOWN | MUX_MODE7)
+			0x1ec (PIN_INPUT_PULLDOWN | MUX_MODE7)
+		>;
+	};
+
 	mmc1_pins_default: pinmux_mmc1_pins_default {
 		pinctrl-single,pins = <
 			0x100 (PIN_INPUT | MUX_MODE0) /* mmc0_clk.mmc0_clk */
@@ -263,6 +277,14 @@
 	};
 };
 
+&i2c2 {
+	status = "okay";
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&i2c2_pins_default>;
+	pinctrl-1 = <&i2c2_pins_sleep>;
+	clock-frequency = <100000>;
+};
+
 &epwmss0 {
 	status = "okay";
 };
-- 
2.3.0
