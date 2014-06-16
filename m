From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Mon, 16 Jun 2014 17:07:24 +0200
Subject: [PATCH v4 12/19] ARM: shmobile: r8a7790: Add CMT devices to DT
In-Reply-To: <1402931251-22581-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1402931251-22581-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <1402931251-22581-13-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the CMT0 and CMT1 counters to the r8a7790 device tree and make them
disabled by default.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Tested-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790.dtsi | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 994330e..1a0553a 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -206,6 +206,38 @@
 			     <1 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
 	};
 
+	cmt0: timer at ffca0000 {
+		compatible = "renesas,cmt-48-gen2";
+		reg = <0 0xffca0000 0 0x1004>;
+		interrupts = <0 142 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 143 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp1_clks R8A7790_CLK_CMT0>;
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
+		clocks = <&mstp3_clks R8A7790_CLK_CMT1>;
+		clock-names = "fck";
+
+		renesas,channels-mask = <0xff>;
+
+		status = "disabled";
+	};
+
 	irqc0: interrupt-controller at e61c0000 {
 		compatible = "renesas,irqc-r8a7790", "renesas,irqc";
 		#interrupt-cells = <2>;
-- 
1.8.5.5
