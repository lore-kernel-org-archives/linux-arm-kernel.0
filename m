From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Wed, 11 Sep 2013 10:34:11 +0200
Subject: [PATCH 3/3] ARM: socfpga: dts: fix s2f_* clock name
In-Reply-To: <1378888451-28096-1-git-send-email-s.trumtrar@pengutronix.de>
References: <1378888451-28096-1-git-send-email-s.trumtrar@pengutronix.de>
Message-ID: <1378888451-28096-4-git-send-email-s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The s2f_* clocks are called h2f_* in the datasheets.
Rename them accordingly in the socfpga.dtsi.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 arch/arm/boot/dts/socfpga.dtsi | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index 587096e..e245924 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -147,7 +147,7 @@
 							reg = <0x58>;
 						};
 
-						cfg_s2f_usr0_clk: cfg_s2f_usr0_clk {
+						cfg_h2f_usr0_clk: cfg_h2f_usr0_clk {
 							#clock-cells = <0>;
 							compatible = "altr,socfpga-perip-clk";
 							clocks = <&main_pll>;
@@ -198,7 +198,7 @@
 							reg = <0x98>;
 						};
 
-						s2f_usr1_clk: s2f_usr1_clk {
+						h2f_usr1_clk: h2f_usr1_clk {
 							#clock-cells = <0>;
 							compatible = "altr,socfpga-perip-clk";
 							clocks = <&periph_pll>;
@@ -235,7 +235,7 @@
 							reg = <0xD0>;
 						};
 
-						s2f_usr2_clk: s2f_usr2_clk {
+						h2f_usr2_clk: h2f_usr2_clk {
 							#clock-cells = <0>;
 							compatible = "altr,socfpga-perip-clk";
 							clocks = <&sdram_pll>;
@@ -335,14 +335,14 @@
 					cfg_clk: cfg_clk {
 						#clock-cells = <0>;
 						compatible = "altr,socfpga-gate-clk";
-						clocks = <&cfg_s2f_usr0_clk>;
+						clocks = <&cfg_h2f_usr0_clk>;
 						clk-gate = <0x60 8>;
 					};
 
-					s2f_user0_clk: s2f_user0_clk {
+					h2f_user0_clk: h2f_user0_clk {
 						#clock-cells = <0>;
 						compatible = "altr,socfpga-gate-clk";
-						clocks = <&cfg_s2f_usr0_clk>;
+						clocks = <&cfg_h2f_usr0_clk>;
 						clk-gate = <0x60 9>;
 					};
 
@@ -400,10 +400,10 @@
 						div-reg = <0xa8 0 24>;
 					};
 
-					s2f_user1_clk: s2f_user1_clk {
+					h2f_user1_clk: h2f_user1_clk {
 						#clock-cells = <0>;
 						compatible = "altr,socfpga-gate-clk";
-						clocks = <&s2f_usr1_clk>;
+						clocks = <&h2f_usr1_clk>;
 						clk-gate = <0xa0 7>;
 					};
 
-- 
1.8.4.rc3
