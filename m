From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Tue, 12 Aug 2014 18:44:24 +0200
Subject: [PATCH 2/6] ARM: dts: Use tps65090 fragment in exynos5250-snow
In-Reply-To: <1407861868-20097-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1407861868-20097-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <1407861868-20097-3-git-send-email-javier.martinez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that there is a .dtsi fragment file for the tps65090 PMU,
include it in the Exynos Snow DTS file to reduce duplication.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 arch/arm/boot/dts/exynos5250-snow.dts | 108 +++++++++++++++++-----------------
 1 file changed, 54 insertions(+), 54 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5250-snow.dts b/arch/arm/boot/dts/exynos5250-snow.dts
index f2b8c41..159a497 100644
--- a/arch/arm/boot/dts/exynos5250-snow.dts
+++ b/arch/arm/boot/dts/exynos5250-snow.dts
@@ -147,8 +147,7 @@
 				wakeup-source;
 			};
 
-			power-regulator {
-				compatible = "ti,tps65090";
+			tps: power-regulator {
 				reg = <0x48>;
 
 				/*
@@ -170,58 +169,6 @@
 				infet7-supply = <&vbat>;
 				vsys-l1-supply = <&vbat>;
 				vsys-l2-supply = <&vbat>;
-
-				regulators {
-					dcdc1 {
-						ti,enable-ext-control;
-					};
-					dcdc2 {
-						ti,enable-ext-control;
-					};
-					dcdc3 {
-						ti,enable-ext-control;
-					};
-					fet1 {
-						regulator-name = "vcd_led";
-						ti,overcurrent-wait = <3>;
-					};
-					tps65090_fet2: fet2 {
-						regulator-name = "video_mid";
-						regulator-always-on;
-						ti,overcurrent-wait = <3>;
-					};
-					fet3 {
-						regulator-name = "wwan_r";
-						regulator-always-on;
-						ti,overcurrent-wait = <3>;
-					};
-					fet4 {
-						regulator-name = "sdcard";
-						ti,overcurrent-wait = <3>;
-					};
-					fet5 {
-						regulator-name = "camout";
-						regulator-always-on;
-						ti,overcurrent-wait = <3>;
-					};
-					fet6 {
-						regulator-name = "lcd_vdd";
-						ti,overcurrent-wait = <3>;
-					};
-					tps65090_fet7: fet7 {
-						regulator-name = "video_mid_1a";
-						regulator-always-on;
-						ti,overcurrent-wait = <3>;
-					};
-					ldo1 {
-					};
-					ldo2 {
-					};
-				};
-
-				charger {
-					compatible = "ti,tps65090-charger";
-				};
 			};
 		};
 	};
@@ -344,6 +291,59 @@
 	};
 };
 
+#include "tps65090.dtsi"
+
+&tps65090_dcdc1 {
+	ti,enable-ext-control;
+};
+
+&tps65090_dcdc2 {
+	ti,enable-ext-control;
+};
+
+&tps65090_dcdc3 {
+	ti,enable-ext-control;
+};
+
+&tps65090_fet1 {
+	regulator-name = "vcd_led";
+	ti,overcurrent-wait = <3>;
+};
+
+&tps65090_fet2 {
+	regulator-name = "video_mid";
+	regulator-always-on;
+	ti,overcurrent-wait = <3>;
+};
+
+&tps65090_fet3 {
+	regulator-name = "wwan_r";
+	regulator-always-on;
+	ti,overcurrent-wait = <3>;
+};
+
+&tps65090_fet4 {
+	regulator-name = "sdcard";
+	ti,overcurrent-wait = <3>;
+};
+
+&tps65090_fet5 {
+	regulator-name = "camout";
+	regulator-always-on;
+	ti,overcurrent-wait = <3>;
+};
+
+&tps65090_fet6 {
+	regulator-name = "lcd_vdd";
+	ti,overcurrent-wait = <3>;
+};
+
+&tps65090_fet7 {
+	regulator-name = "video_mid_1a";
+	regulator-always-on;
+	ti,overcurrent-wait = <3>;
+};
+
 &i2c_0 {
 	max77686 at 09 {
 		compatible = "maxim,max77686";
-- 
2.0.0.rc2
