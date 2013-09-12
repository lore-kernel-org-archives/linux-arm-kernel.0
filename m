From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 12 Sep 2013 15:45:30 +0200
Subject: [PATCH 1/2] ARM: ux500: delete surplus PRCMU regulator defines
Message-ID: <1378993530-24365-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Ux500 boards are layered like this:
ste-snowball.dts includes ste-href.dtsi that includes
ste-dbx500.dtsi.

The dbx500.dtsi defines the PRCMU SoC regulators so the SoC will
probe and you can use ampersand references where need be.

However the HREF common dtsi and these two boards redefine the
same PRCMU SoC regulators with the very same names and properties
for no reason. This is like filling in the same line three
times instead of drawing it once. Just delete the surplus
references and have the PRCMU regulators defines in the SoC
files ste-dbx500.dtsi, this is enough.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-href.dtsi       | 82 -----------------------------------
 arch/arm/boot/dts/ste-hrefv60plus.dts | 82 -----------------------------------
 arch/arm/boot/dts/ste-snowball.dts    | 82 -----------------------------------
 3 files changed, 246 deletions(-)

diff --git a/arch/arm/boot/dts/ste-href.dtsi b/arch/arm/boot/dts/ste-href.dtsi
index 370e03f..f88a659 100644
--- a/arch/arm/boot/dts/ste-href.dtsi
+++ b/arch/arm/boot/dts/ste-href.dtsi
@@ -167,88 +167,6 @@
 		};
 
 		prcmu at 80157000 {
-			db8500-prcmu-regulators {
-				db8500_vape_reg: db8500_vape {
-					regulator-name = "db8500-vape";
-				};
-
-				db8500_varm_reg: db8500_varm {
-					regulator-name = "db8500-varm";
-				};
-
-				db8500_vmodem_reg: db8500_vmodem {
-					regulator-name = "db8500-vmodem";
-				};
-
-				db8500_vpll_reg: db8500_vpll {
-					regulator-name = "db8500-vpll";
-				};
-
-				db8500_vsmps1_reg: db8500_vsmps1 {
-					regulator-name = "db8500-vsmps1";
-				};
-
-				db8500_vsmps2_reg: db8500_vsmps2 {
-					regulator-name = "db8500-vsmps2";
-				};
-
-				db8500_vsmps3_reg: db8500_vsmps3 {
-					regulator-name = "db8500-vsmps3";
-				};
-
-				db8500_vrf1_reg: db8500_vrf1 {
-					regulator-name = "db8500-vrf1";
-				};
-
-				db8500_sva_mmdsp_reg: db8500_sva_mmdsp {
-					regulator-name = "db8500-sva-mmdsp";
-				};
-
-				db8500_sva_mmdsp_ret_reg: db8500_sva_mmdsp_ret {
-					regulator-name = "db8500-sva-mmdsp-ret";
-				};
-
-				db8500_sva_pipe_reg: db8500_sva_pipe {
-					regulator-name = "db8500_sva_pipe";
-				};
-
-				db8500_sia_mmdsp_reg: db8500_sia_mmdsp {
-					regulator-name = "db8500_sia_mmdsp";
-				};
-
-				db8500_sia_mmdsp_ret_reg: db8500_sia_mmdsp_ret {
-					regulator-name = "db8500-sia-mmdsp-ret";
-				};
-
-				db8500_sia_pipe_reg: db8500_sia_pipe {
-					regulator-name = "db8500-sia-pipe";
-				};
-
-				db8500_sga_reg: db8500_sga {
-					regulator-name = "db8500-sga";
-				};
-
-				db8500_b2r2_mcde_reg: db8500_b2r2_mcde {
-					regulator-name = "db8500-b2r2-mcde";
-				};
-
-				db8500_esram12_reg: db8500_esram12 {
-					regulator-name = "db8500-esram12";
-				};
-
-				db8500_esram12_ret_reg: db8500_esram12_ret {
-					regulator-name = "db8500-esram12-ret";
-				};
-
-				db8500_esram34_reg: db8500_esram34 {
-					regulator-name = "db8500-esram34";
-				};
-
-				db8500_esram34_ret_reg: db8500_esram34_ret {
-					regulator-name = "db8500-esram34-ret";
-				};
-			};
-
 			ab8500 {
 				ab8500-regulators {
 					ab8500_ldo_aux1_reg: ab8500_ldo_aux1 {
diff --git a/arch/arm/boot/dts/ste-hrefv60plus.dts b/arch/arm/boot/dts/ste-hrefv60plus.dts
index 6e52ebb..0e2be7a 100644
--- a/arch/arm/boot/dts/ste-hrefv60plus.dts
+++ b/arch/arm/boot/dts/ste-hrefv60plus.dts
@@ -76,88 +76,6 @@
 		};
 
 		prcmu at 80157000 {
-			db8500-prcmu-regulators {
-				db8500_vape_reg: db8500_vape {
-					regulator-name = "db8500-vape";
-				};
-
-				db8500_varm_reg: db8500_varm {
-					regulator-name = "db8500-varm";
-				};
-
-				db8500_vmodem_reg: db8500_vmodem {
-					regulator-name = "db8500-vmodem";
-				};
-
-				db8500_vpll_reg: db8500_vpll {
-					regulator-name = "db8500-vpll";
-				};
-
-				db8500_vsmps1_reg: db8500_vsmps1 {
-					regulator-name = "db8500-vsmps1";
-				};
-
-				db8500_vsmps2_reg: db8500_vsmps2 {
-					regulator-name = "db8500-vsmps2";
-				};
-
-				db8500_vsmps3_reg: db8500_vsmps3 {
-					regulator-name = "db8500-vsmps3";
-				};
-
-				db8500_vrf1_reg: db8500_vrf1 {
-					regulator-name = "db8500-vrf1";
-				};
-
-				db8500_sva_mmdsp_reg: db8500_sva_mmdsp {
-					regulator-name = "db8500-sva-mmdsp";
-				};
-
-				db8500_sva_mmdsp_ret_reg: db8500_sva_mmdsp_ret {
-					regulator-name = "db8500-sva-mmdsp-ret";
-				};
-
-				db8500_sva_pipe_reg: db8500_sva_pipe {
-					regulator-name = "db8500_sva_pipe";
-				};
-
-				db8500_sia_mmdsp_reg: db8500_sia_mmdsp {
-					regulator-name = "db8500_sia_mmdsp";
-				};
-
-				db8500_sia_mmdsp_ret_reg: db8500_sia_mmdsp_ret {
-					regulator-name = "db8500-sia-mmdsp-ret";
-				};
-
-				db8500_sia_pipe_reg: db8500_sia_pipe {
-					regulator-name = "db8500-sia-pipe";
-				};
-
-				db8500_sga_reg: db8500_sga {
-					regulator-name = "db8500-sga";
-				};
-
-				db8500_b2r2_mcde_reg: db8500_b2r2_mcde {
-					regulator-name = "db8500-b2r2-mcde";
-				};
-
-				db8500_esram12_reg: db8500_esram12 {
-					regulator-name = "db8500-esram12";
-				};
-
-				db8500_esram12_ret_reg: db8500_esram12_ret {
-					regulator-name = "db8500-esram12-ret";
-				};
-
-				db8500_esram34_reg: db8500_esram34 {
-					regulator-name = "db8500-esram34";
-				};
-
-				db8500_esram34_ret_reg: db8500_esram34_ret {
-					regulator-name = "db8500-esram34-ret";
-				};
-			};
-
 			ab8500 {
 				ab8500-regulators {
 					ab8500_ldo_aux1_reg: ab8500_ldo_aux1 {
diff --git a/arch/arm/boot/dts/ste-snowball.dts b/arch/arm/boot/dts/ste-snowball.dts
index f1fc128..acf99ec 100644
--- a/arch/arm/boot/dts/ste-snowball.dts
+++ b/arch/arm/boot/dts/ste-snowball.dts
@@ -170,88 +170,6 @@
 		};
 
 		prcmu at 80157000 {
-			db8500-prcmu-regulators {
-				db8500_vape_reg: db8500_vape {
-					regulator-name = "db8500-vape";
-				};
-
-				db8500_varm_reg: db8500_varm {
-					regulator-name = "db8500-varm";
-				};
-
-				db8500_vmodem_reg: db8500_vmodem {
-					regulator-name = "db8500-vmodem";
-				};
-
-				db8500_vpll_reg: db8500_vpll {
-					regulator-name = "db8500-vpll";
-				};
-
-				db8500_vsmps1_reg: db8500_vsmps1 {
-					regulator-name = "db8500-vsmps1";
-				};
-
-				db8500_vsmps2_reg: db8500_vsmps2 {
-					regulator-name = "db8500-vsmps2";
-				};
-
-				db8500_vsmps3_reg: db8500_vsmps3 {
-					regulator-name = "db8500-vsmps3";
-				};
-
-				db8500_vrf1_reg: db8500_vrf1 {
-					regulator-name = "db8500-vrf1";
-				};
-
-				db8500_sva_mmdsp_reg: db8500_sva_mmdsp {
-					regulator-name = "db8500-sva-mmdsp";
-				};
-
-				db8500_sva_mmdsp_ret_reg: db8500_sva_mmdsp_ret {
-					regulator-name = "db8500-sva-mmdsp-ret";
-				};
-
-				db8500_sva_pipe_reg: db8500_sva_pipe {
-					regulator-name = "db8500_sva_pipe";
-				};
-
-				db8500_sia_mmdsp_reg: db8500_sia_mmdsp {
-					regulator-name = "db8500_sia_mmdsp";
-				};
-
-				db8500_sia_mmdsp_ret_reg: db8500_sia_mmdsp_ret {
-					regulator-name = "db8500-sia-mmdsp-ret";
-				};
-
-				db8500_sia_pipe_reg: db8500_sia_pipe {
-					regulator-name = "db8500-sia-pipe";
-				};
-
-				db8500_sga_reg: db8500_sga {
-					regulator-name = "db8500-sga";
-				};
-
-				db8500_b2r2_mcde_reg: db8500_b2r2_mcde {
-					regulator-name = "db8500-b2r2-mcde";
-				};
-
-				db8500_esram12_reg: db8500_esram12 {
-					regulator-name = "db8500-esram12";
-				};
-
-				db8500_esram12_ret_reg: db8500_esram12_ret {
-					regulator-name = "db8500-esram12-ret";
-				};
-
-				db8500_esram34_reg: db8500_esram34 {
-					regulator-name = "db8500-esram34";
-				};
-
-				db8500_esram34_ret_reg: db8500_esram34_ret {
-					regulator-name = "db8500-esram34-ret";
-				};
-			};
-
 			thermal at 801573c0 {
 				num-trips = <4>;
 
-- 
1.8.3.1
