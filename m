From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 16 Aug 2016 22:46:42 -0300
Subject: [PATCH] ARM: dts: imx6ul-pico-hobbit: Use WDOG_B pin reset
Message-ID: <1471398402-20559-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

imx6ul-pico has WDOG1_B pin connected to the PMIC.

Pass the 'fsl,ext-reset-output' property so that the watchdog
can trigger a system POR reset via PMIC.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx6ul-pico-hobbit.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ul-pico-hobbit.dts b/arch/arm/boot/dts/imx6ul-pico-hobbit.dts
index 7b18dc4..827d9e8 100644
--- a/arch/arm/boot/dts/imx6ul-pico-hobbit.dts
+++ b/arch/arm/boot/dts/imx6ul-pico-hobbit.dts
@@ -344,6 +344,12 @@
 	status = "okay";
 };
 
+&wdog1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wdog>;
+	fsl,ext-reset-output;
+};
+
 &iomuxc {
 	pinctrl_brcm_reg: brcmreggrp {
 		fsl,pins = <
@@ -534,4 +540,10 @@
 			MX6UL_PAD_NAND_DATA03__USDHC2_DATA3	0x17059
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
