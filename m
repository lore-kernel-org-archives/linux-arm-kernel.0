From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 11 Sep 2013 11:30:02 +0200
Subject: [PATCH 1/4] ARM: sun7i: Enable the I2C controllers
In-Reply-To: <1378891805-28957-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1378891805-28957-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1378891805-28957-2-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Allwinner A20 shares the same I2C controller than the one that could
be found on earlier SoCs from Allwinner. There is only a few more of
these controllers. Add all of them in the DTSI.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 45 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 80559cb..82b1af3 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -324,6 +324,51 @@
 			status = "disabled";
 		};
 
+		i2c0: i2c at 01c2ac00 {
+			compatible = "allwinner,sun4i-i2c";
+			reg = <0x01c2ac00 0x400>;
+			interrupts = <0 7 1>;
+			clocks = <&apb1_gates 0>;
+			clock-frequency = <100000>;
+			status = "disabled";
+		};
+
+		i2c1: i2c at 01c2b000 {
+			compatible = "allwinner,sun4i-i2c";
+			reg = <0x01c2b000 0x400>;
+			interrupts = <0 8 1>;
+			clocks = <&apb1_gates 1>;
+			clock-frequency = <100000>;
+			status = "disabled";
+		};
+
+		i2c2: i2c at 01c2b400 {
+			compatible = "allwinner,sun4i-i2c";
+			reg = <0x01c2b400 0x400>;
+			interrupts = <0 9 1>;
+			clocks = <&apb1_gates 2>;
+			clock-frequency = <100000>;
+			status = "disabled";
+		};
+
+		i2c3: i2c at 01c2b800 {
+			compatible = "allwinner,sun4i-i2c";
+			reg = <0x01c2b800 0x400>;
+			interrupts = <0 88 1>;
+			clocks = <&apb1_gates 3>;
+			clock-frequency = <100000>;
+			status = "disabled";
+		};
+
+		i2c4: i2c at 01c2bc00 {
+			compatible = "allwinner,sun4i-i2c";
+			reg = <0x01c2bc00 0x400>;
+			interrupts = <0 89 1>;
+			clocks = <&apb1_gates 15>;
+			clock-frequency = <100000>;
+			status = "disabled";
+		};
+
 		gic: interrupt-controller at 01c81000 {
 			compatible = "arm,cortex-a7-gic", "arm,cortex-a15-gic";
 			reg = <0x01c81000 0x1000>,
-- 
1.8.4
