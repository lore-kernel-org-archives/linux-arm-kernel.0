From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 15 Nov 2013 19:19:07 +0100
Subject: [PATCH v4 4/4] ARM: sun6i: Add the reset controller to the DTSI
In-Reply-To: <1384539547-29463-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1384539547-29463-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1384539547-29463-5-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A31 has a reset controller IP that maintains a few other IPs in
reset, among which we can find the UARTs, high speed timers or the I2C.
Now that we have support for them, add the reset controllers to the DTSI.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun6i-a31.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index c1751a64889a..7e8d630138f5 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -209,6 +209,24 @@
 			};
 		};
 
+		ahb1_rst: reset at 01c202c0 {
+			#reset-cells = <1>;
+			compatible = "allwinner,sun6i-a31-ahb1-reset";
+			reg = <0x01c202c0 0xc>;
+		};
+
+		apb1_rst: reset at 01c202d0 {
+			#reset-cells = <1>;
+			compatible = "allwinner,sun6i-a31-clock-reset";
+			reg = <0x01c202d0 0x4>;
+		};
+
+		apb2_rst: reset at 01c202d8 {
+			#reset-cells = <1>;
+			compatible = "allwinner,sun6i-a31-clock-reset";
+			reg = <0x01c202d8 0x4>;
+		};
+
 		timer at 01c20c00 {
 			compatible = "allwinner,sun4i-timer";
 			reg = <0x01c20c00 0xa0>;
@@ -232,6 +250,7 @@
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			clocks = <&apb2_gates 16>;
+			resets = <&apb2_rst 16>;
 			status = "disabled";
 		};
 
@@ -242,6 +261,7 @@
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			clocks = <&apb2_gates 17>;
+			resets = <&apb2_rst 17>;
 			status = "disabled";
 		};
 
@@ -252,6 +272,7 @@
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			clocks = <&apb2_gates 18>;
+			resets = <&apb2_rst 18>;
 			status = "disabled";
 		};
 
@@ -262,6 +283,7 @@
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			clocks = <&apb2_gates 19>;
+			resets = <&apb2_rst 19>;
 			status = "disabled";
 		};
 
@@ -272,6 +294,7 @@
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			clocks = <&apb2_gates 20>;
+			resets = <&apb2_rst 20>;
 			status = "disabled";
 		};
 
@@ -282,6 +305,7 @@
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			clocks = <&apb2_gates 21>;
+			resets = <&apb2_rst 21>;
 			status = "disabled";
 		};
 
-- 
1.8.4.2
