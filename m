From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 27 Dec 2017 12:04:35 -0200
Subject: [PATCH 2/5] ARM: dts: imx28: Pass unit address and reg to IOMUX node
In-Reply-To: <1514383478-32544-1-git-send-email-festevam@gmail.com>
References: <1514383478-32544-1-git-send-email-festevam@gmail.com>
Message-ID: <1514383478-32544-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Pass unit address and reg to IOMUX node to fix the following build
warning with W=1:

arch/arm/boot/dts/imx28-apf28.dtb: Warning (simple_bus_reg): Node /apb at 80000000/apbh at 80000000/pinctrl at 80018000/gpmi-status-cfg missing or empty reg/ranges property
arch/arm/boot/dts/imx28-apf28.dtb: Warning (simple_bus_reg): Node /apb at 80000000/apbh at 80000000/pinctrl at 80018000/mmc0-cd-cfg missing or empty reg/ranges property
arch/arm/boot/dts/imx28-apf28.dtb: Warning (simple_bus_reg): Node /apb at 80000000/apbh at 80000000/pinctrl at 80018000/mmc0-sck-cfg missing or empty reg/ranges property
arch/arm/boot/dts/imx28-apf28.dtb: Warning (simple_bus_reg): Node /apb at 80000000/apbh at 80000000/pinctrl at 80018000/mmc1-cd-cfg missing or empty reg/ranges property
arch/arm/boot/dts/imx28-apf28.dtb: Warning (simple_bus_reg): Node /apb at 80000000/apbh at 80000000/pinctrl at 80018000/mmc1-sck-cfg missing or empty reg/ranges property
arch/arm/boot/dts/imx28-apf28.dtb: Warning (simple_bus_reg): Node /apb at 80000000/apbh at 80000000/pinctrl at 80018000/mmc2-cd-cfg missing or empty reg/ranges property

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx28.dtsi | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 2f4ebe0..8a6f3e0 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -283,7 +283,8 @@
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
-				gpmi_status_cfg: gpmi-status-cfg {
+				gpmi_status_cfg: gpmi-status-cfg at 0 {
+					reg = <0>;
 					fsl,pinmux-ids = <
 						MX28_PAD_GPMI_RDN__GPMI_RDN
 						MX28_PAD_GPMI_WRN__GPMI_WRN
@@ -527,14 +528,16 @@
 					fsl,pull-up = <MXS_PULL_ENABLE>;
 				};
 
-				mmc0_cd_cfg: mmc0-cd-cfg {
+				mmc0_cd_cfg: mmc0-cd-cfg at 0 {
+					reg = <0>;
 					fsl,pinmux-ids = <
 						MX28_PAD_SSP0_DETECT__SSP0_CARD_DETECT
 					>;
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
-				mmc0_sck_cfg: mmc0-sck-cfg {
+				mmc0_sck_cfg: mmc0-sck-cfg at 0 {
+					reg = <0>;
 					fsl,pinmux-ids = <
 						MX28_PAD_SSP0_SCK__SSP0_SCK
 					>;
@@ -558,14 +561,16 @@
 					fsl,pull-up = <MXS_PULL_ENABLE>;
 				};
 
-				mmc1_cd_cfg: mmc1-cd-cfg {
+				mmc1_cd_cfg: mmc1-cd-cfg at 0 {
+					reg = <0>;
 					fsl,pinmux-ids = <
 						MX28_PAD_GPMI_RDY0__SSP1_CARD_DETECT
 					>;
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
-				mmc1_sck_cfg: mmc1-sck-cfg {
+				mmc1_sck_cfg: mmc1-sck-cfg at 0 {
+					reg = <0>;
 					fsl,pinmux-ids = <
 						MX28_PAD_GPMI_WRN__SSP1_SCK
 					>;
@@ -606,7 +611,8 @@
 					fsl,pull-up = <MXS_PULL_ENABLE>;
 				};
 
-				mmc2_cd_cfg: mmc2-cd-cfg {
+				mmc2_cd_cfg: mmc2-cd-cfg at 0 {
+					reg = <0>;
 					fsl,pinmux-ids = <
 						MX28_PAD_AUART1_RX__SSP2_CARD_DETECT
 					>;
-- 
2.7.4
