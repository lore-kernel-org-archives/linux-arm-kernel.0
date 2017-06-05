From: festevam@gmail.com (Fabio Estevam)
Date: Mon,  5 Jun 2017 08:17:49 -0300
Subject: [PATCH v2 3/3] ARM: dts: imx7d-sdb: Add Bluetooth support
In-Reply-To: <1496661469-15735-1-git-send-email-festevam@gmail.com>
References: <1496661469-15735-1-git-send-email-festevam@gmail.com>
Message-ID: <1496661469-15735-3-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

imx7d-sdb has a BCM4339 BT chip connected to UART6.

Add support for it.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
Changes since v1:
- Use uart-has-rtscts

 arch/arm/boot/dts/imx7d-sdb.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d-sdb.dts b/arch/arm/boot/dts/imx7d-sdb.dts
index fc7e0b0..af90305 100644
--- a/arch/arm/boot/dts/imx7d-sdb.dts
+++ b/arch/arm/boot/dts/imx7d-sdb.dts
@@ -370,6 +370,15 @@
 	status = "okay";
 };
 
+&uart6 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart6>;
+	assigned-clocks = <&clks IMX7D_UART6_ROOT_SRC>;
+	assigned-clock-parents = <&clks IMX7D_PLL_SYS_MAIN_240M_CLK>;
+	uart-has-rtscts;
+	status = "okay";
+};
+
 &usbotg1 {
 	vbus-supply = <&reg_usb_otg1_vbus>;
 	status = "okay";
-- 
2.7.4
