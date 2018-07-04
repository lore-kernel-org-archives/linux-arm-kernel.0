From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Wed,  4 Jul 2018 15:25:24 +0200
Subject: [PATCH v2] dt-bindings: marvell: Add documentation for the Armada
 3700 AVS binding
Message-ID: <20180704132524.23640-1-gregory.clement@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Extend the documentation of the Armada 37xx SoC with the Adaptive Voltage
Scaling (AVS) registers.

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
Changelog:
v1 -> v2:
 - Add Acked-by: from Viresh Kumar
 - Add the dt mailing list in copy

 .../bindings/arm/marvell/armada-37xx.txt         | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/marvell/armada-37xx.txt b/Documentation/devicetree/bindings/arm/marvell/armada-37xx.txt
index 35c3c3460d17..22438f659d1e 100644
--- a/Documentation/devicetree/bindings/arm/marvell/armada-37xx.txt
+++ b/Documentation/devicetree/bindings/arm/marvell/armada-37xx.txt
@@ -33,3 +33,19 @@ nb_pm: syscon at 14000 {
 	compatible = "marvell,armada-3700-nb-pm", "syscon";
 	reg = <0x14000 0x60>;
 }
+
+AVS
+---
+
+For AVS an other component is needed:
+
+Required properties:
+- compatible     : should contain "marvell,armada-3700-avs", "syscon";
+- reg            : the register start and length for the AVS
+
+Example:
+avs: avs at 11500 {
+	compatible = "marvell,armada-3700-avs", "syscon";
+	reg = <0x11500 0x40>;
+}
+
-- 
2.17.1
