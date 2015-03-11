From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 11 Mar 2015 15:44:53 +0000
Subject: [PATCH v6 2/2] DT: exynos: update PMU binding
In-Reply-To: <1426088693-15724-1-git-send-email-marc.zyngier@arm.com>
References: <1426088693-15724-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1426088693-15724-3-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document the fact that some Exynos PMUs are capable of acting as
an interrupt controller.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 Documentation/devicetree/bindings/arm/samsung/pmu.txt | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/samsung/pmu.txt b/Documentation/devicetree/bindings/arm/samsung/pmu.txt
index 67b2113..2d6356d 100644
--- a/Documentation/devicetree/bindings/arm/samsung/pmu.txt
+++ b/Documentation/devicetree/bindings/arm/samsung/pmu.txt
@@ -29,10 +29,27 @@ Properties:
  - clocks : list of phandles and specifiers to all input clocks listed in
 		clock-names property.
 
+Optional properties:
+
+Some PMUs are capable of behaving as an interrupt controller (mostly
+to wake up a suspended PMU). In which case, they can have the
+following properties:
+
+- interrupt-controller: indicate that said PMU is an interrupt controller
+
+- #interrupt-cells: must be identical to the that of the parent interrupt
+  controller.
+
+- interrupt-parent: a phandle indicating which interrupt controller
+  this PMU signals interrupts to.
+
 Example :
 pmu_system_controller: system-controller at 10040000 {
 	compatible = "samsung,exynos5250-pmu", "syscon";
 	reg = <0x10040000 0x5000>;
+	interrupt-controller;
+	#interrupt-cells = <3>;
+	interrupt-parent = <&gic>;
 	#clock-cells = <1>;
 	clock-names = "clkout0", "clkout1", "clkout2", "clkout3",
 			"clkout4", "clkout8", "clkout9";
-- 
2.1.4
