From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 17 Jul 2014 09:40:29 +0900
Subject: [PATCH 2/8] ARM: shmobile: r8a7791: Add CMT devices to DT
In-Reply-To: <cover.1405556312.git.horms+renesas@verge.net.au>
References: <cover.1405556312.git.horms+renesas@verge.net.au>
Message-ID: <c25af2c1e70dd5885e4e71b51ae6a9d1530bb251.1405556312.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Add the CMT0 and CMT1 counters to the r8a7791 device tree and make them
disabled by default.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Tested-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791.dtsi | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 6e9a556..56841d3 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -189,6 +189,38 @@
 			     <1 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
 	};
 
+	cmt0: timer at ffca0000 {
+		compatible = "renesas,cmt-48-gen2";
+		reg = <0 0xffca0000 0 0x1004>;
+		interrupts = <0 142 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 143 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp1_clks R8A7791_CLK_CMT0>;
+		clock-names = "fck";
+
+		renesas,channels-mask = <0x60>;
+
+		status = "disabled";
+	};
+
+	cmt1: timer at e6130000 {
+		compatible = "renesas,cmt-48-gen2";
+		reg = <0 0xe6130000 0 0x1004>;
+		interrupts = <0 120 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 121 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 122 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 123 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 124 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 125 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 126 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 127 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A7791_CLK_CMT1>;
+		clock-names = "fck";
+
+		renesas,channels-mask = <0xff>;
+
+		status = "disabled";
+	};
+
 	irqc0: interrupt-controller at e61c0000 {
 		compatible = "renesas,irqc-r8a7791", "renesas,irqc";
 		#interrupt-cells = <2>;
-- 
2.0.0
