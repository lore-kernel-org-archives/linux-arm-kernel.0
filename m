From: b32955@freescale.com (Huang Shijie)
Date: Fri, 12 Jul 2013 15:56:11 +0800
Subject: [PATCH rebased 1/2] ARM: dts: imx6qdl: add a new pinctrl for uart3
Message-ID: <1373615772-30665-1-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the a new pinctrl for uart3. In the imx6q{dl}-sabreauto boards,
the uart3 is used for Bluetooth.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 arch/arm/boot/dts/imx6qdl.dtsi |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 5ca82bf..a050865 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -1028,6 +1028,17 @@
 					};
 				};
 
+				uart3 {
+					pinctrl_uart3_1: uart3grp-1 {
+						fsl,pins = <
+							PAD_SD4_CLK__UART3_RX_DATA 0x1b0b1
+							PAD_SD4_CMD__UART3_TX_DATA 0x1b0b1
+							PAD_EIM_D30__UART3_CTS_B   0x1b0b1
+							PAD_EIM_EB3__UART3_RTS_B   0x1b0b1
+						>;
+					};
+				};
+
 				uart4 {
 					pinctrl_uart4_1: uart4grp-1 {
 						fsl,pins = <
-- 
1.7.1
