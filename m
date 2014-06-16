From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Mon, 16 Jun 2014 17:07:26 +0200
Subject: [PATCH v4 14/19] ARM: shmobile: r8a7779: Add TMU devices to DT
In-Reply-To: <1402931251-22581-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1402931251-22581-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <1402931251-22581-15-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the TMU0, TMU1 and TMU2 counters to the r8a7779 device tree and make
them disabled by default.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/r8a7779.dtsi | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
index 94e2fc8..671d8e4 100644
--- a/arch/arm/boot/dts/r8a7779.dtsi
+++ b/arch/arm/boot/dts/r8a7779.dtsi
@@ -266,6 +266,48 @@
 		reg = <0xffc48000 0x38>;
 	};
 
+	tmu0: timer at ffd80000 {
+		compatible = "renesas,tmu";
+		reg = <0xffd80000 0x30>;
+		interrupts = <0 32 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 33 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 34 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp0_clks R8A7779_CLK_TMU0>;
+		clock-names = "fck";
+
+		#renesas,channels = <3>;
+
+		status = "disabled";
+	};
+
+	tmu1: timer at ffd81000 {
+		compatible = "renesas,tmu";
+		reg = <0xffd81000 0x30>;
+		interrupts = <0 36 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 37 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 38 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp0_clks R8A7779_CLK_TMU1>;
+		clock-names = "fck";
+
+		#renesas,channels = <3>;
+
+		status = "disabled";
+	};
+
+	tmu2: timer at ffd82000 {
+		compatible = "renesas,tmu";
+		reg = <0xffd82000 0x30>;
+		interrupts = <0 40 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 41 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 42 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp0_clks R8A7779_CLK_TMU2>;
+		clock-names = "fck";
+
+		#renesas,channels = <3>;
+
+		status = "disabled";
+	};
+
 	sata: sata at fc600000 {
 		compatible = "renesas,rcar-sata";
 		reg = <0xfc600000 0x2000>;
-- 
1.8.5.5
