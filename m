From: rahul.sharma@samsung.com (Rahul Sharma)
Date: Thu, 29 Aug 2013 10:58:27 +0530
Subject: [PATCH 3/6] ARM: dts: add i2c device nodes for Exynos5420
In-Reply-To: <1377754110-31084-1-git-send-email-rahul.sharma@samsung.com>
References: <1377754110-31084-1-git-send-email-rahul.sharma@samsung.com>
Message-ID: <1377754110-31084-3-git-send-email-rahul.sharma@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrew Bresticker <abrestic@chromium.org>

This adds device-tree nodes for the i2c busses on Exynos
5420 platforms.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
Signed-off-by: Rahul Sharma <rahul.sharma@samsung.com>
---
 arch/arm/boot/dts/exynos5420.dtsi |   56 +++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 5353e32..05dee86 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -27,6 +27,10 @@
 		pinctrl2 = &pinctrl_2;
 		pinctrl3 = &pinctrl_3;
 		pinctrl4 = &pinctrl_4;
+		i2c0 = &i2c_0;
+		i2c1 = &i2c_1;
+		i2c2 = &i2c_2;
+		i2c3 = &i2c_3;
 	};
 
 	cpus {
@@ -218,4 +222,56 @@
 		clocks = <&clock 147>, <&clock 421>;
 		clock-names = "sclk_fimd", "fimd";
 	};
+
+	i2c_0: i2c at 12C60000 {
+		compatible = "samsung,s3c2440-i2c";
+		reg = <0x12C60000 0x100>;
+		interrupts = <0 56 0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&clock 261>;
+		clock-names = "i2c";
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2c0_bus>;
+		status = "disabled";
+	};
+
+	i2c_1: i2c at 12C70000 {
+		compatible = "samsung,s3c2440-i2c";
+		reg = <0x12C70000 0x100>;
+		interrupts = <0 57 0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&clock 262>;
+		clock-names = "i2c";
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2c1_bus>;
+		status = "disabled";
+	};
+
+       i2c_2: i2c at 12C80000 {
+		compatible = "samsung,s3c2440-i2c";
+		reg = <0x12C80000 0x100>;
+		interrupts = <0 58 0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&clock 263>;
+		clock-names = "i2c";
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2c2_bus>;
+		status = "disabled";
+       };
+
+	i2c_3: i2c at 12C90000 {
+		compatible = "samsung,s3c2440-i2c";
+		reg = <0x12C90000 0x100>;
+		interrupts = <0 59 0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&clock 264>;
+		clock-names = "i2c";
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2c3_bus>;
+		status = "disabled";
+	};
 };
-- 
1.7.10.4
