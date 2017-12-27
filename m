From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 27 Dec 2017 12:04:34 -0200
Subject: [PATCH 1/5] ARM: dts: imx23: Pass unit address and reg to IOMUX node
Message-ID: <1514383478-32544-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Pass unit address and reg to IOMUX node to fix the following build
warning with W=1:

arch/arm/boot/dts/imx23-evk.dtb: Warning (simple_bus_reg): Node /apb at 80000000/apbh at 80000000/pinctrl at 80018000/gpmi-pins-fixup missing or empty reg/ranges property
arch/arm/boot/dts/imx23-evk.dtb: Warning (simple_bus_reg): Node /apb at 80000000/apbh at 80000000/pinctrl at 80018000/mmc0-pins-fixup missing or empty reg/ranges property

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx23.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx23.dtsi b/arch/arm/boot/dts/imx23.dtsi
index 10d57f9..da935a4 100644
--- a/arch/arm/boot/dts/imx23.dtsi
+++ b/arch/arm/boot/dts/imx23.dtsi
@@ -222,7 +222,8 @@
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
-				gpmi_pins_fixup: gpmi-pins-fixup {
+				gpmi_pins_fixup: gpmi-pins-fixup at 0 {
+					reg = <0>;
 					fsl,pinmux-ids = <
 						MX23_PAD_GPMI_WPN__GPMI_WPN
 						MX23_PAD_GPMI_WRN__GPMI_WRN
@@ -266,7 +267,8 @@
 					fsl,pull-up = <MXS_PULL_ENABLE>;
 				};
 
-				mmc0_pins_fixup: mmc0-pins-fixup {
+				mmc0_pins_fixup: mmc0-pins-fixup at 0 {
+					reg = <0>;
 					fsl,pinmux-ids = <
 						MX23_PAD_SSP1_DETECT__SSP1_DETECT
 						MX23_PAD_SSP1_SCK__SSP1_SCK
-- 
2.7.4
