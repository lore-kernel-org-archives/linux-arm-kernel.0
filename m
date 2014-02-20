From: ashutosh.s@phytec.in (Ashutosh singh)
Date: Thu, 20 Feb 2014 11:20:17 +0530
Subject: [PATCH v3 3/4] ARM: dts: imx6q-phytec: Added GPMI-NAND Support
In-Reply-To: <1392875418-9034-1-git-send-email-ashutosh.s@phytec.in>
References: <1392875418-9034-1-git-send-email-ashutosh.s@phytec.in>
Message-ID: <1392875418-9034-3-git-send-email-ashutosh.s@phytec.in>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for GPMI-NAND on Phytec phyFLEX-i.MX6 Quad module.

Signed-off-by: Ashutosh singh <ashutosh.s@phytec.in>
---
 arch/arm/boot/dts/imx6q-phytec-pbab01.dts  |    4 ++++
 arch/arm/boot/dts/imx6q-phytec-pfla02.dtsi |   29 ++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/arch/arm/boot/dts/imx6q-phytec-pbab01.dts b/arch/arm/boot/dts/imx6q-phytec-pbab01.dts
index 91aecba..21c8b37 100644
--- a/arch/arm/boot/dts/imx6q-phytec-pbab01.dts
+++ b/arch/arm/boot/dts/imx6q-phytec-pbab01.dts
@@ -21,6 +21,10 @@
 	status = "okay";
 };
 
+&gpmi {
+	status = "okay";
+};
+
 &uart4 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx6q-phytec-pfla02.dtsi b/arch/arm/boot/dts/imx6q-phytec-pfla02.dtsi
index b1a78a0..324f155 100644
--- a/arch/arm/boot/dts/imx6q-phytec-pfla02.dtsi
+++ b/arch/arm/boot/dts/imx6q-phytec-pfla02.dtsi
@@ -190,6 +190,28 @@
 			>;
 		};
 
+		pinctrl_gpmi_nand: gpminandgrp {
+			fsl,pins = <
+				MX6QDL_PAD_NANDF_CLE__NAND_CLE		0xb0b1
+				MX6QDL_PAD_NANDF_ALE__NAND_ALE		0xb0b1
+				MX6QDL_PAD_NANDF_WP_B__NAND_WP_B	0xb0b1
+				MX6QDL_PAD_NANDF_RB0__NAND_READY_B	0xb000
+				MX6QDL_PAD_NANDF_CS0__NAND_CE0_B	0xb0b1
+				MX6QDL_PAD_NANDF_CS1__NAND_CE1_B	0xb0b1
+				MX6QDL_PAD_SD4_CMD__NAND_RE_B		0xb0b1
+				MX6QDL_PAD_SD4_CLK__NAND_WE_B		0xb0b1
+				MX6QDL_PAD_NANDF_D0__NAND_DATA00	0xb0b1
+				MX6QDL_PAD_NANDF_D1__NAND_DATA01	0xb0b1
+				MX6QDL_PAD_NANDF_D2__NAND_DATA02	0xb0b1
+				MX6QDL_PAD_NANDF_D3__NAND_DATA03	0xb0b1
+				MX6QDL_PAD_NANDF_D4__NAND_DATA04	0xb0b1
+				MX6QDL_PAD_NANDF_D5__NAND_DATA05	0xb0b1
+				MX6QDL_PAD_NANDF_D6__NAND_DATA06	0xb0b1
+				MX6QDL_PAD_NANDF_D7__NAND_DATA07	0xb0b1
+				MX6QDL_PAD_SD4_DAT0__NAND_DQS		0x00b1
+			>;
+		};
+
 		pinctrl_i2c1: i2c1grp {
 			fsl,pins = <
 				MX6QDL_PAD_EIM_D21__I2C1_SCL		0x4001b8b1
@@ -257,6 +279,13 @@
 	status = "disabled";
 };
 
+&gpmi {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpmi_nand>;
+	nand-on-flash-bbt;
+	status = "disabled";
+};
+
 &uart4 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart4>;
-- 
1.7.9.5
