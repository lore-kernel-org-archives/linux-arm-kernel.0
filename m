From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 10 May 2016 22:09:30 +0200
Subject: [PATCH v3 27/27] ARM: dts: exynos: Add RTC and I2C to Exynos5410
In-Reply-To: <1462910970-1812-1-git-send-email-krzk@kernel.org>
References: <1462910970-1812-1-git-send-email-krzk@kernel.org>
Message-ID: <1462910970-1812-28-git-send-email-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Configure Exynos5410-specific properties of RTC, I2C and HSI2C nodes.
This still does not enable them on the board level though.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos5410.dtsi | 66 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5410.dtsi b/arch/arm/boot/dts/exynos5410.dtsi
index dd4d6d752865..ae64cb0a8efd 100644
--- a/arch/arm/boot/dts/exynos5410.dtsi
+++ b/arch/arm/boot/dts/exynos5410.dtsi
@@ -114,6 +114,9 @@
 			status = "disabled";
 		};
 
+		/* i2c_0-3 are defined in exynos5.dtsi */
+		/* hsi2c_4-7 are defined in exynos5xx.dtsi */
+
 		pinctrl_0: pinctrl at 13400000 {
 			compatible = "samsung,exynos5410-pinctrl";
 			reg = <0x13400000 0x1000>;
@@ -146,6 +149,62 @@
 	};
 };
 
+&i2c_0 {
+	clocks = <&clock CLK_I2C0>;
+	clock-names = "i2c";
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0_bus>;
+};
+
+&i2c_1 {
+	clocks = <&clock CLK_I2C1>;
+	clock-names = "i2c";
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_bus>;
+};
+
+&i2c_2 {
+	clocks = <&clock CLK_I2C2>;
+	clock-names = "i2c";
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c2_bus>;
+};
+
+&i2c_3 {
+	clocks = <&clock CLK_I2C3>;
+	clock-names = "i2c";
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c3_bus>;
+};
+
+&hsi2c_4 {
+	clocks = <&clock CLK_USI0>;
+	clock-names = "hsi2c";
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c4_hs_bus>;
+};
+
+&hsi2c_5 {
+	clocks = <&clock CLK_USI1>;
+	clock-names = "hsi2c";
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c5_hs_bus>;
+};
+
+&hsi2c_6 {
+	clocks = <&clock CLK_USI2>;
+	clock-names = "hsi2c";
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c6_hs_bus>;
+};
+
+&hsi2c_7 {
+	clocks = <&clock CLK_USI3>;
+	clock-names = "hsi2c";
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c7_hs_bus>;
+};
+
 &mct {
 	clocks = <&clock CLK_FIN_PLL>, <&clock CLK_MCT>;
 	clock-names = "fin_pll", "mct";
@@ -156,6 +215,13 @@
 	clock-names = "timers";
 };
 
+&rtc {
+	clocks = <&clock CLK_RTC>;
+	clock-names = "rtc";
+	interrupt-parent = <&pmu_system_controller>;
+	status = "disabled";
+};
+
 &serial_0 {
 	clocks = <&clock CLK_UART0>, <&clock CLK_SCLK_UART0>;
 	clock-names = "uart", "clk_uart_baud0";
-- 
2.5.0
