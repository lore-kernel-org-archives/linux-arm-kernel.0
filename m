From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 14 Apr 2014 17:37:28 +0200
Subject: [PATCH 06/10] ARM: dts: pbab01: Add I2C2 and I2C3
In-Reply-To: <1397489852-1669-1-git-send-email-p.zabel@pengutronix.de>
References: <1397489852-1669-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1397489852-1669-6-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 arch/arm/boot/dts/imx6qdl-phytec-pbab01.dtsi | 30 ++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-phytec-pbab01.dtsi b/arch/arm/boot/dts/imx6qdl-phytec-pbab01.dtsi
index 4e36aef..a449a580 100644
--- a/arch/arm/boot/dts/imx6qdl-phytec-pbab01.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-phytec-pbab01.dtsi
@@ -23,6 +23,20 @@
 	status = "okay";
 };
 
+&i2c2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2>;
+	clock-frequency = <100000>;
+	status = "okay";
+};
+
+&i2c3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c3>;
+	clock-frequency = <100000>;
+	status = "okay";
+};
+
 &uart4 {
 	status = "okay";
 };
@@ -42,3 +56,19 @@
 &usdhc3 {
 	status = "okay";
 };
+
+&iomuxc {
+	pinctrl_i2c2: i2c2grp {
+		fsl,pins = <
+			MX6QDL_PAD_EIM_EB2__I2C2_SCL		0x4001b8b1
+			MX6QDL_PAD_EIM_D16__I2C2_SDA		0x4001b8b1
+		>;
+	};
+
+	pinctrl_i2c3: i2c3grp {
+		fsl,pins = <
+			MX6QDL_PAD_EIM_D17__I2C3_SCL		0x4001b8b1
+			MX6QDL_PAD_EIM_D18__I2C3_SDA		0x4001b8b1
+		>;
+	};
+};
-- 
1.9.1
