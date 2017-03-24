From: jagan@openedev.com (Jagan Teki)
Date: Fri, 24 Mar 2017 21:48:39 +0530
Subject: [PATCH v2 04/15] ARM: dts: imx6ul-isiot: Add i2c nodes
In-Reply-To: <1490372330-5611-1-git-send-email-jagan@openedev.com>
References: <1490372330-5611-1-git-send-email-jagan@openedev.com>
Message-ID: <1490372330-5611-5-git-send-email-jagan@openedev.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jagan Teki <jagan@amarulasolutions.com>

Add support for i2c nodes i2c1 and i2c2 on Is.IoT MX6UL
eMMC variant boards.

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Matteo Lisi <matteo.lisi@engicam.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v2:
- none

 arch/arm/boot/dts/imx6ul-isiot.dtsi | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ul-isiot.dtsi b/arch/arm/boot/dts/imx6ul-isiot.dtsi
index 5ccc3df..4697a04 100644
--- a/arch/arm/boot/dts/imx6ul-isiot.dtsi
+++ b/arch/arm/boot/dts/imx6ul-isiot.dtsi
@@ -71,6 +71,20 @@
 	};
 };
 
+&i2c1 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c1>;
+	status = "okay";
+};
+
+&i2c2 {
+	clock_frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2>;
+	status = "okay";
+};
+
 &pwm8 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm8>;
@@ -95,6 +109,20 @@
 };
 
 &iomuxc {
+	pinctrl_i2c1: i2c1grp {
+		fsl,pins = <
+			MX6UL_PAD_UART4_TX_DATA__I2C1_SCL 0x4001b8b0
+			MX6UL_PAD_UART4_RX_DATA__I2C1_SDA 0x4001b8b0
+		>;
+	};
+
+	pinctrl_i2c2: i2c2grp {
+		fsl,pins = <
+			MX6UL_PAD_GPIO1_IO00__I2C2_SCL 0x4001b8b0
+			MX6UL_PAD_GPIO1_IO01__I2C2_SDA 0x4001b8b0
+		>;
+	};
+
 	pinctrl_pwm8: pwm8grp {
 		fsl,pins = <
 			MX6UL_PAD_ENET1_RX_ER__PWM8_OUT   0x110b0
-- 
1.9.1
