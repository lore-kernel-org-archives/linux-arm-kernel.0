From: dinguyen@opensource.altera.com (dinguyen at opensource.altera.com)
Date: Wed, 22 Jul 2015 22:30:07 -0500
Subject: [PATCH 3/3] ARM: socfpga: dts: add missing clock gates to socfpga.dtsi
In-Reply-To: <1437622207-1760-1-git-send-email-dinguyen@opensource.altera.com>
References: <1437622207-1760-1-git-send-email-dinguyen@opensource.altera.com>
Message-ID: <1437622207-1760-3-git-send-email-dinguyen@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Matthew Gerlach <mgerlach@opensource.altera.com>

The gates for the clocks coming out of the sdram pll
were missing.  The change adds the missing nodes to
the device tree.

Signed-off-by: Matthew Gerlach <mgerlach@opensource.altera.com>
Signed-off-by: Dinh Nguyen <dinguyen@opensource.altera.com>
---
 arch/arm/boot/dts/socfpga.dtsi | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index b0acaec..86e0fb6 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -481,8 +481,37 @@
 						clocks = <&f2s_periph_ref_clk>, <&main_qspi_clk>, <&per_qspi_clk>;
 						clk-gate = <0xa0 11>;
 					};
+
+					ddr_dqs_clk_gate: ddr_dqs_clk_gate {
+						#clock-cells = <0>;
+						compatible = "altr,socfpga-gate-clk";
+						clocks = <&ddr_dqs_clk>;
+						clk-gate = <0xd8 0>;
+					};
+
+					ddr_2x_dqs_clk_gate: ddr_2x_dqs_clk_gate {
+						#clock-cells = <0>;
+						compatible = "altr,socfpga-gate-clk";
+						clocks = <&ddr_2x_dqs_clk>;
+						clk-gate = <0xd8 1>;
+					};
+
+					ddr_dq_clk_gate: ddr_dq_clk_gate {
+						#clock-cells = <0>;
+						compatible = "altr,socfpga-gate-clk";
+						clocks = <&ddr_dq_clk>;
+						clk-gate = <0xd8 2>;
+					};
+
+					h2f_user2_clk: h2f_user2_clk {
+						#clock-cells = <0>;
+						compatible = "altr,socfpga-gate-clk";
+						clocks = <&h2f_usr2_clk>;
+						clk-gate = <0xd8 3>;
+					};
+
 				};
-			};
+		};
 
 		gmac0: ethernet at ff700000 {
 			compatible = "altr,socfpga-stmmac", "snps,dwmac-3.70a", "snps,dwmac";
-- 
2.4.5
