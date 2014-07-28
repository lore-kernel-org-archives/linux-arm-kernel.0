From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Mon, 28 Jul 2014 14:18:12 +0200
Subject: [RFC 5/5] ARM: dts: exynos5410: Add ODROID-XU LEDs
In-Reply-To: <1406549892-5558-1-git-send-email-afaerber@suse.de>
References: <1406549892-5558-1-git-send-email-afaerber@suse.de>
Message-ID: <1406549892-5558-6-git-send-email-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 arch/arm/boot/dts/exynos5410-odroidxu.dts | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5410-odroidxu.dts b/arch/arm/boot/dts/exynos5410-odroidxu.dts
index b67112bf062a..f6e7555feeff 100644
--- a/arch/arm/boot/dts/exynos5410-odroidxu.dts
+++ b/arch/arm/boot/dts/exynos5410-odroidxu.dts
@@ -15,6 +15,7 @@
 
 /dts-v1/;
 #include "exynos5410.dtsi"
+#include <dt-bindings/gpio/gpio.h>
 / {
 	model = "ODROID-XU based on EXYNOS5410";
 	compatible = "hardkernel,odroid-xu", "samsung,exynos5410", "samsung,exynos5";
@@ -39,6 +40,30 @@
 		reg = <0x02037000 0x1000>;
 	};
 
+	leds {
+		compatible = "gpio-leds";
+
+		blue {
+			label = "blue:heartbeat";
+			gpios = <&gpb2 2 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+			linux,default-trigger = "heartbeat";
+		};
+
+		green {
+			label = "green:activity";
+			gpios = <&gpb2 1 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+			linux,default-trigger = "mmc0";
+		};
+
+		red {
+			label = "red:activity";
+			gpios = <&gpx2 3 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+			linux,default-trigger = "mmc1";
+		};
+	};
 };
 
 &mmc_0 {
-- 
1.9.3
