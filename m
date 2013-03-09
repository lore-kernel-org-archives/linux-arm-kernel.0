From: gwenhael.goavec-merou@armadeus.com (Gwenhael Goavec-Merou)
Date: Sat,  9 Mar 2013 14:59:08 +0100
Subject: [PATCH v2] ARM: imx51: Add pinctrl for ecspi2
Message-ID: <1362837548-5336-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add ecspi2 group of pins for imx51.

Signed-off-by: Gwenhael Goavec-Merou <gwenhael.goavec-merou@armadeus.com>
---
v2:
Suppress pinctrl hard-coding data (wrong copy/paste)

 arch/arm/boot/dts/imx51.dtsip | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/imx51.dtsip b/arch/arm/boot/dts/imx51.dtsip
index 6e14b75..7e09ccf 100644
--- a/arch/arm/boot/dts/imx51.dtsip
+++ b/arch/arm/boot/dts/imx51.dtsip
@@ -317,6 +317,16 @@
 					};
 				};
 
+				ecspi2 {
+					pinctrl_ecspi2_1: ecspi2grp-1 {
+						fsl,pins = <
+							MX51_PAD_NANDF_RB3__ECSPI2_MISO 0x185
+							MX51_PAD_NANDF_D15__ECSPI2_MOSI 0x185
+							MX51_PAD_NANDF_RB2__ECSPI2_SCLK 0x185
+						>;
+					};
+				};
+
 				esdhc1 {
 					pinctrl_esdhc1_1: esdhc1grp-1 {
 						fsl,pins = <
-- 
1.8.1.5
