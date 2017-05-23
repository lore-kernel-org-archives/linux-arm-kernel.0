From: fabio.estevam@nxp.com (Fabio Estevam)
Date: Tue, 23 May 2017 12:16:08 -0300
Subject: [PATCH 1/2] ARM: dts: imx7d-pico: Add watchdog support
Message-ID: <1495552569-18567-1-git-send-email-fabio.estevam@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

imx7d-pico has the WDOG1_B pin connected to the PMIC, so add the
wdog1 node and use the 'fsl,ext-reset-output' property to
properly describe it.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx7d-pico.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d-pico.dts b/arch/arm/boot/dts/imx7d-pico.dts
index ebda3df..f874352 100644
--- a/arch/arm/boot/dts/imx7d-pico.dts
+++ b/arch/arm/boot/dts/imx7d-pico.dts
@@ -284,6 +284,13 @@
 	status = "okay";
 };
 
+&wdog1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wdog>;
+	fsl,ext-reset-output;
+	status = "okay";
+};
+
 &iomuxc {
 	pinctrl_enet1: enet1grp {
 		fsl,pins = <
@@ -385,3 +392,11 @@
 		>;
 	};
 };
+
+&iomuxc_lpsr {
+	pinctrl_wdog: wdoggrp {
+		fsl,pins = <
+			MX7D_PAD_LPSR_GPIO1_IO00__WDOD1_WDOG_B	0x74
+		>;
+	};
+};
-- 
2.7.4
