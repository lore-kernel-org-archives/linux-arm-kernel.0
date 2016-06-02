From: wens@csie.org (Chen-Yu Tsai)
Date: Thu,  2 Jun 2016 15:50:09 +0800
Subject: [PATCH 1/3] ARM: dts: sun8i-h3: move uart0 pins to sort pinmux list
 in proper order
In-Reply-To: <1464853811-15233-1-git-send-email-wens@csie.org>
References: <1464853811-15233-1-git-send-email-wens@csie.org>
Message-ID: <1464853811-15233-2-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move uart0 pins to sort the list of pin settings in alphabetical order.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-h3.dtsi | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
index 4a4926b0b0ed..52558046dbaf 100644
--- a/arch/arm/boot/dts/sun8i-h3.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3.dtsi
@@ -501,13 +501,6 @@
 			interrupt-controller;
 			#interrupt-cells = <3>;
 
-			uart0_pins_a: uart0 at 0 {
-				allwinner,pins = "PA4", "PA5";
-				allwinner,function = "uart0";
-				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
-			};
-
 			mmc0_pins_a: mmc0 at 0 {
 				allwinner,pins = "PF0", "PF1", "PF2", "PF3",
 						 "PF4", "PF5";
@@ -540,6 +533,13 @@
 				allwinner,drive = <SUN4I_PINCTRL_30_MA>;
 				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
+
+			uart0_pins_a: uart0 at 0 {
+				allwinner,pins = "PA4", "PA5";
+				allwinner,function = "uart0";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
 		};
 
 		ahb_rst: reset at 01c202c0 {
-- 
2.8.1
