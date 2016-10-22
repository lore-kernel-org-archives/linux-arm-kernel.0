From: mhei@heimpold.de (Michael Heimpold)
Date: Sat, 22 Oct 2016 21:22:26 +0200
Subject: [PATCH 3/7] ARM: dts: imx28: add alternative muxing for mmc2_sck_cfg
In-Reply-To: <1477164150-13553-1-git-send-email-mhei@heimpold.de>
References: <1477164150-13553-1-git-send-email-mhei@heimpold.de>
Message-ID: <1477164150-13553-4-git-send-email-mhei@heimpold.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Michael Heimpold <michael.heimpold@i2se.com>

Signed-off-by: Michael Heimpold <michael.heimpold@i2se.com>
---
 arch/arm/boot/dts/imx28.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index e29d797..f7707b4 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -611,6 +611,15 @@
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
2.7.4
