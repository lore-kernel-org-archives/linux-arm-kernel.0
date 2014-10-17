From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 17 Oct 2014 15:39:32 -0300
Subject: [PATCH] ARM: dts: imx6sx-sdb: Add QSPI support
Message-ID: <1413571172-30940-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

imx6sx-sdb has two s25fl128s quad spi flash. Add support for them.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
There are still some extra patches needed to get s25fl128s supported.

They were already sent into mtd-list, but have not been applied yet.

However, the dts part could go independently.

 arch/arm/boot/dts/imx6sx-sdb.dts | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sx-sdb.dts b/arch/arm/boot/dts/imx6sx-sdb.dts
index 82d6b34..64cee09 100644
--- a/arch/arm/boot/dts/imx6sx-sdb.dts
+++ b/arch/arm/boot/dts/imx6sx-sdb.dts
@@ -304,6 +304,28 @@
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
@@ -458,6 +480,23 @@
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
