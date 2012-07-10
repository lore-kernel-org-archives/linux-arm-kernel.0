From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 10 Jul 2012 13:36:21 +0800
Subject: [PATCH v2 1/7] ARM: dts: imx28: move extra gpmi-nand pins into board
 dts
In-Reply-To: <1341898587-8462-1-git-send-email-shawn.guo@linaro.org>
References: <1341898587-8462-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1341898587-8462-2-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Only pins GPMI_CE0N and GPMI_READY0 are generally used by other boards.
Move GPMI_CE1N and GPMI_READY1 into imx28-evk.dts to make gpmi_pins_a
more general, and can be used by other boards.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/imx28-evk.dts |   14 +++++++++++++-
 arch/arm/boot/dts/imx28.dtsi    |    2 --
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx28-evk.dts b/arch/arm/boot/dts/imx28-evk.dts
index 0d8739d..0444964 100644
--- a/arch/arm/boot/dts/imx28-evk.dts
+++ b/arch/arm/boot/dts/imx28-evk.dts
@@ -24,7 +24,8 @@
 		apbh at 80000000 {
 			gpmi-nand at 8000c000 {
 				pinctrl-names = "default";
-				pinctrl-0 = <&gpmi_pins_a &gpmi_status_cfg>;
+				pinctrl-0 = <&gpmi_pins_a &gpmi_status_cfg
+					     &gpmi_pins_evk>;
 				status = "okay";
 			};
 
@@ -64,6 +65,17 @@
 					fsl,voltage = <1>;
 					fsl,pull-up = <0>;
 				};
+
+				gpmi_pins_evk: gpmi-nand-evk at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <
+						0x0110 /* MX28_PAD_GPMI_CE1N__GPMI_CE1N */
+						0x0150 /* MX28_PAD_GPMI_RDY1__GPMI_READY1 */
+					>;
+					fsl,drive-strength = <0>;
+					fsl,voltage = <1>;
+					fsl,pull-up = <0>;
+				};
 			};
 
 			lcdif at 80030000 {
diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index adb5ffc..2874adc 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -198,9 +198,7 @@
 						0x0060 /* MX28_PAD_GPMI_D06__GPMI_D6 */
 						0x0070 /* MX28_PAD_GPMI_D07__GPMI_D7 */
 						0x0100 /* MX28_PAD_GPMI_CE0N__GPMI_CE0N */
-						0x0110 /* MX28_PAD_GPMI_CE1N__GPMI_CE1N */
 						0x0140 /* MX28_PAD_GPMI_RDY0__GPMI_READY0 */
-						0x0150 /* MX28_PAD_GPMI_RDY1__GPMI_READY1 */
 						0x0180 /* MX28_PAD_GPMI_RDN__GPMI_RDN */
 						0x0190 /* MX28_PAD_GPMI_WRN__GPMI_WRN */
 						0x01a0 /* MX28_PAD_GPMI_ALE__GPMI_ALE */
-- 
1.7.5.4
