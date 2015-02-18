From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Wed, 18 Feb 2015 19:25:59 +0100
Subject: [PATCH 6/6] ARM: dts: Add sound support to exynos5250-spring
In-Reply-To: <1424283959-16289-1-git-send-email-afaerber@suse.de>
References: <1424283959-16289-1-git-send-email-afaerber@suse.de>
Message-ID: <1424283959-16289-7-git-send-email-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 arch/arm/boot/dts/exynos5250-spring.dts | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5250-spring.dts b/arch/arm/boot/dts/exynos5250-spring.dts
index 866beb4e0597..142e0550e223 100644
--- a/arch/arm/boot/dts/exynos5250-spring.dts
+++ b/arch/arm/boot/dts/exynos5250-spring.dts
@@ -49,6 +49,17 @@
 		};
 	};
 
+	sound {
+		compatible = "google,snow-audio-max98089";
+		samsung,model = "Spring-I2S-MAX98089";
+		samsung,i2s-controller = <&i2s0>;
+		samsung,audio-codec = <&max98089>;
+		clocks = <&pmu_system_controller 0>;
+		clock-names = "mclk";
+		pinctrl-names = "default";
+		pinctrl-0 = <&mic_det_gpio>, <&hp_det_gpio>;
+	};
+
 	usb-hub {
 		compatible = "smsc,usb3503a";
 		reset-gpios = <&gpe1 0 GPIO_ACTIVE_LOW>;
@@ -499,6 +510,20 @@
 		samsung,pin-drv = <0>;
 	};
 
+	mic_det_gpio: mic-det-gpio {
+		samsung,pins = "gpx2-0";
+		samsung,pin-function = <0>;
+		samsung,pin-pud = <0>;
+		samsung,pin-drv = <0>;
+	};
+
+	hp_det_gpio: hp-det-gpio {
+		samsung,pins = "gpx2-2";
+		samsung,pin-function = <0>;
+		samsung,pin-pud = <0>;
+		samsung,pin-drv = <0>;
+	};
+
 	s5m8767_ds: s5m8767-ds {
 		samsung,pins = "gpx2-3", "gpx2-4", "gpx2-5";
 		samsung,pin-function = <0>;
-- 
2.1.4
