From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri,  8 Aug 2014 11:24:21 +0200
Subject: [PATCH 1/2] ARM: dts: imx28: add pinmuxing for mmc1
Message-ID: <1407489862-6358-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Kleine-Budde <mkl@pengutronix.de>

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
[ukl: rebase from ancient kernel version]
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/boot/dts/imx28.dtsi | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index a95cc5358ff4..defb98a5b045 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -489,6 +489,38 @@
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
+				mmc1_4bit_pins_a: mmc1-4bit at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <
+						MX28_PAD_GPMI_D00__SSP1_D0
+						MX28_PAD_GPMI_D01__SSP1_D1
+						MX28_PAD_GPMI_D02__SSP1_D2
+						MX28_PAD_GPMI_D03__SSP1_D3
+						MX28_PAD_GPMI_RDY1__SSP1_CMD
+						MX28_PAD_GPMI_RDY0__SSP1_CARD_DETECT
+						MX28_PAD_GPMI_WRN__SSP1_SCK
+					>;
+					fsl,drive-strength = <MXS_DRIVE_8mA>;
+					fsl,voltage = <MXS_VOLTAGE_HIGH>;
+					fsl,pull-up = <MXS_PULL_ENABLE>;
+				};
+
+				mmc1_cd_cfg: mmc1-cd-cfg {
+					fsl,pinmux-ids = <
+						MX28_PAD_GPMI_RDY0__SSP1_CARD_DETECT
+					>;
+					fsl,pull-up = <MXS_PULL_DISABLE>;
+				};
+
+				mmc1_sck_cfg: mmc1-sck-cfg {
+					fsl,pinmux-ids = <
+						MX28_PAD_GPMI_WRN__SSP1_SCK
+					>;
+					fsl,drive-strength = <MXS_DRIVE_12mA>;
+					fsl,pull-up = <MXS_PULL_DISABLE>;
+				};
+
+
 				mmc2_4bit_pins_a: mmc2-4bit at 0 {
 					reg = <0>;
 					fsl,pinmux-ids = <
-- 
2.0.1
