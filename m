From: gwenhael.goavec-merou@armadeus.com (Gwenhael Goavec-Merou)
Date: Sat, 16 Mar 2013 16:53:54 +0100
Subject: [PATCH] ARM: imx: apf51dev: add ecspi1, ecspi2 and i2c2 support
Message-ID: <1363449234-4038-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Gwenhael Goavec-Merou <gwenhael.goavec-merou@armadeus.com>
---
 arch/arm/boot/dts/imx51-apf51dev.dtsp | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/imx51-apf51dev.dtsp b/arch/arm/boot/dts/imx51-apf51dev.dtsp
index cf02bff..8eb2995 100644
--- a/arch/arm/boot/dts/imx51-apf51dev.dtsp
+++ b/arch/arm/boot/dts/imx51-apf51dev.dtsp
@@ -37,6 +37,22 @@
 	};
 };
 
+&ecspi1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ecspi1_1>;
+	fsl,spi-num-chipselects = <2>;
+	cs-gpios = <&gpio4 24 0>, <&gpio4 25 0>;
+	status = "okay";
+};
+
+&ecspi2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ecspi2_1>;
+	fsl,spi-num-chipselects = <2>;
+	cs-gpios = <&gpio3 28 1>, <&gpio3 27 1>;
+	status = "okay";
+};
+
 &esdhc1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_esdhc1_1>;
@@ -53,6 +69,12 @@
 	status = "okay";
 };
 
+&i2c2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2_2>;
+	status = "okay";
+};
+
 &iomuxc {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_hog>;
-- 
1.8.1.5
