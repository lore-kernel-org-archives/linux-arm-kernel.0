From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 13 Aug 2012 21:05:23 +0800
Subject: [PATCH 03/17] ARM: dts: imx6q: sort iomuxc sub-nodes in name
In-Reply-To: <1344863137-6112-1-git-send-email-shawn.guo@linaro.org>
References: <1344863137-6112-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1344863137-6112-4-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sort iomuxc sub-nodes in name so that the node can be located a little
bit easier.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/imx6q.dtsi |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index a078436..e8595fa 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -515,6 +515,16 @@
 					};
 				};
 
+				ecspi1 {
+					pinctrl_ecspi1_1: ecspi1grp-1 {
+						fsl,pins = <
+							101 0x100b1	/* MX6Q_PAD_EIM_D17__ECSPI1_MISO */
+							109 0x100b1	/* MX6Q_PAD_EIM_D18__ECSPI1_MOSI */
+							94  0x100b1	/* MX6Q_PAD_EIM_D16__ECSPI1_SCLK */
+						>;
+					};
+				};
+
 				gpmi-nand {
 					pinctrl_gpmi_nand_1: gpmi-nand-1 {
 						fsl,pins = <
@@ -592,16 +602,6 @@
 						>;
 					};
 				};
-
-				ecspi1 {
-					pinctrl_ecspi1_1: ecspi1grp-1 {
-						fsl,pins = <
-							101 0x100b1	/* MX6Q_PAD_EIM_D17__ECSPI1_MISO */
-							109 0x100b1	/* MX6Q_PAD_EIM_D18__ECSPI1_MOSI */
-							94  0x100b1	/* MX6Q_PAD_EIM_D16__ECSPI1_SCLK */
-						>;
-					};
-				};
 			};
 
 			dcic at 020e4000 { /* DCIC1 */
-- 
1.7.5.4
