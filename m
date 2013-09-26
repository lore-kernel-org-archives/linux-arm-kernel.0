From: marex@denx.de (Marek Vasut)
Date: Thu, 26 Sep 2013 13:16:16 +0200
Subject: [PATCH 1/2] ARM: dts: mxs: Add muxing options for the SSP2 MMC
Message-ID: <1380194177-5191-1-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pinmux for 4-bit SD card connected to SSP2.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/imx28.dtsi | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 8b5ad60..69f4ea4 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -473,6 +473,37 @@
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
+				mmc2_4bit_pins_a: mmc2-4bit at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <
+						MX28_PAD_SSP0_DATA4__SSP2_D0
+						MX28_PAD_SSP1_SCK__SSP2_D1
+						MX28_PAD_SSP1_CMD__SSP2_D2
+						MX28_PAD_SSP0_DATA5__SSP2_D3
+						MX28_PAD_SSP0_DATA6__SSP2_CMD
+						MX28_PAD_AUART1_RX__SSP2_CARD_DETECT
+						MX28_PAD_SSP0_DATA7__SSP2_SCK
+					>;
+					fsl,drive-strength = <MXS_DRIVE_8mA>;
+					fsl,voltage = <MXS_VOLTAGE_HIGH>;
+					fsl,pull-up = <MXS_PULL_ENABLE>;
+				};
+
+				mmc2_cd_cfg: mmc2-cd-cfg {
+					fsl,pinmux-ids = <
+						MX28_PAD_AUART1_RX__SSP2_CARD_DETECT
+					>;
+					fsl,pull-up = <MXS_PULL_DISABLE>;
+				};
+
+				mmc2_sck_cfg: mmc2-sck-cfg {
+					fsl,pinmux-ids = <
+						MX28_PAD_SSP0_DATA7__SSP2_SCK
+					>;
+					fsl,drive-strength = <MXS_DRIVE_12mA>;
+					fsl,pull-up = <MXS_PULL_DISABLE>;
+				};
+
 				i2c0_pins_a: i2c0 at 0 {
 					reg = <0>;
 					fsl,pinmux-ids = <
-- 
1.8.4.rc3
