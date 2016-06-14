From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 13 Jun 2016 22:07:56 -0300
Subject: [PATCH 1/4] ARM: dts: imx6qdl-sabresd: Use WDOG_B pin reset
Message-ID: <1465866479-15953-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

imx6qdl-sabresd has WDOG2_B pin connected to the PMIC. 

Pass the 'fsl,ext-reset-output' property so that the watchdog
can trigger a system POR reset via the PMIC.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
index 5248e7b..a8d65b4 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -501,6 +501,12 @@
 				MX6QDL_PAD_SD4_DAT7__SD4_DATA7		0x17059
 			>;
 		};
+
+		pinctrl_wdog: wdoggrp {
+			fsl,pins = <
+				MX6QDL_PAD_GPIO_1__WDOG2_B		0x1b0b0
+			>;
+		};
 	};
 
 	gpio_leds {
@@ -596,3 +602,14 @@
 	no-1-8-v;
 	status = "okay";
 };
+
+&wdog1 {
+	status = "disabled";
+};
+
+&wdog2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wdog>;
+	fsl,ext-reset-output;
+	status = "okay";
+};
-- 
1.9.1
