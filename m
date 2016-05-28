From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sat, 28 May 2016 11:54:32 +0200
Subject: [PATCH v5 21/22] ARM: dts: exynos: Add I2C,
 PWM and UART pinctrl to Exynos5410
In-Reply-To: <1464429273-23457-1-git-send-email-krzk@kernel.org>
References: <1464429273-23457-1-git-send-email-krzk@kernel.org>
Message-ID: <1464429273-23457-22-git-send-email-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pincontrol groups for HSI2C (USI), I2C, PWM and UART to Exynos5410.
This allows configuring these pins to specific functions.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
---
 arch/arm/boot/dts/exynos5410-pinctrl.dtsi | 133 ++++++++++++++++++++++++++++++
 1 file changed, 133 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5410-pinctrl.dtsi b/arch/arm/boot/dts/exynos5410-pinctrl.dtsi
index ddacafa1e907..b58a0f29f42c 100644
--- a/arch/arm/boot/dts/exynos5410-pinctrl.dtsi
+++ b/arch/arm/boot/dts/exynos5410-pinctrl.dtsi
@@ -278,6 +278,139 @@
 		#interrupt-cells = <2>;
 	};
 
+	uart0_data: uart0-data {
+		samsung,pins = "gpa0-0", "gpa0-1";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <0>;
+		samsung,pin-drv = <0>;
+	};
+
+	uart0_fctl: uart0-fctl {
+		samsung,pins = "gpa0-2", "gpa0-3";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <0>;
+		samsung,pin-drv = <0>;
+	};
+
+	uart1_data: uart1-data {
+		samsung,pins = "gpa0-4", "gpa0-5";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <0>;
+		samsung,pin-drv = <0>;
+	};
+
+	uart1_fctl: uart1-fctl {
+		samsung,pins = "gpa0-6", "gpa0-7";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <0>;
+		samsung,pin-drv = <0>;
+	};
+
+	i2c2_bus: i2c2-bus {
+		samsung,pins = "gpa0-6", "gpa0-7";
+		samsung,pin-function = <3>;
+		samsung,pin-pud = <3>;
+		samsung,pin-drv = <0>;
+	};
+
+	uart2_data: uart2-data {
+		samsung,pins = "gpa1-0", "gpa1-1";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <0>;
+		samsung,pin-drv = <0>;
+	};
+
+	uart2_fctl: uart2-fctl {
+		samsung,pins = "gpa1-2", "gpa1-3";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <0>;
+		samsung,pin-drv = <0>;
+	};
+
+	i2c3_bus: i2c3-bus {
+		samsung,pins = "gpa1-2", "gpa1-3";
+		samsung,pin-function = <3>;
+		samsung,pin-pud = <3>;
+		samsung,pin-drv = <0>;
+	};
+
+	uart3_data: uart3-data {
+		samsung,pins = "gpa1-4", "gpa1-5";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <0>;
+		samsung,pin-drv = <0>;
+	};
+
+	i2c4_hs_bus: i2c4-hs-bus {
+		samsung,pins = "gpa2-0", "gpa2-1";
+		samsung,pin-function = <3>;
+		samsung,pin-pud = <3>;
+		samsung,pin-drv = <0>;
+	};
+
+	i2c5_hs_bus: i2c5-hs-bus {
+		samsung,pins = "gpa2-2", "gpa2-3";
+		samsung,pin-function = <3>;
+		samsung,pin-pud = <3>;
+		samsung,pin-drv = <0>;
+	};
+
+	i2c6_hs_bus: i2c6-hs-bus {
+		samsung,pins = "gpb1-3", "gpb1-4";
+		samsung,pin-function = <4>;
+		samsung,pin-pud = <3>;
+		samsung,pin-drv = <0>;
+	};
+
+	pwm0_out: pwm0-out {
+		samsung,pins = "gpb2-0";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <0>;
+		samsung,pin-drv = <0>;
+	};
+
+	pwm1_out: pwm1-out {
+		samsung,pins = "gpb2-1";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <0>;
+		samsung,pin-drv = <0>;
+	};
+
+	pwm2_out: pwm2-out {
+		samsung,pins = "gpb2-2";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <0>;
+		samsung,pin-drv = <0>;
+	};
+
+	pwm3_out: pwm3-out {
+		samsung,pins = "gpb2-3";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <0>;
+		samsung,pin-drv = <0>;
+	};
+
+	i2c7_hs_bus: i2c7-hs-bus {
+		samsung,pins = "gpb2-2", "gpb2-3";
+		samsung,pin-function = <3>;
+		samsung,pin-pud = <3>;
+		samsung,pin-drv = <0>;
+	};
+
+	i2c0_bus: i2c0-bus {
+		samsung,pins = "gpb3-0", "gpb3-1";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <3>;
+		samsung,pin-drv = <0>;
+	};
+
+	i2c1_bus: i2c1-bus {
+		samsung,pins = "gpb3-2", "gpb3-3";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <3>;
+		samsung,pin-drv = <0>;
+	};
+
 	sd0_clk: sd0-clk {
 		samsung,pins = "gpc0-0";
 		samsung,pin-function = <2>;
-- 
2.7.4
