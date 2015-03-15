From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Sun, 15 Mar 2015 23:00:34 +0100
Subject: [PATCH v4 5/5] ARM: dts: Add LEDs to exynos5410-odroidxu
In-Reply-To: <1426456834-6308-1-git-send-email-afaerber@suse.de>
References: <1426456834-6308-1-git-send-email-afaerber@suse.de>
Message-ID: <1426456834-6308-6-git-send-email-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Hakjoo Kim <ruppi.kim@hardkernel.com>
Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v2 -> v3: Unchanged
 
 v1 -> v2:
 * Filled in Sob from Hakjoo Kim
 
 arch/arm/boot/dts/exynos5410-odroidxu.dts | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5410-odroidxu.dts b/arch/arm/boot/dts/exynos5410-odroidxu.dts
index 97310bb727e2..b02cd3ab7b38 100644
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
2.3.1
