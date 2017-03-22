From: jagan@openedev.com (Jagan Teki)
Date: Wed, 22 Mar 2017 23:18:17 +0530
Subject: [PATCH 12/12] ARM: dts: imx6qdl-icore-rqs: Add CAN nodes
In-Reply-To: <1490204897-14525-1-git-send-email-jagan@openedev.com>
References: <1490204897-14525-1-git-send-email-jagan@openedev.com>
Message-ID: <1490204897-14525-13-git-send-email-jagan@openedev.com>
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
 arch/arm/boot/dts/imx6dl-icore-rqs.dts   |  8 ++++++++
 arch/arm/boot/dts/imx6q-icore-rqs.dts    |  8 ++++++++
 arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi | 26 ++++++++++++++++++++++++++
 3 files changed, 42 insertions(+)

diff --git a/arch/arm/boot/dts/imx6dl-icore-rqs.dts b/arch/arm/boot/dts/imx6dl-icore-rqs.dts
index cf42c2f..f28577b 100644
--- a/arch/arm/boot/dts/imx6dl-icore-rqs.dts
+++ b/arch/arm/boot/dts/imx6dl-icore-rqs.dts
@@ -49,3 +49,11 @@
 	model = "Engicam i.CoreM6 DualLite/Solo RQS Starter Kit";
 	compatible = "engicam,imx6-icore-rqs", "fsl,imx6dl";
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
index e451b4c..21832f0 100644
--- a/arch/arm/boot/dts/imx6q-icore-rqs.dts
+++ b/arch/arm/boot/dts/imx6q-icore-rqs.dts
@@ -62,6 +62,14 @@
 	};
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
 	codec: sgtl5000 at 0a {
 		compatible = "fsl,sgtl5000";
diff --git a/arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi b/arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi
index 5fab5be..4ccb08d 100644
--- a/arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi
@@ -120,6 +120,18 @@
 	};
 };
 
+&can1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan1>;
+	xceiver-supply = <&reg_3p3v>;
+};
+
+&can2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan2>;
+	xceiver-supply = <&reg_3p3v>;
+};
+
 &clks {
 	assigned-clocks = <&clks IMX6QDL_CLK_LVDS2_SEL>;
 	assigned-clock-parents = <&clks IMX6QDL_CLK_OSC>;
@@ -271,6 +283,20 @@
 		>;
 	};
 
+	pinctrl_flexcan1: flexcan1grp {
+		fsl,pins = <
+			MX6QDL_PAD_KEY_ROW2__FLEXCAN1_RX 0x1b020
+			MX6QDL_PAD_KEY_COL2__FLEXCAN1_TX 0x1b020
+		>;
+	};
+
+	pinctrl_flexcan2: flexcan2grp {
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
