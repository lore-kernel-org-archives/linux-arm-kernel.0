From: linux.amoon@gmail.com (Anand Moon)
Date: Fri, 27 Mar 2015 03:09:10 +1030
Subject: [PATCH 1/6] ARM: dts :exynos5422-odroidxu3 Add pwm-fan node to the
 Odroid-XU3 board.
In-Reply-To: <1427387955-5129-1-git-send-email-linux.amoon@gmail.com>
References: <1427387955-5129-1-git-send-email-linux.amoon@gmail.com>
Message-ID: <1427387955-5129-2-git-send-email-linux.amoon@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pwm-fan node to the OdroidXU3 board.

Tested on OdroidXU3 board.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 arch/arm/boot/dts/exynos5422-odroidxu3.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3.dts b/arch/arm/boot/dts/exynos5422-odroidxu3.dts
index a519c86..eaec006 100644
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
+		cooling-levels = <0 90 130 170 230>;
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
