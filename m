From: wens@csie.org (Chen-Yu Tsai)
Date: Mon,  6 Jan 2014 13:58:12 +0800
Subject: [PATCH v2 8/8] arm: sun7i: cubietruck: Enable the i2c controllers
In-Reply-To: <1388987892-23733-1-git-send-email-wens@csie.org>
References: <1388987892-23733-1-git-send-email-wens@csie.org>
Message-ID: <1388987892-23733-9-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Cubietruck makes use of the first three i2c controllers found on the
Allwinner A20; i2c-0 is used internally for the PMIC, i2c-1 is exposed on
the board headers, and i2c-2 is used for DDC on the VGA connector. This
patch enables them in the device tree.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
index 8a1009d..f9dcb61 100644
--- a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
+++ b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
@@ -33,6 +33,24 @@
 			pinctrl-0 = <&uart0_pins_a>;
 			status = "okay";
 		};
+
+		i2c0: i2c at 01c2ac00 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c0_pins_a>;
+			status = "okay";
+		};
+
+		i2c1: i2c at 01c2b000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c1_pins_a>;
+			status = "okay";
+		};
+
+		i2c2: i2c at 01c2b400 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c2_pins_a>;
+			status = "okay";
+		};
 	};
 
 	leds {
-- 
1.8.5.2
