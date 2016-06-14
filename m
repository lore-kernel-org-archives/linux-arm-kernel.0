From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 13 Jun 2016 22:07:59 -0300
Subject: [PATCH 4/4] ARM: dts: imx6sx-sdb: Use WDOG_B pin reset
In-Reply-To: <1465866479-15953-1-git-send-email-festevam@gmail.com>
References: <1465866479-15953-1-git-send-email-festevam@gmail.com>
Message-ID: <1465866479-15953-4-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

imx6sx-sdb has WDOG1_B pin connected to the PMIC. 

Pass the 'fsl,ext-reset-output' property so that the watchdog
can trigger a system POR reset via the PMIC.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx6sx-sdb.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sx-sdb.dtsi b/arch/arm/boot/dts/imx6sx-sdb.dtsi
index e5eafe4..06ff814 100644
--- a/arch/arm/boot/dts/imx6sx-sdb.dtsi
+++ b/arch/arm/boot/dts/imx6sx-sdb.dtsi
@@ -322,6 +322,12 @@
 	status = "okay";
 };
 
+&wdog1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wdog>;
+	fsl,ext-reset-output;
+};
+
 &iomuxc {
 	imx6x-sdb {
 		pinctrl_audmux: audmuxgrp {
@@ -588,5 +594,11 @@
 				MX6SX_PAD_SD4_DATA6__GPIO6_IO_20	0x17059 /* WP */
 			>;
 		};
+
+		pinctrl_wdog: wdoggrp {
+			fsl,pins = <
+				MX6SX_PAD_GPIO1_IO13__WDOG1_WDOG_ANY 0x30b0
+			>;
+		};
 	};
 };
-- 
1.9.1
