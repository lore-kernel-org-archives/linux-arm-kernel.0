From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 13 Jun 2016 22:07:58 -0300
Subject: [PATCH 3/4] ARM: dts: imx6ul-evk: Use WDOG_B pin reset
In-Reply-To: <1465866479-15953-1-git-send-email-festevam@gmail.com>
References: <1465866479-15953-1-git-send-email-festevam@gmail.com>
Message-ID: <1465866479-15953-3-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

imx6ul-evk has WDOG1_B pin connected to the PMIC. 

Pass the 'fsl,ext-reset-output' property so that the watchdog
can trigger a system POR reset via the PMIC.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx6ul-14x14-evk.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ul-14x14-evk.dts b/arch/arm/boot/dts/imx6ul-14x14-evk.dts
index 668a729..d6ac6cb 100644
--- a/arch/arm/boot/dts/imx6ul-14x14-evk.dts
+++ b/arch/arm/boot/dts/imx6ul-14x14-evk.dts
@@ -207,6 +207,12 @@
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
 
@@ -435,4 +441,10 @@
 			MX6UL_PAD_NAND_DATA03__USDHC2_DATA3 0x17059
 		>;
 	};
+
+	pinctrl_wdog: wdoggrp {
+		fsl,pins = <
+			MX6UL_PAD_LCD_RESET__WDOG1_WDOG_ANY    0x30b0
+		>;
+	};
 };
-- 
1.9.1
