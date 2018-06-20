From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 20 Jun 2018 15:13:41 +0800
Subject: [PATCH] arm64: dts: allwinner: h6: Add LED device nodes for Pine H64
Message-ID: <20180620071341.8143-1-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Pine H64 has 3 GPIO-controlled LEDs, which are labeled "heartbeat",
"link", and "status".

Add device nodes for them.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 .../boot/dts/allwinner/sun50i-h6-pine-h64.dts | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
index b6f2d6b2ecae..2e97173c9204 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
@@ -20,6 +20,25 @@
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		heartbeat {
+			label = "pine-h64:green:heartbeat";
+			gpios = <&r_pio 0 4 GPIO_ACTIVE_HIGH>; /* PL4 */
+		};
+
+		link {
+			label = "pine-h64:white:link";
+			gpios = <&r_pio 0 3 GPIO_ACTIVE_HIGH>; /* PL3 */
+		};
+
+		status {
+			label = "pine-h64:blue:status";
+			gpios = <&r_pio 0 7 GPIO_ACTIVE_HIGH>; /* PL7 */
+		};
+	};
 };
 
 &r_i2c {
-- 
2.17.1
