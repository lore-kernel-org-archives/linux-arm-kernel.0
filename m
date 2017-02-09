From: michael.heimpold@i2se.com (Michael Heimpold)
Date: Thu,  9 Feb 2017 08:42:41 +0100
Subject: [PATCH v4 1/9] ARM: dts: imx28: add alternative pinmuxing for mmc2
In-Reply-To: <1486626169-20022-1-git-send-email-michael.heimpold@i2se.com>
References: <1486626169-20022-1-git-send-email-michael.heimpold@i2se.com>
Message-ID: <1486626169-20022-2-git-send-email-michael.heimpold@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Michael Heimpold <michael.heimpold@i2se.com>
Cc: Stefan Wahren <stefan.wahren@i2se.com>
Acked-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm/boot/dts/imx28.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 3aabf65..bc5cf41 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -581,6 +581,22 @@
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
2.6.1
