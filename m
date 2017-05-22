From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 22 May 2017 15:59:00 +0200
Subject: [PATCH 27/35] arm64: dts: salvator-x: Add panel backlight support
In-Reply-To: <cover.1495457812.git.horms+renesas@verge.net.au>
References: <cover.1495457812.git.horms+renesas@verge.net.au>
Message-ID: <b33be336702175334031f558951374b694bc4cb1.1495457812.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The panel backlight is controlled through a GPIO and a PWM channel.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
[simon: apply to salvator-x.dtsi instead of r8a7795-salvator-x.dts]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/salvator-x.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/salvator-x.dtsi b/arch/arm64/boot/dts/renesas/salvator-x.dtsi
index d5eb022d247c..7240bcd75918 100644
--- a/arch/arm64/boot/dts/renesas/salvator-x.dtsi
+++ b/arch/arm64/boot/dts/renesas/salvator-x.dtsi
@@ -58,6 +58,16 @@
 		clock-frequency = <11289600>;
 	};
 
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pwm1 0 50000>;
+
+		brightness-levels = <256 128 64 16 8 4 0>;
+		default-brightness-level = <6>;
+
+		enable-gpios = <&gpio6 7 GPIO_ACTIVE_HIGH>;
+	};
+
 	reg_1p8v: regulator0 {
 		compatible = "regulator-fixed";
 		regulator-name = "fixed-1.8V";
@@ -358,6 +368,11 @@
 		function = "i2c2";
 	};
 
+	pwm1_pins: pwm {
+		groups = "pwm1_a";
+		function = "pwm1";
+	};
+
 	scif1_pins: scif1 {
 		groups = "scif1_data_a", "scif1_ctrl";
 		function = "scif1";
@@ -443,6 +458,13 @@
 	};
 };
 
+&pwm1 {
+	pinctrl-0 = <&pwm1_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
 &rcar_sound {
 	pinctrl-0 = <&sound_pins &sound_clk_pins>;
 	pinctrl-names = "default";
-- 
2.1.4
