From: ryan.harkin@linaro.org (Ryan Harkin)
Date: Tue, 23 Jan 2018 12:37:30 +0000
Subject: [PATCH] ARM: dts: imx7s-warp: enable uart6 on mikroBus
Message-ID: <1516711050-2407-1-git-send-email-ryan.harkin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch configures the board to output UART6 to the mikroBus.

The NXP WaRP7 board can route UART6 to the mikroBus, where an RS232
click board can be plugged in to get an additional serial port.

Signed-off-by: Ryan Harkin <ryan.harkin@linaro.org>
Reviewed-by: Rui Miguel Silva <rui.silva@linaro.org>
---
 arch/arm/boot/dts/imx7s-warp.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/imx7s-warp.dts b/arch/arm/boot/dts/imx7s-warp.dts
index 9bdf121..1606713 100644
--- a/arch/arm/boot/dts/imx7s-warp.dts
+++ b/arch/arm/boot/dts/imx7s-warp.dts
@@ -271,6 +271,15 @@
 	status = "okay";
 };
 
+&uart6 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart6>;
+	assigned-clocks = <&clks IMX7D_UART6_ROOT_SRC>;
+	assigned-clock-parents = <&clks IMX7D_PLL_SYS_MAIN_240M_CLK>;
+	fsl,dte-mode;
+	status = "okay";
+};
+
 &usbotg1 {
 	dr_mode = "peripheral";
 	status = "okay";
@@ -379,6 +388,13 @@
 		>;
 	};
 
+	pinctrl_uart6: uart6grp {
+		fsl,pins = <
+			MX7D_PAD_ECSPI1_MOSI__UART6_DTE_RX	0x79
+			MX7D_PAD_ECSPI1_SCLK__UART6_DTE_TX	0x79
+		>;
+	};
+
 	pinctrl_usdhc1: usdhc1grp {
 		fsl,pins = <
 			MX7D_PAD_SD1_CMD__SD1_CMD	0x59
-- 
2.7.4
