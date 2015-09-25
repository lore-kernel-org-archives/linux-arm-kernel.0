From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Fri, 25 Sep 2015 15:51:31 +0200
Subject: [PATCH 1/2] ARM: ux500: remove regulator-compatible usage
Message-ID: <1443189092-16430-1-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The regulator-compatible property from the regulator DT binding was
deprecated and the correct approach is to use the node's name.

This patch has no functional changes since the values of the node's
name and the regulator-compatible match for all the regulators.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

 arch/arm/boot/dts/ste-dbx5x0.dtsi | 33 ---------------------------------
 1 file changed, 33 deletions(-)

diff --git a/arch/arm/boot/dts/ste-dbx5x0.dtsi b/arch/arm/boot/dts/ste-dbx5x0.dtsi
index 50f5e9d09203..341f5b7ed242 100644
--- a/arch/arm/boot/dts/ste-dbx5x0.dtsi
+++ b/arch/arm/boot/dts/ste-dbx5x0.dtsi
@@ -512,63 +512,51 @@
 
 				// DB8500_REGULATOR_VAPE
 				db8500_vape_reg: db8500_vape {
-					regulator-compatible = "db8500_vape";
 					regulator-always-on;
 				};
 
 				// DB8500_REGULATOR_VARM
 				db8500_varm_reg: db8500_varm {
-					regulator-compatible = "db8500_varm";
 				};
 
 				// DB8500_REGULATOR_VMODEM
 				db8500_vmodem_reg: db8500_vmodem {
-					regulator-compatible = "db8500_vmodem";
 				};
 
 				// DB8500_REGULATOR_VPLL
 				db8500_vpll_reg: db8500_vpll {
-					regulator-compatible = "db8500_vpll";
 				};
 
 				// DB8500_REGULATOR_VSMPS1
 				db8500_vsmps1_reg: db8500_vsmps1 {
-					regulator-compatible = "db8500_vsmps1";
 				};
 
 				// DB8500_REGULATOR_VSMPS2
 				db8500_vsmps2_reg: db8500_vsmps2 {
-					regulator-compatible = "db8500_vsmps2";
 				};
 
 				// DB8500_REGULATOR_VSMPS3
 				db8500_vsmps3_reg: db8500_vsmps3 {
-					regulator-compatible = "db8500_vsmps3";
 				};
 
 				// DB8500_REGULATOR_VRF1
 				db8500_vrf1_reg: db8500_vrf1 {
-					regulator-compatible = "db8500_vrf1";
 				};
 
 				// DB8500_REGULATOR_SWITCH_SVAMMDSP
 				db8500_sva_mmdsp_reg: db8500_sva_mmdsp {
-					regulator-compatible = "db8500_sva_mmdsp";
 				};
 
 				// DB8500_REGULATOR_SWITCH_SVAMMDSPRET
 				db8500_sva_mmdsp_ret_reg: db8500_sva_mmdsp_ret {
-					regulator-compatible = "db8500_sva_mmdsp_ret";
 				};
 
 				// DB8500_REGULATOR_SWITCH_SVAPIPE
 				db8500_sva_pipe_reg: db8500_sva_pipe {
-					regulator-compatible = "db8500_sva_pipe";
 				};
 
 				// DB8500_REGULATOR_SWITCH_SIAMMDSP
 				db8500_sia_mmdsp_reg: db8500_sia_mmdsp {
-					regulator-compatible = "db8500_sia_mmdsp";
 				};
 
 				// DB8500_REGULATOR_SWITCH_SIAMMDSPRET
@@ -577,39 +565,32 @@
 
 				// DB8500_REGULATOR_SWITCH_SIAPIPE
 				db8500_sia_pipe_reg: db8500_sia_pipe {
-					regulator-compatible = "db8500_sia_pipe";
 				};
 
 				// DB8500_REGULATOR_SWITCH_SGA
 				db8500_sga_reg: db8500_sga {
-					regulator-compatible = "db8500_sga";
 					vin-supply = <&db8500_vape_reg>;
 				};
 
 				// DB8500_REGULATOR_SWITCH_B2R2_MCDE
 				db8500_b2r2_mcde_reg: db8500_b2r2_mcde {
-					regulator-compatible = "db8500_b2r2_mcde";
 					vin-supply = <&db8500_vape_reg>;
 				};
 
 				// DB8500_REGULATOR_SWITCH_ESRAM12
 				db8500_esram12_reg: db8500_esram12 {
-					regulator-compatible = "db8500_esram12";
 				};
 
 				// DB8500_REGULATOR_SWITCH_ESRAM12RET
 				db8500_esram12_ret_reg: db8500_esram12_ret {
-					regulator-compatible = "db8500_esram12_ret";
 				};
 
 				// DB8500_REGULATOR_SWITCH_ESRAM34
 				db8500_esram34_reg: db8500_esram34 {
-					regulator-compatible = "db8500_esram34";
 				};
 
 				// DB8500_REGULATOR_SWITCH_ESRAM34RET
 				db8500_esram34_ret_reg: db8500_esram34_ret {
-					regulator-compatible = "db8500_esram34_ret";
 				};
 			};
 
