From: b32955@freescale.com (Huang Shijie)
Date: Wed, 10 Jul 2013 17:40:26 +0800
Subject: [PATCH 1/2] ARM: dts: imx6q{dl}: add a new pinctrl for uart3
Message-ID: <1373449227-11740-1-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the a new pinctrl for uart3. In the imx6q{dl}-sabreauto boards,
the uart3 is used for Bluetooth.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 arch/arm/boot/dts/imx6dl.dtsi |   11 +++++++++++
 arch/arm/boot/dts/imx6q.dtsi  |   11 +++++++++++
 2 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx6dl.dtsi b/arch/arm/boot/dts/imx6dl.dtsi
index a1302ed..d818ced 100644
--- a/arch/arm/boot/dts/imx6dl.dtsi
+++ b/arch/arm/boot/dts/imx6dl.dtsi
@@ -234,6 +234,17 @@
 					};
 				};
 
+				uart3 {
+					pinctrl_uart3_1: uart3grp-1 {
+						fsl,pins = <
+							MX6DL_PAD_SD4_CLK__UART3_RX_DATA 0x1b0b1
+							MX6DL_PAD_SD4_CMD__UART3_TX_DATA 0x1b0b1
+							MX6DL_PAD_EIM_D30__UART3_CTS_B   0x1b0b1
+							MX6DL_PAD_EIM_EB3__UART3_RTS_B   0x1b0b1
+						>;
+					};
+				};
+
 				uart4 {
 					pinctrl_uart4_1: uart4grp-1 {
 						fsl,pins = <
diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index e0b7bad..1984ca4 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -277,6 +277,17 @@
 					};
 				};
 
+				uart3 {
+					pinctrl_uart3_1: uart3grp-1 {
+						fsl,pins = <
+							MX6Q_PAD_SD4_CLK__UART3_RX_DATA 0x1b0b1
+							MX6Q_PAD_SD4_CMD__UART3_TX_DATA 0x1b0b1
+							MX6Q_PAD_EIM_D30__UART3_CTS_B   0x1b0b1
+							MX6Q_PAD_EIM_EB3__UART3_RTS_B   0x1b0b1
+						>;
+					};
+				};
+
 				uart4 {
 					pinctrl_uart4_1: uart4grp-1 {
 						fsl,pins = <
-- 
1.7.1
