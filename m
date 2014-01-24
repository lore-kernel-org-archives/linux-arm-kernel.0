From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 24 Jan 2014 10:14:37 +0900
Subject: [PATCH] ARM: shmobile: r8a7790.dtsi: ficx i2c[0-3] clock reference
In-Reply-To: <cover.1390525593.git.horms+renesas@verge.net.au>
References: <cover.1390525593.git.horms+renesas@verge.net.au>
Message-ID: <2450badfc19b67340d3570665cc02a22df03dfab.1390525593.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ben Dooks <ben.dooks@codethink.co.uk>

The R8A7790's dtsi file i2c0, i2c1, i2c2, and i2c3 nodes have clock
references to the mstp3_clks clock node, however these clocks are in the
mstp9_clks node.

The error was introducted in 72197ca7a1cb1cea5 ("ARM: shmobile: r8a7790:
 Reference clocks") which is in Simon's current development tree.

This patch fixes the following error:

of_clk_src_onecell_get: invalid clock index 31
i2c-rcar e6508000.i2c: cannot get clock
i2c-rcar: probe of e6508000.i2c failed with error -2

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index a179125..46ac214 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -197,7 +197,7 @@
 		reg = <0 0xe6508000 0 0x40>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 287 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp3_clks R8A7790_CLK_I2C0>;
+		clocks = <&mstp9_clks R8A7790_CLK_I2C0>;
 		status = "disabled";
 	};
 
@@ -208,7 +208,7 @@
 		reg = <0 0xe6518000 0 0x40>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 288 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp3_clks R8A7790_CLK_I2C1>;
+		clocks = <&mstp9_clks R8A7790_CLK_I2C1>;
 		status = "disabled";
 	};
 
@@ -219,7 +219,7 @@
 		reg = <0 0xe6530000 0 0x40>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 286 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp3_clks R8A7790_CLK_I2C2>;
+		clocks = <&mstp9_clks R8A7790_CLK_I2C2>;
 		status = "disabled";
 	};
 
@@ -230,7 +230,7 @@
 		reg = <0 0xe6540000 0 0x40>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 290 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp3_clks R8A7790_CLK_I2C3>;
+		clocks = <&mstp9_clks R8A7790_CLK_I2C3>;
 		status = "disabled";
 	};
 
-- 
1.8.4
