From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Fri, 14 Feb 2014 02:00:02 +0100
Subject: [PATCH 24/27] ARM: shmobile: r8a7790: Add CMT devices to DT
In-Reply-To: <1392339605-20691-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1392339605-20691-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <1392339605-20691-25-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/r8a7790.dtsi | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 54ab318..a236c7e 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -179,6 +179,44 @@
 			     <1 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
 	};
 
+	cmt0: timer at ffca0000 {
+		compatible = "renesas,cmt-48-gen2";
+		reg = <0 0xffca0000 0 0x1004>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 142 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 142 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp1_clks R8A7790_CLK_CMT0>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		renesas,channels-mask = <0x60>;
+
+		status = "disabled";
+	};
+
+	cmt1: timer at e6130000 {
+		compatible = "renesas,cmt-48-gen2";
+		reg = <0 0xe6130000 0 0x1004>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 120 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 121 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 122 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 123 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 124 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 125 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 126 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 127 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A7790_CLK_CMT1>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
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
1.8.3.2
