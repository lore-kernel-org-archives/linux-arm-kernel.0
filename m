From: m.reichl@fivetechno.de (Markus Reichl)
Date: Mon, 13 Apr 2015 10:43:54 +0200
Subject: [RESEND] [PATCH 1/1] ARM: dts: Add LEDs on odroid XU3 board
Message-ID: <552B81CA.4090102@fivetechno.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the RGB-LED on XU3 as 3 gpio-leds.
It is derived from hardkernel's 3.10 tree.

Tested-by: Anand Moon <linux.amoon@gmail.com>
Signed-off-by: Markus Reichl <m.reichl@fivetechno.de>
---
 arch/arm/boot/dts/exynos5422-odroidxu3.dts | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3.dts b/arch/arm/boot/dts/exynos5422-odroidxu3.dts
index a519c86..0a32302 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu3.dts
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3.dts
@@ -278,6 +278,30 @@
 	rtc at 101E0000 {
 		status = "okay";
 	};
+
+	leds {
+		compatible = "gpio-leds";
+		heartbeat {
+			label = "blue:heartbeart";
+			gpios = <&gpb2 2 0>;
+			default-state = "off";
+			linux,default-trigger = "heartbeat";
+		};
+
+		eMMC {
+			label = "green:eMMC";
+			gpios = <&gpb2 1 0>;
+			default-state = "off";
+			linux,default-trigger = "mmc0";
+		};
+
+		microSD {
+			label = "red:microSD";
+			gpios = <&gpx2 3 0>;
+			default-state = "off";
+			linux,default-trigger = "mmc1";
+		};
+	};
 };
 
 &hdmi {
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