@@ -721,7 +702,6 @@
 					compatible = "stericsson,ab8500-ext-regulator";
 
 					ab8500_ext1_reg: ab8500_ext1 {
-						regulator-compatible = "ab8500_ext1";
 						regulator-min-microvolt = <1800000>;
 						regulator-max-microvolt = <1800000>;
 						regulator-boot-on;
@@ -729,7 +709,6 @@
 					};
 
 					ab8500_ext2_reg: ab8500_ext2 {
-						regulator-compatible = "ab8500_ext2";
 						regulator-min-microvolt = <1360000>;
 						regulator-max-microvolt = <1360000>;
 						regulator-boot-on;
@@ -737,7 +716,6 @@
 					};
 
 					ab8500_ext3_reg: ab8500_ext3 {
-						regulator-compatible = "ab8500_ext3";
 						regulator-min-microvolt = <3400000>;
 						regulator-max-microvolt = <3400000>;
 						regulator-boot-on;
@@ -750,7 +728,6 @@
 
 					// supplies to the display/camera
 					ab8500_ldo_aux1_reg: ab8500_ldo_aux1 {
-						regulator-compatible = "ab8500_ldo_aux1";
 						regulator-min-microvolt = <2500000>;
 						regulator-max-microvolt = <2900000>;
 						regulator-boot-on;
@@ -760,56 +737,46 @@
 
 					// supplies to the on-board eMMC
 					ab8500_ldo_aux2_reg: ab8500_ldo_aux2 {
-						regulator-compatible = "ab8500_ldo_aux2";
 						regulator-min-microvolt = <1100000>;
 						regulator-max-microvolt = <3300000>;
 					};
 
 					// supply for VAUX3; SDcard slots
 					ab8500_ldo_aux3_reg: ab8500_ldo_aux3 {
-						regulator-compatible = "ab8500_ldo_aux3";
 						regulator-min-microvolt = <1100000>;
 						regulator-max-microvolt = <3300000>;
 					};
 
 					// supply for v-intcore12; VINTCORE12 LDO
 					ab8500_ldo_intcore_reg: ab8500_ldo_intcore {
-						regulator-compatible = "ab8500_ldo_intcore";
 					};
 
 					// supply for tvout; gpadc; TVOUT LDO
 					ab8500_ldo_tvout_reg: ab8500_ldo_tvout {
-						regulator-compatible = "ab8500_ldo_tvout";
 					};
 
 					// supply for ab8500-usb; USB LDO
 					ab8500_ldo_usb_reg: ab8500_ldo_usb {
-						regulator-compatible = "ab8500_ldo_usb";
 					};
 
 					// supply for ab8500-vaudio; VAUDIO LDO
 					ab8500_ldo_audio_reg: ab8500_ldo_audio {
-						regulator-compatible = "ab8500_ldo_audio";
 					};
 
 					// supply for v-anamic1 VAMIC1 LDO
 					ab8500_ldo_anamic1_reg: ab8500_ldo_anamic1 {
-						regulator-compatible = "ab8500_ldo_anamic1";
 					};
 
 					// supply for v-amic2; VAMIC2 LDO; reuse constants for AMIC1
 					ab8500_ldo_anamic2_reg: ab8500_ldo_anamic2 {
-						regulator-compatible = "ab8500_ldo_anamic2";
 					};
 
 					// supply for v-dmic; VDMIC LDO
 					ab8500_ldo_dmic_reg: ab8500_ldo_dmic {
-						regulator-compatible = "ab8500_ldo_dmic";
 					};
 
 					// supply for U8500 CSI/DSI; VANA LDO
 					ab8500_ldo_ana_reg: ab8500_ldo_ana {
-						regulator-compatible = "ab8500_ldo_ana";
 					};
 				};
 			};
-- 
2.4.3
