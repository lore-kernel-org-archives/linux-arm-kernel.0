From: wens@csie.org (Chen-Yu Tsai)
Date: Tue,  1 Dec 2015 13:47:24 +0800
Subject: [PATCH 6/7] ARM: dts: sun9i: Add Reduced Serial Bus controller device
 node to A80 dtsi
In-Reply-To: <1448948845-28347-1-git-send-email-wens@csie.org>
References: <1448948845-28347-1-git-send-email-wens@csie.org>
Message-ID: <1448948845-28347-7-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a device node for the Reduced Serial Bus (RSB)
controller and the defacto pinmux setting to the A80 dtsi.

Since there is only one possible pinmux setting for RSB, just
set it in the dtsi.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun9i-a80.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/sun9i-a80.dtsi b/arch/arm/boot/dts/sun9i-a80.dtsi
index 80777a33ee78..dc666c69f6ab 100644
--- a/arch/arm/boot/dts/sun9i-a80.dtsi
+++ b/arch/arm/boot/dts/sun9i-a80.dtsi
@@ -900,6 +900,27 @@
 				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
 				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
+
+			r_rsb_pins: r_rsb {
+				allwinner,pins = "PN0", "PN1";
+				allwinner,function = "s_rsb";
+				allwinner,drive = <SUN4I_PINCTRL_20_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
+			};
+		};
+
+		r_rsb: i2c at 08003400 {
+			compatible = "allwinner,sun8i-a23-rsb";
+			reg = <0x08003400 0x400>;
+			interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&apbs_gates 3>;
+			clock-frequency = <3000000>;
+			resets = <&apbs_rst 3>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&r_rsb_pins>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
 		};
 	};
 };
-- 
2.6.2
