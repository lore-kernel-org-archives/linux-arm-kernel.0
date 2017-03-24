From: menschel.p@posteo.de (Patrick Menschel)
Date: Fri, 24 Mar 2017 22:52:18 +0100
Subject: [PATCH v2 1/2] ARM: dts: sun4i: Add CAN node and can0_pins_a pinctrl
 settings
In-Reply-To: <1490392339-23565-1-git-send-email-menschel.p@posteo.de>
References: <1490392339-23565-1-git-send-email-menschel.p@posteo.de>
Message-ID: <1490392339-23565-2-git-send-email-menschel.p@posteo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A10 SoC has an on-board CAN controller. This patch adds the device node
and the corresponding pinctrl settings for pins PH20 and PH21.

This patch is adapted from the description in
Documentation/devicetree/bindings/net/can/sun4i_can.txt

Signed-off-by: Patrick Menschel <menschel.p@posteo.de>
---
 arch/arm/boot/dts/sun4i-a10.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index ba20b48..f7dced4 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -974,6 +974,11 @@
 			#interrupt-cells = <3>;
 			#gpio-cells = <3>;
 
+			can0_pins_a: can0 at 0 {
+				pins = "PH20","PH21";
+				function = "can";
+			};
+
 			emac_pins_a: emac0 at 0 {
 				pins = "PA0", "PA1", "PA2",
 				       "PA3", "PA4", "PA5", "PA6",
@@ -1313,6 +1318,14 @@
 			#size-cells = <0>;
 		};
 
+		can0: can at 01c2bc00 {
+			compatible = "allwinner,sun4i-a10-can";
+			reg = <0x01c2bc00 0x400>;
+			interrupts = <26>;
+			clocks = <&apb1_gates 4>;
+			status = "disabled";
+		};
+
 		ps20: ps2 at 01c2a000 {
 			compatible = "allwinner,sun4i-a10-ps2";
 			reg = <0x01c2a000 0x400>;
-- 
1.9.1
