From: lee.jones@linaro.org (Lee Jones)
Date: Thu,  6 Jun 2013 13:16:57 +0100
Subject: [PATCH 09/33] ARM: ux500: Supply the I2C clocks lookup to the DBX500
 DT
In-Reply-To: <1370521041-32318-1-git-send-email-lee.jones@linaro.org>
References: <1370521041-32318-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1370521041-32318-10-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/dbx5x0.dtsi |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/dbx5x0.dtsi b/arch/arm/boot/dts/dbx5x0.dtsi
index d682ea0..e49c679 100644
--- a/arch/arm/boot/dts/dbx5x0.dtsi
+++ b/arch/arm/boot/dts/dbx5x0.dtsi
@@ -572,6 +572,8 @@
 			v-i2c-supply = <&db8500_vape_reg>;
 
 			clock-frequency = <400000>;
+			clocks = <&prcc_kclk 3 3>, <&prcc_pclk 3 3>;
+			clock-names = "nmk-i2c.0", "apb_pclk";
 		};
 
 		i2c at 80122000 {
@@ -585,6 +587,9 @@
 			v-i2c-supply = <&db8500_vape_reg>;
 
 			clock-frequency = <400000>;
+
+			clocks = <&prcc_kclk 1 2>, <&prcc_pclk 1 2>;
+			clock-names = "nmk-i2c.1", "apb_pclk";
 		};
 
 		i2c at 80128000 {
@@ -598,6 +603,9 @@
 			v-i2c-supply = <&db8500_vape_reg>;
 
 			clock-frequency = <400000>;
+
+			clocks = <&prcc_kclk 1 6>, <&prcc_pclk 1 6>;
+			clock-names = "nmk-i2c.2", "apb_pclk";
 		};
 
 		i2c at 80110000 {
@@ -611,6 +619,9 @@
 			v-i2c-supply = <&db8500_vape_reg>;
 
 			clock-frequency = <400000>;
+
+			clocks = <&prcc_kclk 2 0>, <&prcc_pclk 2 0>;
+			clock-names = "nmk-i2c.3", "apb_pclk";
 		};
 
 		i2c at 8012a000 {
@@ -624,6 +635,9 @@
 			v-i2c-supply = <&db8500_vape_reg>;
 
 			clock-frequency = <400000>;
+
+			clocks = <&prcc_kclk 1 9>, <&prcc_pclk 1 9>;
+			clock-names = "nmk-i2c.4", "apb_pclk";
 		};
 
 		ssp at 80002000 {
-- 
1.7.10.4
