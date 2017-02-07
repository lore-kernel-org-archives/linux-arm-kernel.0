From: festevam@gmail.com (Fabio Estevam)
Date: Tue,  7 Feb 2017 17:14:14 -0200
Subject: [PATCH] ARM: dts: imx6sx-udoo-neo: Fix reboot hang
Message-ID: <1486494854-30802-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

After issuing a 'reboot' command the imx6sx-udoo-neo board does not
reboot as expected and it just hangs instead.

In mainline kernel only LDO enabled mode is supported. Do not provide
arm-supply/soc-supply nodes in the device tree, so that the board operates
in LDO enabled mode and can then successfully reboot via watchdog.

Fixes: 76e691fc7653b85d39 ("ARM: dts: imx6sx: Add UDOO Neo support")
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx6sx-udoo-neo.dtsi | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/boot/dts/imx6sx-udoo-neo.dtsi b/arch/arm/boot/dts/imx6sx-udoo-neo.dtsi
index 49f466f..dcfc975 100644
--- a/arch/arm/boot/dts/imx6sx-udoo-neo.dtsi
+++ b/arch/arm/boot/dts/imx6sx-udoo-neo.dtsi
@@ -121,11 +121,6 @@
 	};
 };
 
-&cpu0 {
-	arm-supply = <&sw1a_reg>;
-	soc-supply = <&sw1c_reg>;
-};
-
 &fec1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_enet1>;
-- 
2.7.4
