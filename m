From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 15 Aug 2016 13:47:34 -0300
Subject: [PATCH 3/3] ARM: dts: imx7s-warp: Use WDOG_B pin reset
In-Reply-To: <1471279654-16711-1-git-send-email-festevam@gmail.com>
References: <1471279654-16711-1-git-send-email-festevam@gmail.com>
Message-ID: <1471279654-16711-3-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

imx7s-warpd has WDOG1_B pin connected to the PMIC.
    
Pass the 'fsl,ext-reset-output' property so that the watchdog
can trigger a system POR reset via the PMIC.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx7s-warp.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/imx7s-warp.dts b/arch/arm/boot/dts/imx7s-warp.dts
index cf730c1..8ef1cdc 100644
--- a/arch/arm/boot/dts/imx7s-warp.dts
+++ b/arch/arm/boot/dts/imx7s-warp.dts
@@ -257,6 +257,13 @@
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
 	pinctrl_brcm_reg: brcmreggrp {
 		fsl,pins = <
@@ -354,4 +361,10 @@
 			MX7D_PAD_SD3_RESET_B__SD3_RESET_B	0x1b
 		>;
 	};
+
+	pinctrl_wdog: wdoggrp {
+		fsl,pins = <
+			MX7D_PAD_GPIO1_IO00__WDOD1_WDOG_B	0x74
+		>;
+	};
 };
-- 
2.7.4
