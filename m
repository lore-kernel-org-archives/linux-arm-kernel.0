From: dinguyen@opensource.altera.com (dinguyen at opensource.altera.com)
Date: Wed, 22 Jul 2015 22:30:05 -0500
Subject: [PATCH 1/3] ARM: socfpga: dts: Correct the parent clock for l3_sp_clk
 and dbg_clk
Message-ID: <1437622207-1760-1-git-send-email-dinguyen@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@opensource.altera.com>

The l3_sp_clk's parent should be the l3_mp_clk. This will account for
the extra divider that is present for the l3_mp_clk.

The dbg_clk's parent should be the dbg_at_clk. This will account for
the extra divider that is present for the dbg_at_clk.

Signed-off-by: Dinh Nguyen <dinguyen@opensource.altera.com>
---
 arch/arm/boot/dts/socfpga.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index 1e3c833..7860935 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -318,7 +318,7 @@
 					l3_sp_clk: l3_sp_clk {
 						#clock-cells = <0>;
 						compatible = "altr,socfpga-gate-clk";
-						clocks = <&mainclk>;
+						clocks = <&l3_mp_clk>;
 						div-reg = <0x64 2 2>;
 					};
 
@@ -349,7 +349,7 @@
 					dbg_clk: dbg_clk {
 						#clock-cells = <0>;
 						compatible = "altr,socfpga-gate-clk";
-						clocks = <&dbg_base_clk>;
+						clocks = <&dbg_at_clk>;
 						div-reg = <0x68 2 2>;
 						clk-gate = <0x60 5>;
 					};
-- 
2.4.5
