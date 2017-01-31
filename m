From: michael.heimpold@i2se.com (Michael Heimpold)
Date: Tue, 31 Jan 2017 07:51:09 +0100
Subject: [PATCH v3 3/9] ARM: dts: imx28: add alternative muxing for
 mmc2_sck_cfg
In-Reply-To: <1485845475-3129-1-git-send-email-michael.heimpold@i2se.com>
References: <1485845475-3129-1-git-send-email-michael.heimpold@i2se.com>
Message-ID: <1485845475-3129-4-git-send-email-michael.heimpold@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Michael Heimpold <michael.heimpold@i2se.com>
Cc: Stefan Wahren <stefan.wahren@i2se.com>
Acked-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm/boot/dts/imx28.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 857ca37..5c65fa1 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -613,6 +613,15 @@
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
+				mmc2_sck_cfg_b: mmc2-sck-cfg at 1 {
+					reg = <1>;
+					fsl,pinmux-ids = <
+						MX28_PAD_SSP2_SCK__SSP2_SCK
+					>;
+					fsl,drive-strength = <MXS_DRIVE_12mA>;
+					fsl,pull-up = <MXS_PULL_DISABLE>;
+				};
+
 				i2c0_pins_a: i2c0 at 0 {
 					reg = <0>;
 					fsl,pinmux-ids = <
-- 
2.6.1
