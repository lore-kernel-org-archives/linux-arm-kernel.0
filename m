From: linux.amoon@gmail.com (Anand Moon)
Date: Mon, 15 Jun 2015 12:23:20 +0930
Subject: [PATCHv7 1/4] ARM: dts: exynos5422-odroidxu3: Add pwm-fan node
Message-ID: <1434336803-4132-1-git-send-email-linux.amoon@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pwm-fan node to the Odroid-XU3 board.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
Tested-by: Markus Reichl <m.reichl@fivetechno.de>
Acked-by: Lukasz Majewski <l.majewski@samsung.com>
Acked-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
index 8adf455..17e6a9a 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
@@ -107,6 +107,15 @@
 			clocks = <&i2s0 CLK_I2S_CDCLK>;
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
 
 &clock_audss {
@@ -461,6 +470,7 @@
 	 */
 	pinctrl-0 = <&pwm0_out &pwm1_out &pwm2_out &pwm3_out>;
 	pinctrl-names = "default";
+	samsung,pwm-outputs = <0>;
 	status = "okay";
 };
 
-- 
2.4.3
