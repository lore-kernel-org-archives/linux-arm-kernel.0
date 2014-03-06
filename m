From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  6 Mar 2014 13:44:34 +0900
Subject: [PATCH 6/7] ARM: shmobile: Add SDHI devices to r8a7791 DTSI
In-Reply-To: <cover.1394080829.git.horms+renesas@verge.net.au>
References: <cover.1394080829.git.horms+renesas@verge.net.au>
Message-ID: <b7ed8a0dd4f1d41464c3ab050c3688c4a7fc15b3.1394080829.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add SDHI0, SDHI1 and SDHI2 to the r8a7791 DTSI.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791.dtsi | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 0852734..b007f9e 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -246,6 +246,33 @@
 		#gpio-range-cells = <3>;
 	};
 
+	sdhi0: sd at ee100000 {
+		compatible = "renesas,sdhi-r8a7791";
+		reg = <0 0xee100000 0 0x200>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 165 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A7791_CLK_SDHI0>;
+		status = "disabled";
+	};
+
+	sdhi1: sd at ee140000 {
+		compatible = "renesas,sdhi-r8a7791";
+		reg = <0 0xee140000 0 0x100>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 167 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A7791_CLK_SDHI1>;
+		status = "disabled";
+	};
+
+	sdhi2: sd at ee160000 {
+		compatible = "renesas,sdhi-r8a7791";
+		reg = <0 0xee160000 0 0x100>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 168 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A7791_CLK_SDHI2>;
+		status = "disabled";
+	};
+
 	scifa0: serial at e6c40000 {
 		compatible = "renesas,scifa-r8a7791", "renesas,scifa";
 		reg = <0 0xe6c40000 0 64>;
-- 
1.8.5.2
