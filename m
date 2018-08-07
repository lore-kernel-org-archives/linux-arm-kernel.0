From: jagan@amarulasolutions.com (Jagan Teki)
Date: Tue,  7 Aug 2018 12:38:37 +0530
Subject: [PATCH 2/3] ARM: dts: imx6ul-isiot: Move node definitions into dtsi
In-Reply-To: <20180807070838.24685-1-jagan@amarulasolutions.com>
References: <20180807070838.24685-1-jagan@amarulasolutions.com>
Message-ID: <20180807070838.24685-2-jagan@amarulasolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move usdhc2 and gpmi along with pinctrl nodes on
imx6ul-isiot.dtsi from dts files and mark it as 'disabled'
and the relevant dts will enable the status as 'okay'

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 arch/arm/boot/dts/imx6ul-isiot-emmc.dts | 23 -----------
 arch/arm/boot/dts/imx6ul-isiot-nand.dts | 25 ------------
 arch/arm/boot/dts/imx6ul-isiot.dtsi     | 52 +++++++++++++++++++++++++
 3 files changed, 52 insertions(+), 48 deletions(-)

diff --git a/arch/arm/boot/dts/imx6ul-isiot-emmc.dts b/arch/arm/boot/dts/imx6ul-isiot-emmc.dts
index 464bd21930fd..1df3e376ae2c 100644
--- a/arch/arm/boot/dts/imx6ul-isiot-emmc.dts
+++ b/arch/arm/boot/dts/imx6ul-isiot-emmc.dts
@@ -14,28 +14,5 @@
 };
 
 &usdhc2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_usdhc2>;
-	cd-gpios = <&gpio4 5 GPIO_ACTIVE_LOW>;
-	bus-width = <8>;
-	no-1-8-v;
 	status = "okay";
 };
-
-&iomuxc {
-	pinctrl_usdhc2: usdhc2grp {
-		fsl,pins = <
-			MX6UL_PAD_NAND_RE_B__USDHC2_CLK      0x17070
-			MX6UL_PAD_NAND_WE_B__USDHC2_CMD      0x10070
-			MX6UL_PAD_NAND_DATA00__USDHC2_DATA0  0x17070
-			MX6UL_PAD_NAND_DATA01__USDHC2_DATA1  0x17070
-			MX6UL_PAD_NAND_DATA02__USDHC2_DATA2  0x17070
-			MX6UL_PAD_NAND_DATA03__USDHC2_DATA3  0x17070
-			MX6UL_PAD_NAND_DATA04__USDHC2_DATA4  0x17070
-			MX6UL_PAD_NAND_DATA05__USDHC2_DATA5  0x17070
-			MX6UL_PAD_NAND_DATA06__USDHC2_DATA6  0x17070
-			MX6UL_PAD_NAND_DATA07__USDHC2_DATA7  0x17070
-			MX6UL_PAD_NAND_ALE__USDHC2_RESET_B   0x17070
-		>;
-	};
-};
diff --git a/arch/arm/boot/dts/imx6ul-isiot-nand.dts b/arch/arm/boot/dts/imx6ul-isiot-nand.dts
index 84420ed47106..8c26d4d1a7bf 100644
--- a/arch/arm/boot/dts/imx6ul-isiot-nand.dts
+++ b/arch/arm/boot/dts/imx6ul-isiot-nand.dts
@@ -14,30 +14,5 @@
 };
 
 &gpmi {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_gpmi_nand>;
-	nand-on-flash-bbt;
 	status = "okay";
 };
-
-&iomuxc {
-	pinctrl_gpmi_nand: gpmi-nand {
-		fsl,pins = <
-			MX6UL_PAD_NAND_CLE__RAWNAND_CLE         0xb0b1
-			MX6UL_PAD_NAND_ALE__RAWNAND_ALE         0xb0b1
-			MX6UL_PAD_NAND_WP_B__RAWNAND_WP_B       0xb0b1
-			MX6UL_PAD_NAND_READY_B__RAWNAND_READY_B 0xb000
-			MX6UL_PAD_NAND_CE0_B__RAWNAND_CE0_B     0xb0b1
-			MX6UL_PAD_NAND_RE_B__RAWNAND_RE_B       0xb0b1
-			MX6UL_PAD_NAND_WE_B__RAWNAND_WE_B       0xb0b1
-			MX6UL_PAD_NAND_DATA00__RAWNAND_DATA00   0xb0b1
-			MX6UL_PAD_NAND_DATA01__RAWNAND_DATA01   0xb0b1
-			MX6UL_PAD_NAND_DATA02__RAWNAND_DATA02   0xb0b1
-			MX6UL_PAD_NAND_DATA03__RAWNAND_DATA03   0xb0b1
-			MX6UL_PAD_NAND_DATA04__RAWNAND_DATA04   0xb0b1
-			MX6UL_PAD_NAND_DATA05__RAWNAND_DATA05   0xb0b1
-			MX6UL_PAD_NAND_DATA06__RAWNAND_DATA06   0xb0b1
-			MX6UL_PAD_NAND_DATA07__RAWNAND_DATA07   0xb0b1
-		>;
-	};
-};
diff --git a/arch/arm/boot/dts/imx6ul-isiot.dtsi b/arch/arm/boot/dts/imx6ul-isiot.dtsi
index ba66225fe86e..fe435484e69d 100644
--- a/arch/arm/boot/dts/imx6ul-isiot.dtsi
+++ b/arch/arm/boot/dts/imx6ul-isiot.dtsi
@@ -97,6 +97,13 @@
 	};
 };
 
