From: linux.amoon@gmail.com (Anand Moon)
Date: Wed, 13 May 2015 16:06:56 +0930
Subject: [PATCHv5 1/5] ARM: dts: exynos5422-odroidxu3 Add pwm-fan node to the
 Odroid-XU3 board
In-Reply-To: <1431499020-3912-1-git-send-email-linux.amoon@gmail.com>
References: <1431499020-3912-1-git-send-email-linux.amoon@gmail.com>
Message-ID: <1431499020-3912-2-git-send-email-linux.amoon@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pwm-fan node to the Odroid-XU3 board.

Tested-by: Markus Reichl <m.reichl@fivetechno.de>
Acked-by: Lukasz Majewski <l.majewski@samsung.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 arch/arm/boot/dts/exynos5422-odroidxu3.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3.dts b/arch/arm/boot/dts/exynos5422-odroidxu3.dts
index f0ce60b..9446e28 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu3.dts
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3.dts
@@ -310,6 +310,15 @@
 			linux,default-trigger = "mmc1";
 		};
 	};
+
+	fan0: pwm-fan {
+		compatible = "pwm-fan";
+		pwms = <&pwm 0 20972 0>;
+		cooling-min-state = <0>;
+		cooling-max-state = <3>;
+		#cooling-cells = <2>;
+		cooling-levels = <0 130 170 230>;
+	};
 };
 
 &hdmi {
@@ -415,3 +424,10 @@
 		shunt-resistor = <10000>;
 	};
 };
+
+&pwm {
+	pinctrl-0 = <&pwm0_out>;
+	pinctrl-names = "default";
+	samsung,pwm-outputs = <0>;
+	status = "okay";
+};
-- 
1.9.1
