From: jagan@openedev.com (Jagan Teki)
Date: Thu,  6 Apr 2017 23:32:14 +0530
Subject: [PATCH v3 8/9] ARM: dts: imx6qdl-icore-rqs: Add CAN nodes
In-Reply-To: <1491501735-1649-1-git-send-email-jagan@openedev.com>
References: <1491501735-1649-1-git-send-email-jagan@openedev.com>
Message-ID: <1491501735-1649-9-git-send-email-jagan@openedev.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jagan Teki <jagan@amarulasolutions.com>

Add support for can1 and can2 nodes on Engicam i.CoreM6 RQS
QDL module boards.

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Matteo Lisi <matteo.lisi@engicam.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v3:
- none
Changes for v2:
- s/flexcan/can
- s/pinctrl_flexcan/pinctrl_can

 arch/arm/boot/dts/imx6dl-icore-rqs.dts   |  8 ++++++++
 arch/arm/boot/dts/imx6q-icore-rqs.dts    |  8 ++++++++
 arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi | 26 ++++++++++++++++++++++++++
 3 files changed, 42 insertions(+)

diff --git a/arch/arm/boot/dts/imx6dl-icore-rqs.dts b/arch/arm/boot/dts/imx6dl-icore-rqs.dts
index 053e7cb..74335c4 100644
--- a/arch/arm/boot/dts/imx6dl-icore-rqs.dts
+++ b/arch/arm/boot/dts/imx6dl-icore-rqs.dts
@@ -60,3 +60,11 @@
 		VDDD-supply = <&reg_1p8v>;
 	};
 };
+
+&can1 {
+	status = "okay";
+};
+
+&can2 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/imx6q-icore-rqs.dts b/arch/arm/boot/dts/imx6q-icore-rqs.dts
index d45e4f5..2d4539a 100644
--- a/arch/arm/boot/dts/imx6q-icore-rqs.dts
+++ b/arch/arm/boot/dts/imx6q-icore-rqs.dts
@@ -49,6 +49,14 @@
 	compatible = "engicam,imx6-icore-rqs", "fsl,imx6q";
 };
 
+&can1 {
+	status = "okay";
+};
+
+&can2 {
+	status = "okay";
+};
+
 &i2c3 {
 	sgtl5000: codec at a {
 		compatible = "fsl,sgtl5000";
diff --git a/arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi b/arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi
index 0e79a5b..998fa77 100644
--- a/arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi
@@ -145,6 +145,18 @@
 	};
 };
 
+&can1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_can1>;
+	xceiver-supply = <&reg_3p3v>;
+};
+
+&can2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_can2>;
+	xceiver-supply = <&reg_3p3v>;
+};
+
 &clks {
 	assigned-clocks = <&clks IMX6QDL_CLK_LVDS2_SEL>;
 	assigned-clock-parents = <&clks IMX6QDL_CLK_OSC>;
@@ -296,6 +308,20 @@
 		>;
 	};
 
+	pinctrl_can1: can1grp {
+		fsl,pins = <
+			MX6QDL_PAD_KEY_ROW2__FLEXCAN1_RX 0x1b020
+			MX6QDL_PAD_KEY_COL2__FLEXCAN1_TX 0x1b020
+		>;
+	};
+
+	pinctrl_can2: can2grp {
+		fsl,pins = <
+			MX6QDL_PAD_KEY_COL4__FLEXCAN2_TX 0x1b020
+			MX6QDL_PAD_KEY_ROW4__FLEXCAN2_RX 0x1b020
+		>;
+	};
+
 	pinctrl_i2c1: i2c1grp {
 		fsl,pins = <
 			MX6QDL_PAD_EIM_D21__I2C1_SCL 0x4001b8b1
-- 
1.9.1
