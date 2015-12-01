From: wens@csie.org (Chen-Yu Tsai)
Date: Tue,  1 Dec 2015 13:47:22 +0800
Subject: [PATCH 4/7] ARM: dts: sun9i: Add consumer IR receiver device node and
 pinmux settings
In-Reply-To: <1448948845-28347-1-git-send-email-wens@csie.org>
References: <1448948845-28347-1-git-send-email-wens@csie.org>
Message-ID: <1448948845-28347-5-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Allwinner A80 SoC has a consumer IR receiver, which is the same as
older SoCs.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun9i-a80.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/sun9i-a80.dtsi b/arch/arm/boot/dts/sun9i-a80.dtsi
index d02ee5d520e2..80777a33ee78 100644
--- a/arch/arm/boot/dts/sun9i-a80.dtsi
+++ b/arch/arm/boot/dts/sun9i-a80.dtsi
@@ -858,6 +858,18 @@
 			#reset-cells = <1>;
 		};
 
+		r_ir: ir at 08002000 {
+			compatible = "allwinner,sun5i-a13-ir";
+			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&r_ir_pins>;
+			clocks = <&apbs_gates 1>, <&r_ir_clk>;
+			clock-names = "apb", "ir";
+			resets = <&apbs_rst 1>;
+			reg = <0x08002000 0x40>;
+			status = "disabled";
+		};
+
 		r_uart: serial at 08002800 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x08002800 0x400>;
@@ -881,6 +893,13 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			#gpio-cells = <3>;
+
+			r_ir_pins: r_ir {
+				allwinner,pins = "PL6";
+				allwinner,function = "s_cir_rx";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
 		};
 	};
 };
-- 
2.6.2
