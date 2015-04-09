From: linux.amoon@gmail.com (Anand Moon)
Date: Fri, 10 Apr 2015 01:14:15 +0930
Subject: [PATCH v2 1/5] ARM: dts :exynos5422-odroidxu3 Add pwm-fan node to the
 Odroid-XU3 board.
In-Reply-To: <1428594259-3915-1-git-send-email-linux.amoon@gmail.com>
References: <1428594259-3915-1-git-send-email-linux.amoon@gmail.com>
Message-ID: <1428594259-3915-2-git-send-email-linux.amoon@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pwm-fan node to the OdroidXU3 board.

Tested on OdroidXU3 board.

Changes since v1 : None

Tested-by: Markus Reichl <m.reichl@fivetechno.de>
Acked-by: Lukasz Majewski <l.majewski@samsung.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 arch/arm/boot/dts/exynos5422-odroidxu3.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3.dts b/arch/arm/boot/dts/exynos5422-odroidxu3.dts
index a519c86..04d982b 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu3.dts
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3.dts
@@ -278,6 +278,15 @@
 	rtc at 101E0000 {
 		status = "okay";
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
@@ -369,3 +378,10 @@
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
