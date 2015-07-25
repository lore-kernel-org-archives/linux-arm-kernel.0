From: dinguyen@opensource.altera.com (dinguyen at opensource.altera.com)
Date: Fri, 24 Jul 2015 22:18:46 -0500
Subject: [PATCH] ARM: socfpga: dts: add osc1 as a possible parent for
 dbg_base_clk
Message-ID: <1437794326-26317-1-git-send-email-dinguyen@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@opensource.altera.com>

The dbg_base_clk can also have osc1 has a parent.

Signed-off-by: Dinh Nguyen <dinguyen@opensource.altera.com>
---
 arch/arm/boot/dts/socfpga.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index 86e0fb6..01bdaaa 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -164,7 +164,7 @@
 						dbg_base_clk: dbg_base_clk {
 							#clock-cells = <0>;
 							compatible = "altr,socfpga-perip-clk";
-							clocks = <&main_pll>;
+							clocks = <&main_pll>, <&osc1>;
 							div-reg = <0xe8 0 9>;
 							reg = <0x50>;
 						};
-- 
2.4.5
