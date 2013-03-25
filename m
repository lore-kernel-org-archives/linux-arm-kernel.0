From: moinejf@free.fr (Jean-Francois Moine)
Date: Mon, 25 Mar 2013 10:31:59 +0100
Subject: [PATCH] ARM: dove: add more hardware description in the DT
Message-ID: <20130325103159.0c1b4f17@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 88AP510 chip (Marvell Dove) contains a LCD and display controler
and two audio controlers.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 arch/arm/boot/dts/dove.dtsi |   31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
index f7509ca..6bd36b0 100644
--- a/arch/arm/boot/dts/dove.dtsi
+++ b/arch/arm/boot/dts/dove.dtsi
@@ -253,5 +253,36 @@
 				dmacap,xor;
 			};
 		};
+
+		lcd0: lcd0 at 820000 {
+			compatible = "marvell,dove-lcd";
+			reg = <0x820000 0x1c8>;
+			interrupts = <47>;
+			status = "disabled";
+		};
+
+		lcd1: lcd1 at 810000 {
+			compatible = "marvell,dove-lcd";
+			reg = <0x810000 0x1c8>;
+			interrupts = <46>;
+			status = "disabled";
+		};
+
+		i2s0: i2s0 at b0000 {
+			compatible = "marvell,kirkwood-i2s";
+			reg = <0xb0000 0x4000>;
+			interrupt-parent = <&gpio0>;
+			interrupts = <19 2>;
+			clocks = <&gate_clk 12>;
+			status = "disabled";
+		};
+		i2s1: i2s1 at b4000 {
+			compatible = "marvell,kirkwood-i2s";
+			reg = <0xb4000 0x4000>;
+			interrupt-parent = <&gpio0>;
+			interrupts = <21 2>;
+			clocks = <&gate_clk 13>;
+			status = "disabled";
+		};
 	};
 };
-- 
1.7.10.4
