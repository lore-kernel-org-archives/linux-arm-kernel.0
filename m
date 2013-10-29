From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Tue, 29 Oct 2013 16:23:12 +0100
Subject: [PATCH 2/3] ARM: shmobile: r8a7790: Add serial ports to the device
 tree
In-Reply-To: <1383060193-1505-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1383060193-1505-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <1383060193-1505-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The platform code serial port instantiation mechanism is kept for the
non-DT platforms only.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/r8a7790.dtsi         | 100 +++++++++++++++++++++++++++++++++
 arch/arm/mach-shmobile/setup-r8a7790.c |  12 ++--
 2 files changed, 106 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 94c8373..04a4992 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -287,6 +287,106 @@
 		status = "disabled";
 	};
 
+	scifa0: serial at e6c40000 {
+		compatible = "renesas,scifa-r8a7790", "renesas,scifa-generic";
+		reg = <0 0xe6c40000 0 64>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 144 4>;
+		clocks = <&mstp2_clks R8A7790_CLK_SCIFA0>;
+		clock-names = "sci_ick";
+		status = "disabled";
+	};
+
+	scifa1: serial at e6c50000 {
+		compatible = "renesas,scifa-r8a7790", "renesas,scifa-generic";
+		interrupt-parent = <&gic>;
+		reg = <0 0xe6c50000 0 64>;
+		interrupts = <0 145 4>;
+		clocks = <&mstp2_clks R8A7790_CLK_SCIFA1>;
+		clock-names = "sci_ick";
+		status = "disabled";
+	};
+
+	scifa2: serial at e6c60000 {
+		compatible = "renesas,scifa-r8a7790", "renesas,scifa-generic";
+		interrupt-parent = <&gic>;
+		reg = <0 0xe6c60000 0 64>;
+		interrupts = <0 151 4>;
+		clocks = <&mstp2_clks R8A7790_CLK_SCIFA2>;
+		clock-names = "sci_ick";
+		status = "disabled";
+	};
+
+	scifb0: serial at e6c20000 {
+		compatible = "renesas,scifb-r8a7790", "renesas,scifb-generic";
+		interrupt-parent = <&gic>;
+		reg = <0 0xe6c20000 0 64>;
+		interrupts = <0 148 4>;
+		clocks = <&mstp2_clks R8A7790_CLK_SCIFB0>;
+		clock-names = "sci_ick";
+		status = "disabled";
+	};
+
+	scifb1: serial at e6c30000 {
+		compatible = "renesas,scifb-r8a7790", "renesas,scifb-generic";
+		interrupt-parent = <&gic>;
+		reg = <0 0xe6c30000 0 64>;
+		interrupts = <0 149 4>;
+		clocks = <&mstp2_clks R8A7790_CLK_SCIFB1>;
+		clock-names = "sci_ick";
+		status = "disabled";
+	};
+
+	scifb2: serial at e6ce0000 {
+		compatible = "renesas,scifb-r8a7790", "renesas,scifb-generic";
+		interrupt-parent = <&gic>;
+		reg = <0 0xe6ce0000 0 64>;
+		interrupts = <0 150 4>;
+		clocks = <&mstp2_clks R8A7790_CLK_SCIFB2>;
+		clock-names = "sci_ick";
+		status = "disabled";
+	};
+
+	scif0: serial at e6e60000 {
+		compatible = "renesas,scif-r8a7790", "renesas,scif-generic";
+		interrupt-parent = <&gic>;
+		reg = <0 0xe6e60000 0 64>;
+		interrupts = <0 152 4>;
+		clocks = <&mstp7_clks R8A7790_CLK_SCIF0>;
+		clock-names = "sci_ick";
+		status = "disabled";
+	};
+
+	scif1: serial at e6e68000 {
+		compatible = "renesas,scif-r8a7790", "renesas,scif-generic";
+		interrupt-parent = <&gic>;
+		reg = <0 0xe6e68000 0 64>;
+		interrupts = <0 153 4>;
+		clocks = <&mstp7_clks R8A7790_CLK_SCIF1>;
+		clock-names = "sci_ick";
+		status = "disabled";
+	};
+
+	hscif0: serial at e62c0000 {
+		compatible = "renesas,hscif-r8a7790", "renesas,hscif-generic";
+		interrupt-parent = <&gic>;
+		reg = <0 0xe62c0000 0 96>;
+		interrupts = <0 154 4>;
+		clocks = <&mstp7_clks R8A7790_CLK_HSCIF0>;
+		clock-names = "sci_ick";
+		status = "disabled";
+	};
+
+	hscif1: serial at e62c8000 {
+		compatible = "renesas,hscif-r8a7790", "renesas,hscif-generic";
+		interrupt-parent = <&gic>;
+		reg = <0 0xe62c8000 0 96>;
+		interrupts = <0 155 4>;
+		clocks = <&mstp7_clks R8A7790_CLK_HSCIF1>;
+		clock-names = "sci_ick";
+		status = "disabled";
+	};
+
 	clocks {
 		#address-cells = <2>;
 		#size-cells = <2>;
diff --git a/arch/arm/mach-shmobile/setup-r8a7790.c b/arch/arm/mach-shmobile/setup-r8a7790.c
index c47bceb..8172a82 100644
--- a/arch/arm/mach-shmobile/setup-r8a7790.c
+++ b/arch/arm/mach-shmobile/setup-r8a7790.c
@@ -182,6 +182,12 @@ static const struct resource cmt00_resources[] __initconst = {
 
 void __init r8a7790_add_dt_devices(void)
 {
+	r8a7790_register_cmt(00);
+}
+
+void __init r8a7790_add_standard_devices(void)
+{
+	r8a7790_add_dt_devices();
 	r8a7790_register_scif(SCIFA0);
 	r8a7790_register_scif(SCIFA1);
 	r8a7790_register_scif(SCIFB0);
@@ -192,12 +198,6 @@ void __init r8a7790_add_dt_devices(void)
 	r8a7790_register_scif(SCIF1);
 	r8a7790_register_scif(HSCIF0);
 	r8a7790_register_scif(HSCIF1);
-	r8a7790_register_cmt(00);
-}
-
-void __init r8a7790_add_standard_devices(void)
-{
-	r8a7790_add_dt_devices();
 	r8a7790_register_irqc(0);
 	r8a7790_register_thermal();
 }
-- 
1.8.1.5
