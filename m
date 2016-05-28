From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sat, 28 May 2016 11:54:33 +0200
Subject: [PATCH v5 22/22] ARM: dts: exynos: Add RTC and I2C to Exynos5410
In-Reply-To: <1464429273-23457-1-git-send-email-krzk@kernel.org>
References: <1464429273-23457-1-git-send-email-krzk@kernel.org>
Message-ID: <1464429273-23457-23-git-send-email-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Configure Exynos5410-specific properties of RTC, I2C and HSI2C nodes.
This still does not enable them on the board level though.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
---
 arch/arm/boot/dts/exynos5410.dtsi | 63 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5410.dtsi b/arch/arm/boot/dts/exynos5410.dtsi
index 6146bf164248..a937d9bdad90 100644
--- a/arch/arm/boot/dts/exynos5410.dtsi
+++ b/arch/arm/boot/dts/exynos5410.dtsi
@@ -149,6 +149,62 @@
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
 	clocks = <&fin_pll>, <&clock CLK_MCT>;
 	clock-names = "fin_pll", "mct";
@@ -159,6 +215,13 @@
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
2.7.4
