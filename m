From: festevam@gmail.com (Fabio Estevam)
Date: Mon,  8 Jul 2013 12:14:44 -0300
Subject: [PATCH 2/2] ARM: dts: imx6dl-wandboard: Add support for UART3
In-Reply-To: <1373296484-29847-1-git-send-email-festevam@gmail.com>
References: <1373296484-29847-1-git-send-email-festevam@gmail.com>
Message-ID: <1373296484-29847-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Wandboard has a bluetooth device connected to UART3, so add support for it.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx6dl-wandboard.dts |  7 +++++++
 arch/arm/boot/dts/imx6dl.dtsi          | 18 ++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/imx6dl-wandboard.dts b/arch/arm/boot/dts/imx6dl-wandboard.dts
index 027ece5..2654b32 100644
--- a/arch/arm/boot/dts/imx6dl-wandboard.dts
+++ b/arch/arm/boot/dts/imx6dl-wandboard.dts
@@ -108,6 +108,13 @@
 	status = "okay";
 };
 
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart3_2>;
+	fsl,uart-has-rtscts;
+	status = "okay";
+};
+
 &usbh1 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx6dl.dtsi b/arch/arm/boot/dts/imx6dl.dtsi
index e08c54c..c9850fc 100644
--- a/arch/arm/boot/dts/imx6dl.dtsi
+++ b/arch/arm/boot/dts/imx6dl.dtsi
@@ -232,6 +232,24 @@
 					};
 				};
 
+				uart3 {
+					pinctrl_uart3_1: uart3grp-1 {
+						fsl,pins = <
+							MX6DL_PAD_EIM_D24__UART3_TX_DATA 0x1b0b1
+							MX6DL_PAD_EIM_D25__UART3_RX_DATA 0x1b0b1
+						>;
+					};
+
+					pinctrl_uart3_2: uart3grp-2 {
+						fsl,pins = <
+							MX6DL_PAD_EIM_D24__UART3_TX_DATA 0x1b0b1
+							MX6DL_PAD_EIM_D25__UART3_RX_DATA 0x1b0b1
+							MX6DL_PAD_EIM_D23__UART3_CTS_B 0x1b0b1
+							MX6DL_PAD_EIM_EB3__UART3_RTS_B 0x1b0b1
+						>;
+					};
+				};
+
 				uart4 {
 					pinctrl_uart4_1: uart4grp-1 {
 						fsl,pins = <
-- 
1.8.1.2
