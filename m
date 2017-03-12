From: menschel.p@posteo.de (Patrick Menschel)
Date: Sun, 12 Mar 2017 14:28:10 +0100
Subject: [PATCH 1/2] ARM: dts: sun4i: Add CAN node and can0_pins_a pinctrl
 settings
In-Reply-To: <1489325291-6298-1-git-send-email-menschel.p@posteo.de>
References: <1489325291-6298-1-git-send-email-menschel.p@posteo.de>
Message-ID: <1489325291-6298-2-git-send-email-menschel.p@posteo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A10 SoC has an on-board CAN controller. This patch adds the device node
and the corresponding pinctrl settings for pins PH20 and PH21.

This patch is adapted from the description in
Documentation/devicetree/bindings/net/can/sun4i_can.txt

Signed-off-by: Patrick Menschel <menschel.p@posteo.de>
---
 arch/arm/boot/dts/sun4i-a10.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index b14a428..210b616 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -1160,6 +1160,13 @@
 				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
 				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
+
+			can0_pins_a: can0 at 0 {
+				allwinner,pins = "PH20","PH21";
+				allwinner,function = "can";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
 		};
 
 		timer at 01c20c00 {
@@ -1376,5 +1383,13 @@
 			clocks = <&apb1_gates 7>;
 			status = "disabled";
 		};
+
+		can0: can at 01c2bc00 {
+			compatible = "allwinner,sun4i-a10-can";
+			reg = <0x01c2bc00 0x400>;
+			interrupts = <26>;
+			clocks = <&apb1_gates 4>;
+			status = "disabled";
+		};
 	};
 };
-- 
1.9.1
