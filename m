From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 30 May 2012 12:47:30 +0800
Subject: [PATCH 12/22] ARM: ux500: Apply db8500-prcmu regulator information to
 db8500 Device Tree
In-Reply-To: <1338353260-10097-1-git-send-email-lee.jones@linaro.org>
References: <1338353260-10097-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1338353260-10097-13-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here we inform Device Tree of which regulators are provided by the db8500-
prcmu. This way we can reference some of their consumers directly from the
Device Tree e.g. SMSC911x Ethernet chip.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/db8500.dtsi |  107 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 107 insertions(+)

diff --git a/arch/arm/boot/dts/db8500.dtsi b/arch/arm/boot/dts/db8500.dtsi
index 7070000..646c80b 100644
--- a/arch/arm/boot/dts/db8500.dtsi
+++ b/arch/arm/boot/dts/db8500.dtsi
@@ -197,6 +197,113 @@
 				reg = <0x80157450 0xC>;
 			};
 
+			db8500-prcmu-regulators {
+				compatible = "stericsson,db8500-prcmu-regulator";
+
+				// DB8500_REGULATOR_VAPE
+				db8500_vape_reg: db8500_vape {
+					regulator-name = "db8500-vape";
+					regulator-always-on;
+				};
+
+				// DB8500_REGULATOR_VARM
+				db8500_varm_reg: db8500_varm {
+					regulator-name = "db8500-varm";
+				};
+
+				// DB8500_REGULATOR_VMODEM
+				db8500_vmodem_reg: db8500_vmodem {
+					regulator-name = "db8500-vmodem";
+				};
+
+				// DB8500_REGULATOR_VPLL
+				db8500_vpll_reg: db8500_vpll {
+					regulator-name = "db8500-vpll";
+				};
+
+				// DB8500_REGULATOR_VSMPS1
+				db8500_vsmps1_reg: db8500_vsmps1 {
+					regulator-name = "db8500-vsmps1";
+				};
+
+				// DB8500_REGULATOR_VSMPS2
+				db8500_vsmps2_reg: db8500_vsmps2 {
+					regulator-name = "db8500-vsmps2";
+				};
+
+				// DB8500_REGULATOR_VSMPS3
+				db8500_vsmps3_reg: db8500_vsmps3 {
+					regulator-name = "db8500-vsmps3";
+				};
+
+				// DB8500_REGULATOR_VRF1
+				db8500_vrf1_reg: db8500_vrf1 {
+					regulator-name = "db8500-vrf1";
+				};
+
+				// DB8500_REGULATOR_SWITCH_SVAMMDSP
+				db8500_sva_mmdsp_reg: db8500_sva_mmdsp {
+					regulator-name = "db8500-sva-mmdsp";
+				};
+
+				// DB8500_REGULATOR_SWITCH_SVAMMDSPRET
+				db8500_sva_mmdsp_ret_reg: db8500_sva_mmdsp_ret {
+					regulator-name = "db8500-sva-mmdsp-ret";
+				};
+
+				// DB8500_REGULATOR_SWITCH_SVAPIPE
+				db8500_sva_pipe_reg: db8500_sva_pipe {
+					regulator-name = "db8500_sva_pipe";
+				};
+
+				// DB8500_REGULATOR_SWITCH_SIAMMDSP
+				db8500_sia_mmdsp_reg: db8500_sia_mmdsp {
+					regulator-name = "db8500_sia_mmdsp";
+				};
+
+				// DB8500_REGULATOR_SWITCH_SIAMMDSPRET
+				db8500_sia_mmdsp_ret_reg: db8500_sia_mmdsp_ret {
+					regulator-name = "db8500-sia-mmdsp-ret";
+				};
+
+				// DB8500_REGULATOR_SWITCH_SIAPIPE
+				db8500_sia_pipe_reg: db8500_sia_pipe {
+					regulator-name = "db8500-sia-pipe";
+				};
+
+				// DB8500_REGULATOR_SWITCH_SGA
+				db8500_sga_reg: db8500_sga {
+					regulator-name = "db8500-sga";
+					vin-supply = <&db8500_vape_reg>;
+				};
+
+				// DB8500_REGULATOR_SWITCH_B2R2_MCDE
+				db8500_b2r2_mcde_reg: db8500_b2r2_mcde {
+					regulator-name = "db8500-b2r2-mcde";
+					vin-supply = <&db8500_vape_reg>;
+				};
+
+				// DB8500_REGULATOR_SWITCH_ESRAM12
+				db8500_esram12_reg: db8500_esram12 {
+					regulator-name = "db8500-esram12";
+				};
+
+				// DB8500_REGULATOR_SWITCH_ESRAM12RET
+				db8500_esram12_ret_reg: db8500_esram12_ret {
+					regulator-name = "db8500-esram12-ret";
+				};
+
+				// DB8500_REGULATOR_SWITCH_ESRAM34
+				db8500_esram34_reg: db8500_esram34 {
+					regulator-name = "db8500-esram34";
+				};
+
+				// DB8500_REGULATOR_SWITCH_ESRAM34RET
+				db8500_esram34_ret_reg: db8500_esram34_ret {
+					regulator-name = "db8500-esram34-ret";
+				};
+			};
+
 			ab8500 at 5 {
 				compatible = "stericsson,ab8500";
 				reg = <5>; /* mailbox 5 is i2c */
-- 
1.7.9.5
