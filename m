From: marex@denx.de (Marek Vasut)
Date: Sun,  8 May 2016 22:50:18 +0200
Subject: [PATCH 1/4] ARM: mxs: dts: Add SSP2 SD mux
Message-ID: <1462740621-7557-1-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marek Vasut <marek.vasut@gmail.com>

Add pinmux configuration for SSP2 port in SD mode, both for
the 4-bit and 8-bit case.

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>
---
 arch/arm/boot/dts/imx23.dtsi | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm/boot/dts/imx23.dtsi b/arch/arm/boot/dts/imx23.dtsi
index 302d116..c70ebef 100644
--- a/arch/arm/boot/dts/imx23.dtsi
+++ b/arch/arm/boot/dts/imx23.dtsi
@@ -249,6 +249,40 @@
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
+				mmc1_4bit_pins_a: mmc1-4bit at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <
+						MX23_PAD_GPMI_D00__SSP2_DATA0
+						MX23_PAD_GPMI_D01__SSP2_DATA1
+						MX23_PAD_GPMI_D02__SSP2_DATA2
+						MX23_PAD_GPMI_D03__SSP2_DATA3
+						MX23_PAD_GPMI_RDY1__SSP2_CMD
+						MX23_PAD_GPMI_WRN__SSP2_SCK
+					>;
+					fsl,drive-strength = <MXS_DRIVE_8mA>;
+					fsl,voltage = <MXS_VOLTAGE_HIGH>;
+					fsl,pull-up = <MXS_PULL_ENABLE>;
+				};
+
+				mmc1_8bit_pins_a: mmc1-8bit at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <
+						MX23_PAD_GPMI_D00__SSP2_DATA0
+						MX23_PAD_GPMI_D01__SSP2_DATA1
+						MX23_PAD_GPMI_D02__SSP2_DATA2
+						MX23_PAD_GPMI_D03__SSP2_DATA3
+						MX23_PAD_GPMI_D04__SSP2_DATA4
+						MX23_PAD_GPMI_D05__SSP2_DATA5
+						MX23_PAD_GPMI_D06__SSP2_DATA6
+						MX23_PAD_GPMI_D07__SSP2_DATA7
+						MX23_PAD_GPMI_RDY1__SSP2_CMD
+						MX23_PAD_GPMI_WRN__SSP2_SCK
+					>;
+					fsl,drive-strength = <MXS_DRIVE_8mA>;
+					fsl,voltage = <MXS_VOLTAGE_HIGH>;
+					fsl,pull-up = <MXS_PULL_ENABLE>;
+				};
+
 				pwm2_pins_a: pwm2 at 0 {
 					reg = <0>;
 					fsl,pinmux-ids = <
-- 
2.7.0
