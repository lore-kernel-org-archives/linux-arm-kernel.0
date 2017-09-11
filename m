From: jagannadh.teki@gmail.com (Jagan Teki)
Date: Mon, 11 Sep 2017 14:42:25 +0530
Subject: [PATCH v4 6/6] ARM: dts: imx6qdl-icore-rqs: Add CAN nodes
In-Reply-To: <1505121145-9507-1-git-send-email-jteki@openedev.com>
References: <1505121145-9507-1-git-send-email-jteki@openedev.com>
Message-ID: <1505121145-9507-6-git-send-email-jteki@openedev.com>
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
Changes for v4:
- Moved can nodes from dts to dtsi 
Changes for v3:
- none
Changes for v2:
- s/flexcan/can

 arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi b/arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi
index 6bb722a..9969e7f3 100644
--- a/arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi
@@ -145,6 +145,20 @@
 	};
 };
 
+&can1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_can1>;
+	xceiver-supply = <&reg_3p3v>;
+	status = "okay";
+};
+
+&can2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_can2>;
+	xceiver-supply = <&reg_3p3v>;
+	status = "okay";
+};
+
 &clks {
 	assigned-clocks = <&clks IMX6QDL_CLK_LVDS2_SEL>;
 	assigned-clock-parents = <&clks IMX6QDL_CLK_OSC>;
@@ -304,6 +318,20 @@
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
2.7.4
