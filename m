From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 20 Nov 2018 14:53:11 +0800
Subject: [PATCH 3/3] arm64: dts: allwinner: h6: orangepi: Add device nodes for
 LEDs
In-Reply-To: <20181120065311.30009-1-wens@csie.org>
References: <20181120065311.30009-1-wens@csie.org>
Message-ID: <20181120065311.30009-4-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Orange Pi Lite 2 and Orange Pi One Plus both have two LEDs, one red
and one green. These are driven directly by GPIO lines in an active high
arrangement. The red LED is labeled "power", so it is set to be on by
default.

Note that the default drive current for the GPIO lines makes the LEDs
very bright.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 .../boot/dts/allwinner/sun50i-h6-orangepi.dtsi    | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
index f16b7ffbe797..b2526dac2fcf 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
@@ -22,6 +22,21 @@
 		stdout-path = "serial0:115200n8";
 	};
 
+	leds {
+		compatible = "gpio-leds";
+
+		power {
+			label = "orangepi:red:power";
+			gpios = <&r_pio 0 4 GPIO_ACTIVE_HIGH>; /* PL4 */
+			default-state = "on";
+		};
+
+		status {
+			label = "orangepi:green:status";
+			gpios = <&r_pio 0 7 GPIO_ACTIVE_HIGH>; /* PL7 */
+		};
+	};
+
 	reg_vcc5v: vcc5v {
 		/* board wide 5V supply directly from the DC jack */
 		compatible = "regulator-fixed";
-- 
2.19.1
