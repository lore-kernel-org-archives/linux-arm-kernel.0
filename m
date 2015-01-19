From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 19 Jan 2015 09:44:10 +0000
Subject: [PATCH v4 16/21] DT: exynos: update PMU binding
In-Reply-To: <1421660655-21394-1-git-send-email-marc.zyngier@arm.com>
References: <1421660655-21394-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1421660655-21394-17-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document the fact that some Exynos PMUs are capable of acting as
an interrupt controller.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 Documentation/devicetree/bindings/arm/samsung/pmu.txt | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/samsung/pmu.txt b/Documentation/devicetree/bindings/arm/samsung/pmu.txt
index 1e1979b..d698e74 100644
--- a/Documentation/devicetree/bindings/arm/samsung/pmu.txt
+++ b/Documentation/devicetree/bindings/arm/samsung/pmu.txt
@@ -28,10 +28,23 @@ Properties:
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
+- interrupt-parent: a phandle indicating which interrupt controller
+  this PMU signals interrupts to.
+
 Example :
 pmu_system_controller: system-controller at 10040000 {
 	compatible = "samsung,exynos5250-pmu", "syscon";
 	reg = <0x10040000 0x5000>;
+	interrupt-controller;
+	interrupt-parent = <&gic>;
 	#clock-cells = <1>;
 	clock-names = "clkout0", "clkout1", "clkout2", "clkout3",
 			"clkout4", "clkout8", "clkout9";
-- 
2.1.4
