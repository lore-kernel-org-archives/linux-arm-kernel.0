From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 10 May 2016 22:09:28 +0200
Subject: [PATCH v3 25/27] ARM: dts: exynos: Move HSI2C nodes to exynos54xx.dtsi
In-Reply-To: <1462910970-1812-1-git-send-email-krzk@kernel.org>
References: <1462910970-1812-1-git-send-email-krzk@kernel.org>
Message-ID: <1462910970-1812-26-git-send-email-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The USI/HSI2C nodes can be mostly shared between Exynos5420 and
Exynos5410 so move them to common DTSI.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos5420.dtsi | 32 ++++++++++++++++++++++++++----
 arch/arm/boot/dts/exynos54xx.dtsi | 41 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 8fa65eb8027d..791243694aa5 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -29,10 +29,6 @@
 		pinctrl2 = &pinctrl_2;
 		pinctrl3 = &pinctrl_3;
 		pinctrl4 = &pinctrl_4;
-		i2c4 = &hsi2c_4;
-		i2c5 = &hsi2c_5;
-		i2c6 = &hsi2c_6;
-		i2c7 = &hsi2c_7;
 		i2c8 = &hsi2c_8;
 		i2c9 = &hsi2c_9;
 		i2c10 = &hsi2c_10;
@@ -1022,6 +1018,34 @@
 	pinctrl-0 = <&i2c3_bus>;
 };
 
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
diff --git a/arch/arm/boot/dts/exynos54xx.dtsi b/arch/arm/boot/dts/exynos54xx.dtsi
index a9a062708237..317612089b50 100644
--- a/arch/arm/boot/dts/exynos54xx.dtsi
+++ b/arch/arm/boot/dts/exynos54xx.dtsi
@@ -21,6 +21,10 @@
 	compatible = "samsung,exynos5";
 
 	aliases {
+		i2c4 = &hsi2c_4;
+		i2c5 = &hsi2c_5;
+		i2c6 = &hsi2c_6;
+		i2c7 = &hsi2c_7;
 		usbdrdphy0 = &usbdrd_phy0;
 		usbdrdphy1 = &usbdrd_phy1;
 	};
@@ -70,6 +74,43 @@
 			};
 		};
 
+		/* i2c_0-3 are defined in exynos5.dtsi */
+		hsi2c_4: i2c at 12CA0000 {
+			compatible = "samsung,exynos5250-hsi2c";
+			reg = <0x12CA0000 0x1000>;
+			interrupts = <0 60 0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		hsi2c_5: i2c at 12CB0000 {
+			compatible = "samsung,exynos5250-hsi2c";
+			reg = <0x12CB0000 0x1000>;
+			interrupts = <0 61 0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		hsi2c_6: i2c at 12CC0000 {
+			compatible = "samsung,exynos5250-hsi2c";
+			reg = <0x12CC0000 0x1000>;
+			interrupts = <0 62 0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		hsi2c_7: i2c at 12CD0000 {
+			compatible = "samsung,exynos5250-hsi2c";
+			reg = <0x12CD0000 0x1000>;
+			interrupts = <0 63 0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		usbdrd3_0: usb3-0 {
 			compatible = "samsung,exynos5250-dwusb3";
 			#address-cells = <1>;
-- 
2.5.0
