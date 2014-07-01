From: silvio.fricke@gmail.com (Silvio Fricke)
Date: Tue,  1 Jul 2014 13:09:00 +0200
Subject: [PATCH v2 3/5] ARM: dts: imx6: edmqmx6: Add two other i2c buses
In-Reply-To: <cover.1404212584.git.silvio.fricke@gmail.com>
References: <cover.1404212584.git.silvio.fricke@gmail.com>
Message-ID: <b628ce6916edcbf98f22d3ba53d3b77aa5a7a9d6.1404212584.git.silvio.fricke@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Silvio Fricke <silvio.fricke@gmail.com>
---
 arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts b/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts
index f36dab0..dd9ef16 100644
--- a/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts
+++ b/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts
@@ -118,6 +118,13 @@
 	status = "okay";
 };
 
+&i2c1 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c1>;
+	status = "okay";
+};
+
 &i2c2 {
 	clock-frequency = <100000>;
 	pinctrl-names = "default";
@@ -274,6 +281,13 @@
 	};
 };
 
+&i2c3 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c3>;
+	status = "okay";
+};
+
 &iomuxc {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_hog>;
@@ -316,6 +330,13 @@
 			>;
 		};
 
+		pinctrl_i2c1: i2c1grp {
+			fsl,pins = <
+				MX6QDL_PAD_EIM_D21__I2C1_SCL		0x4001b8b1
+				MX6QDL_PAD_EIM_D28__I2C1_SDA		0x4001b8b1
+			>;
+		};
+
 		pinctrl_i2c2: i2c2grp {
 			fsl,pins = <
 				MX6QDL_PAD_EIM_EB2__I2C2_SCL		0x4001b8b1
@@ -323,6 +344,13 @@
 			>;
 		};
 
+		pinctrl_i2c3: i2c3grp {
+			fsl,pins = <
+				MX6QDL_PAD_EIM_D17__I2C3_SCL		0x4001b8b1
+				MX6QDL_PAD_GPIO_6__I2C3_SDA		0x4001b8b1
+			>;
+		};
+
 		pinctrl_pcie: pciegrp {
 			fsl,pins = <
 				MX6QDL_PAD_KEY_COL1__GPIO4_IO08		0x100b1
-- 
2.0.0
