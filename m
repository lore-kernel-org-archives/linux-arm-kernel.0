From: david@lechnology.com (David Lechner)
Date: Mon, 27 Mar 2017 20:12:46 -0500
Subject: [PATCH] ARM: dts: da850: move spi0_cs3_pin pinconf node
Message-ID: <1490663566-23062-1-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This moves the spi0_cs3_pin pinconf node from the LEGO EV3 file to the
common DA850 include file. This node is applicable to any board, and
therefore belongs in the common file.

Signed-off-by: David Lechner <david@lechnology.com>
---
 arch/arm/boot/dts/da850-lego-ev3.dts | 7 -------
 arch/arm/boot/dts/da850.dtsi         | 6 ++++++
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/da850-lego-ev3.dts b/arch/arm/boot/dts/da850-lego-ev3.dts
index c20580a..512604a 100644
--- a/arch/arm/boot/dts/da850-lego-ev3.dts
+++ b/arch/arm/boot/dts/da850-lego-ev3.dts
@@ -177,13 +177,6 @@
 &pmx_core {
 	status = "okay";
 
-	spi0_cs3_pin: pinmux_spi0_cs3_pin {
-		pinctrl-single,bits = <
-			/* CS3 */
-			0xc 0x01000000 0x0f000000
-		>;
-	};
-
 	mmc0_cd_pin: pinmux_mmc0_cd {
 		pinctrl-single,bits = <
 			/* GP5[14] */
diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index c708155..941d455 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -153,6 +153,12 @@
 					0x10 0x00000010 0x000000f0
 				>;
 			};
+			spi0_cs3_pin: pinmux_spi0_cs3_pin {
+				pinctrl-single,bits = <
+					/* CS3 */
+					0xc 0x01000000 0x0f000000
+				>;
+			};
 			spi1_pins: pinmux_spi1_pins {
 				pinctrl-single,bits = <
 					/* SIMO, SOMI, CLK */
-- 
2.7.4
