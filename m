From: mhei@heimpold.de (Michael Heimpold)
Date: Sat, 22 Oct 2016 21:22:24 +0200
Subject: [PATCH 1/7] ARM: dts: imx28: add alternative pinmuxing for mmc2
In-Reply-To: <1477164150-13553-1-git-send-email-mhei@heimpold.de>
References: <1477164150-13553-1-git-send-email-mhei@heimpold.de>
Message-ID: <1477164150-13553-2-git-send-email-mhei@heimpold.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Michael Heimpold <michael.heimpold@i2se.com>

Signed-off-by: Michael Heimpold <michael.heimpold@i2se.com>
---
 arch/arm/boot/dts/imx28.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 0ad893b..ef6e10d 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -579,6 +579,22 @@
 					fsl,pull-up = <MXS_PULL_ENABLE>;
 				};
 
+				mmc2_4bit_pins_b: mmc2-4bit at 1 {
+					reg = <1>;
+					fsl,pinmux-ids = <
+						MX28_PAD_SSP2_SCK__SSP2_SCK
+						MX28_PAD_SSP2_MOSI__SSP2_CMD
+						MX28_PAD_SSP2_MISO__SSP2_D0
+						MX28_PAD_SSP2_SS0__SSP2_D3
+						MX28_PAD_SSP2_SS1__SSP2_D1
+						MX28_PAD_SSP2_SS2__SSP2_D2
+						MX28_PAD_AUART1_RX__SSP2_CARD_DETECT
+					>;
+					fsl,drive-strength = <MXS_DRIVE_8mA>;
+					fsl,voltage = <MXS_VOLTAGE_HIGH>;
+					fsl,pull-up = <MXS_PULL_ENABLE>;
+				};
+
 				mmc2_cd_cfg: mmc2-cd-cfg {
 					fsl,pinmux-ids = <
 						MX28_PAD_AUART1_RX__SSP2_CARD_DETECT
-- 
2.7.4
