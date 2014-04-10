From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Thu, 10 Apr 2014 19:06:08 +0900
Subject: [PATCH 18/27] ARM: dts: exynos3250: Add i2c dt node
In-Reply-To: <1397122658-16013-1-git-send-email-cw00.choi@samsung.com>
References: <1397122658-16013-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <1397124377-16969-10-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Inki Dae <inki.dae@samsung.com>

Add the DTS nodes for all th i2c busses in the Exynos3250 SoC.

Signed-off-by: Inki Dae <inki.dae@samsung.com>
[Add i2c alias by Tomasz Figa]
Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/boot/dts/exynos3250.dtsi | 112 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 112 insertions(+)

diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
index c5e6917..a16c3ea 100644
--- a/arch/arm/boot/dts/exynos3250.dtsi
+++ b/arch/arm/boot/dts/exynos3250.dtsi
@@ -28,6 +28,14 @@
 	aliases {
 		pinctrl0 = &pinctrl_0;
 		pinctrl1 = &pinctrl_1;
+		i2c0 = &i2c_0;
+		i2c1 = &i2c_1;
+		i2c2 = &i2c_2;
+		i2c3 = &i2c_3;
+		i2c4 = &i2c_4;
+		i2c5 = &i2c_5;
+		i2c6 = &i2c_6;
+		i2c7 = &i2c_7;
 	};
 
 	chipid at 10000000 {
@@ -112,4 +120,108 @@
 		clock-names = "uart", "clk_uart_baud0";
 		status = "disabled";
 	};
+
+	i2c_0: i2c at 13860000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "samsung,s3c2440-i2c";
+		reg = <0x13860000 0x100>;
+		interrupts = <0 113 0>;
+		clocks = <&cmu CLK_I2C0>;
+		clock-names = "i2c";
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2c0_bus>;
+		status = "disabled";
+	};
+
+	i2c_1: i2c at 13870000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "samsung,s3c2440-i2c";
+		reg = <0x13870000 0x100>;
+		interrupts = <0 114 0>;
+		clocks = <&cmu CLK_I2C1>;
+		clock-names = "i2c";
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2c1_bus>;
+		status = "disabled";
+	};
+
+	i2c_2: i2c at 13880000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "samsung,s3c2440-i2c";
+		reg = <0x13880000 0x100>;
+		interrupts = <0 115 0>;
+		clocks = <&cmu CLK_I2C2>;
+		clock-names = "i2c";
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2c2_bus>;
+		status = "disabled";
+	};
+
+	i2c_3: i2c at 13890000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "samsung,s3c2440-i2c";
+		reg = <0x13890000 0x100>;
+		interrupts = <0 116 0>;
+		clocks = <&cmu CLK_I2C3>;
+		clock-names = "i2c";
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2c3_bus>;
+		status = "disabled";
+	};
+
+	i2c_4: i2c at 138A0000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "samsung,s3c2440-i2c";
+		reg = <0x138A0000 0x100>;
+		interrupts = <0 117 0>;
+		clocks = <&cmu CLK_I2C4>;
+		clock-names = "i2c";
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2c4_bus>;
+		status = "disabled";
+	};
+
+	i2c_5: i2c at 138B0000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "samsung,s3c2440-i2c";
+		reg = <0x138B0000 0x100>;
+		interrupts = <0 118 0>;
+		clocks = <&cmu CLK_I2C5>;
+		clock-names = "i2c";
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2c5_bus>;
+		status = "disabled";
+	};
+
+	i2c_6: i2c at 138C0000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "samsung,s3c2440-i2c";
+		reg = <0x138C0000 0x100>;
+		interrupts = <0 119 0>;
+		clocks = <&cmu CLK_I2C6>;
+		clock-names = "i2c";
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2c6_bus>;
+		status = "disabled";
+	};
+
+	i2c_7: i2c at 138D0000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "samsung,s3c2440-i2c";
+		reg = <0x138D0000 0x100>;
+		interrupts = <0 120 0>;
+		clocks = <&cmu CLK_I2C7>;
+		clock-names = "i2c";
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2c7_bus>;
+		status = "disabled";
+	};
 };
-- 
1.8.0
