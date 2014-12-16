From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 16 Dec 2014 17:30:29 -0200
Subject: [PATCH v2 2/2] ARM: dts: imx6sx-sdb: Add QSPI support
In-Reply-To: <1418758230-10246-1-git-send-email-festevam@gmail.com>
References: <1418758230-10246-1-git-send-email-festevam@gmail.com>
Message-ID: <1418758230-10246-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

imx6sx-sdb has two s25fl128s quad spi flash. Add support for them.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- None

 arch/arm/boot/dts/imx6sx-sdb.dts | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sx-sdb.dts b/arch/arm/boot/dts/imx6sx-sdb.dts
index 1e6e5cc..cdffe84 100644
--- a/arch/arm/boot/dts/imx6sx-sdb.dts
+++ b/arch/arm/boot/dts/imx6sx-sdb.dts
@@ -340,6 +340,28 @@
 	status = "okay";
 };
 
+&qspi2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_qspi2>;
+	status = "okay";
+
+	flash0: s25fl128s at 0 {
+		reg = <0>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "spansion,s25fl128s";
+		spi-max-frequency = <66000000>;
+	};
+
+	flash1: s25fl128s at 1 {
+		reg = <1>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "spansion,s25fl128s";
+		spi-max-frequency = <66000000>;
+	};
+};
+
 &ssi2 {
 	status = "okay";
 };
@@ -524,6 +546,23 @@
 			>;
 		};
 
+		pinctrl_qspi2: qspi2grp {
+			fsl,pins = <
+				MX6SX_PAD_NAND_WP_B__QSPI2_A_DATA_0     0x70f1
+				MX6SX_PAD_NAND_READY_B__QSPI2_A_DATA_1  0x70f1
+				MX6SX_PAD_NAND_CE0_B__QSPI2_A_DATA_2    0x70f1
+				MX6SX_PAD_NAND_CE1_B__QSPI2_A_DATA_3    0x70f1
+				MX6SX_PAD_NAND_CLE__QSPI2_A_SCLK        0x70f1
+				MX6SX_PAD_NAND_ALE__QSPI2_A_SS0_B       0x70f1
+				MX6SX_PAD_NAND_DATA01__QSPI2_B_DATA_0   0x70f1
+				MX6SX_PAD_NAND_DATA00__QSPI2_B_DATA_1   0x70f1
+				MX6SX_PAD_NAND_WE_B__QSPI2_B_DATA_2     0x70f1
+				MX6SX_PAD_NAND_RE_B__QSPI2_B_DATA_3     0x70f1
+				MX6SX_PAD_NAND_DATA02__QSPI2_B_SCLK     0x70f1
+				MX6SX_PAD_NAND_DATA03__QSPI2_B_SS0_B    0x70f1
+			>;
+		};
+
 		pinctrl_vcc_sd3: vccsd3grp {
 			fsl,pins = <
 				MX6SX_PAD_KEY_COL1__GPIO2_IO_11		0x17059
-- 
1.9.1
