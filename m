From: dinguyen@altera.com (dinguyen at altera.com)
Date: Wed, 20 Nov 2013 10:21:14 -0600
Subject: [PATCH] clk: socfpga: Correct the parent clock for l3_sp_clk and
 dbg_clk
Message-ID: <1384964474-2848-1-git-send-email-dinguyen@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@altera.com>

The l3_sp_clk's parent should be the l3_mp_clk. This will account for
the extra divider that is present for the l3_mp_clk.

The dbg_clk's parent should be the dbg_at_clk. This will account for
the extra divider that is present for the dbg_at_clk.

Reported-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: Mike Turquette <mturquette@linaro.org>
Cc: linux-arm-kernel at lists.infradead.org
---
 arch/arm/boot/dts/socfpga.dtsi |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index 6d09b8d..2c10bed 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -281,7 +281,7 @@
 					l3_sp_clk: l3_sp_clk {
 						#clock-cells = <0>;
 						compatible = "altr,socfpga-gate-clk";
-						clocks = <&mainclk>;
+						clocks = <&l3_mp_clk>;
 						div-reg = <0x64 2 2>;
 					};
 
@@ -312,7 +312,7 @@
 					dbg_clk: dbg_clk {
 						#clock-cells = <0>;
 						compatible = "altr,socfpga-gate-clk";
-						clocks = <&dbg_base_clk>;
+						clocks = <&dbg_at_clk>;
 						div-reg = <0x68 2 2>;
 						clk-gate = <0x60 5>;
 					};
-- 
1.7.9.5
