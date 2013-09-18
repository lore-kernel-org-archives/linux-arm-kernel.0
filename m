From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 18 Sep 2013 13:14:08 +0100
Subject: [PATCH 11/41] ARM: ux500: Supply the I2C clocks lookup to the DBX500
 DT
In-Reply-To: <1379506478-16625-1-git-send-email-lee.jones@linaro.org>
References: <1379506478-16625-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1379506478-16625-12-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/dbx5x0.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/dbx5x0.dtsi b/arch/arm/boot/dts/dbx5x0.dtsi
index 5e91063..0742e55 100644
--- a/arch/arm/boot/dts/dbx5x0.dtsi
+++ b/arch/arm/boot/dts/dbx5x0.dtsi
@@ -577,6 +577,8 @@
 			v-i2c-supply = <&db8500_vape_reg>;
 
 			clock-frequency = <400000>;
+			clocks = <&prcc_kclk 3 3>, <&prcc_pclk 3 3>;
+			clock-names = "i2cclk", "apb_pclk";
 		};
 
 		i2c at 80122000 {
@@ -590,6 +592,9 @@
 			v-i2c-supply = <&db8500_vape_reg>;
 
 			clock-frequency = <400000>;
+
+			clocks = <&prcc_kclk 1 2>, <&prcc_pclk 1 2>;
+			clock-names = "i2cclk", "apb_pclk";
 		};
 
 		i2c at 80128000 {
@@ -603,6 +608,9 @@
 			v-i2c-supply = <&db8500_vape_reg>;
 
 			clock-frequency = <400000>;
+
+			clocks = <&prcc_kclk 1 6>, <&prcc_pclk 1 6>;
+			clock-names = "i2cclk", "apb_pclk";
 		};
 
 		i2c at 80110000 {
@@ -616,6 +624,9 @@
 			v-i2c-supply = <&db8500_vape_reg>;
 
 			clock-frequency = <400000>;
+
+			clocks = <&prcc_kclk 2 0>, <&prcc_pclk 2 0>;
+			clock-names = "i2cclk", "apb_pclk";
 		};
 
 		i2c at 8012a000 {
@@ -629,6 +640,9 @@
 			v-i2c-supply = <&db8500_vape_reg>;
 
 			clock-frequency = <400000>;
+
+			clocks = <&prcc_kclk 1 9>, <&prcc_pclk 1 9>;
+			clock-names = "i2cclk", "apb_pclk";
 		};
 
 		ssp at 80002000 {
-- 
1.8.1.2
