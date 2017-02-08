From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Wed,  8 Feb 2017 18:00:08 +0800
Subject: [PATCH 7/8] arm64: dts: allwinner: add pinmux for A64's r_pwm
In-Reply-To: <20170208100009.29362-1-icenowy@aosc.xyz>
References: <20170208100009.29362-1-icenowy@aosc.xyz>
Message-ID: <20170208100009.29362-7-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the r_pwm controller in A64 have only one pinmux (PL10), and being
routed to the Pine64's "PI-2-bus", add the pinmux node in r_pio, then
make it the default pinctrl node for r_pwm node.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 6204aee5c6f4..6e34f5adcf06 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -431,12 +431,19 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			#gpio-cells = <3>;
+
+			r_pwm_pins: pwm at 0 {
+				pins = "PL10";
+				function = "s_pwm";
+			};
 		};
 
 		r_pwm: pwm at 01f03800 {
 			compatible = "allwinner,sun8i-h3-pwm";
 			reg = <0x01f03800 0x8>;
 			clocks = <&osc24M>;
+			pinctrl-0 = <&r_pwm_pins>;
+			pinctrl-names = "default";
 			#pwm-cells = <3>;
 			status = "disabled";
 		};
-- 
2.11.0
