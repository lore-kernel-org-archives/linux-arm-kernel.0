From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  4 Nov 2014 10:50:45 +0900
Subject: [PATCH 15/34] ARM: shmobile: r8a7740 dtsi: Add TMU0 and TMU1 device
 nodes
In-Reply-To: <cover.1415059587.git.horms+renesas@verge.net.au>
References: <cover.1415059587.git.horms+renesas@verge.net.au>
Message-ID: <600363334de89169a8dbbb1db874777d46fc239e.1415059587.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7740.dtsi | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7740.dtsi b/arch/arm/boot/dts/r8a7740.dtsi
index 559bd39..aec8da8 100644
--- a/arch/arm/boot/dts/r8a7740.dtsi
+++ b/arch/arm/boot/dts/r8a7740.dtsi
@@ -335,6 +335,34 @@
 		status = "disabled";
 	};
 
+	tmu0: timer at fff80000 {
+		compatible = "renesas,tmu-r8a7740", "renesas,tmu";
+		reg = <0xfff80000 0x2c>;
+		interrupts = <0 198 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 199 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 200 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp1_clks R8A7740_CLK_TMU0>;
+		clock-names = "fck";
+
+		#renesas,channels = <3>;
+
+		status = "disabled";
+	};
+
+	tmu1: timer at fff90000 {
+		compatible = "renesas,tmu-r8a7740", "renesas,tmu";
+		reg = <0xfff90000 0x2c>;
+		interrupts = <0 170 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 171 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 172 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp1_clks R8A7740_CLK_TMU1>;
+		clock-names = "fck";
+
+		#renesas,channels = <3>;
+
+		status = "disabled";
+	};
+
 	clocks {
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
2.1.1