+&gpmi {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpmi_nand>;
+	nand-on-flash-bbt;
+	status = "disabled";
+};
+
 &i2c1 {
 	clock-frequency = <100000>;
 	pinctrl-names = "default";
@@ -207,6 +214,15 @@
 	status = "okay";
 };
 
+&usdhc2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc2>;
+	cd-gpios = <&gpio4 5 GPIO_ACTIVE_LOW>;
+	bus-width = <8>;
+	no-1-8-v;
+	status = "disabled";
+};
+
 &iomuxc {
 	pinctrl_enet1: enet1grp {
 		fsl,pins = <
@@ -223,6 +239,26 @@
 		>;
 	};
 
+	pinctrl_gpmi_nand: gpmi-nand {
+		fsl,pins = <
+			MX6UL_PAD_NAND_CLE__RAWNAND_CLE         0xb0b1
+			MX6UL_PAD_NAND_ALE__RAWNAND_ALE         0xb0b1
+			MX6UL_PAD_NAND_WP_B__RAWNAND_WP_B       0xb0b1
+			MX6UL_PAD_NAND_READY_B__RAWNAND_READY_B 0xb000
+			MX6UL_PAD_NAND_CE0_B__RAWNAND_CE0_B     0xb0b1
+			MX6UL_PAD_NAND_RE_B__RAWNAND_RE_B       0xb0b1
+			MX6UL_PAD_NAND_WE_B__RAWNAND_WE_B       0xb0b1
+			MX6UL_PAD_NAND_DATA00__RAWNAND_DATA00   0xb0b1
+			MX6UL_PAD_NAND_DATA01__RAWNAND_DATA01   0xb0b1
+			MX6UL_PAD_NAND_DATA02__RAWNAND_DATA02   0xb0b1
+			MX6UL_PAD_NAND_DATA03__RAWNAND_DATA03   0xb0b1
+			MX6UL_PAD_NAND_DATA04__RAWNAND_DATA04   0xb0b1
+			MX6UL_PAD_NAND_DATA05__RAWNAND_DATA05   0xb0b1
+			MX6UL_PAD_NAND_DATA06__RAWNAND_DATA06   0xb0b1
+			MX6UL_PAD_NAND_DATA07__RAWNAND_DATA07   0xb0b1
+		>;
+	};
+
 	pinctrl_i2c1: i2c1grp {
 		fsl,pins = <
 			MX6UL_PAD_UART4_TX_DATA__I2C1_SCL 0x4001b8b0
@@ -330,4 +366,20 @@
 			MX6UL_PAD_SD1_DATA3__USDHC1_DATA3 0x170f9
 		>;
 	};
+
+	pinctrl_usdhc2: usdhc2grp {
+		fsl,pins = <
+			MX6UL_PAD_NAND_RE_B__USDHC2_CLK      0x17070
+			MX6UL_PAD_NAND_WE_B__USDHC2_CMD      0x10070
+			MX6UL_PAD_NAND_DATA00__USDHC2_DATA0  0x17070
+			MX6UL_PAD_NAND_DATA01__USDHC2_DATA1  0x17070
+			MX6UL_PAD_NAND_DATA02__USDHC2_DATA2  0x17070
+			MX6UL_PAD_NAND_DATA03__USDHC2_DATA3  0x17070
+			MX6UL_PAD_NAND_DATA04__USDHC2_DATA4  0x17070
+			MX6UL_PAD_NAND_DATA05__USDHC2_DATA5  0x17070
+			MX6UL_PAD_NAND_DATA06__USDHC2_DATA6  0x17070
+			MX6UL_PAD_NAND_DATA07__USDHC2_DATA7  0x17070
+			MX6UL_PAD_NAND_ALE__USDHC2_RESET_B   0x17070
+		>;
+	};
 };
-- 
2.18.0.321.gffc6fa0e3
