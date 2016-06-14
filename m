From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 13 Jun 2016 22:07:57 -0300
Subject: [PATCH 2/4] ARM: dts: imx7d-sdb: Use WDOG_B pin reset
In-Reply-To: <1465866479-15953-1-git-send-email-festevam@gmail.com>
References: <1465866479-15953-1-git-send-email-festevam@gmail.com>
Message-ID: <1465866479-15953-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

imx7d-sdb has WDOG1_B pin connected to the PMIC. 

Pass the 'fsl,ext-reset-output' property so that the watchdog
can trigger a system POR reset via the PMIC.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx7d-sdb.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d-sdb.dts b/arch/arm/boot/dts/imx7d-sdb.dts
index b267f79..d6da506 100644
--- a/arch/arm/boot/dts/imx7d-sdb.dts
+++ b/arch/arm/boot/dts/imx7d-sdb.dts
@@ -314,6 +314,12 @@
 	status = "okay";
 };
 
+&wdog1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wdog>;
+	fsl,ext-reset-output;
+};
+
 &iomuxc {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_hog>;
@@ -512,5 +518,10 @@
 			>;
 		};
 
+		pinctrl_wdog: wdoggrp {
+			fsl,pins = <
+				MX7D_PAD_GPIO1_IO00__WDOD1_WDOG_B	0x74
+			>;
+		};
 	};
 };
-- 
1.9.1
