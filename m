From: menschel.p@posteo.de (Patrick Menschel)
Date: Tue,  4 Apr 2017 20:36:32 +0200
Subject: [PATCH v4 6/6] ARM: dts: sun7i: Add can0_pins_a pinctrl settings
In-Reply-To: <1491330992-9876-1-git-send-email-menschel.p@posteo.de>
References: <1491330992-9876-1-git-send-email-menschel.p@posteo.de>
Message-ID: <1491330992-9876-7-git-send-email-menschel.p@posteo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A20 SoC has an on-board CAN controller. This patch adds
the pinctrl settings for pins PH20 and PH21.

This patch is adapted from the description in
Documentation/devicetree/bindings/net/can/sun4i_can.txt

Signed-off-by: Patrick Menschel <menschel.p@posteo.de>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index edf85ca..31aaa02 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -1096,6 +1096,11 @@
 			#interrupt-cells = <3>;
 			#gpio-cells = <3>;
 
+			can0_pins_a: can0 at 0 {
+				pins = "PH20", "PH21";
+				function = "can";
+			};
+
 			clk_out_a_pins_a: clk_out_a at 0 {
 				pins = "PI12";
 				function = "clk_out_a";
-- 
2.7.4
