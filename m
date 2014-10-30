From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 30 Oct 2014 14:57:23 +0900
Subject: [PATCH/RFC] ARM: shmobile: r8a7790: Add SDHI clock rate to device tree
Message-ID: <1414648643-30818-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shinobu Uehara <shinobu.uehara.xc@renesas.com>

Signed-off-by: Shinobu Uehara <shinobu.uehara.xc@renesas.com>
[simon: rebase]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
Based on the renesas-devel-20141030-v3.18-rc2 branch of my renesas tree

If this is useful I wonder if it is should be set in the lager board DTS file
instead of the r8a7790 SoC DTSI file.

 arch/arm/boot/dts/r8a7790.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 69b7cd0..c6bd1e5 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -424,6 +424,7 @@
 		reg = <0 0xee100000 0 0x200>;
 		interrupts = <0 165 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7790_CLK_SDHI0>;
+		renesas,clk-rate = <195000000>;
 		status = "disabled";
 	};
 
@@ -432,6 +433,7 @@
 		reg = <0 0xee120000 0 0x200>;
 		interrupts = <0 166 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7790_CLK_SDHI1>;
+		renesas,clk-rate = <195000000>;
 		status = "disabled";
 	};
 
@@ -440,6 +442,7 @@
 		reg = <0 0xee140000 0 0x100>;
 		interrupts = <0 167 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7790_CLK_SDHI2>;
+		renesas,clk-rate = <97500000>;
 		status = "disabled";
 	};
 
@@ -448,6 +451,7 @@
 		reg = <0 0xee160000 0 0x100>;
 		interrupts = <0 168 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7790_CLK_SDHI3>;
+		renesas,clk-rate = <97500000>;
 		status = "disabled";
 	};
 
-- 
2.1.1
