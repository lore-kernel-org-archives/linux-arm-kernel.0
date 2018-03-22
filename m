From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 22 Mar 2018 11:24:22 +0100
Subject: [PATCH v2 3/4] arm64: dts: renesas: r8a7796: sort subnodes of the
 root node
In-Reply-To: <20180322102423.18269-1-horms+renesas@verge.net.au>
References: <20180322102423.18269-1-horms+renesas@verge.net.au>
Message-ID: <20180322102423.18269-4-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sort subnodes of the root node alphanumerically.

This is part of an ongoing effort to provide consistent node
order in the DT of Renesas SoCs to improve maintainability.

This should not have any run-time effect.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
v2
* New patch
---
 arch/arm64/boot/dts/renesas/r8a7796.dtsi | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7796.dtsi b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
index 556eb8e45499..4e5fb961fbf2 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
@@ -234,13 +234,6 @@
 		clock-frequency = <0>;
 	};
 
-	pmu_a57 {
-		compatible = "arm,cortex-a57-pmu";
-		interrupts-extended = <&gic GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
-				      <&gic GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-affinity = <&a57_0>, <&a57_1>;
-	};
-
 	pmu_a53 {
 		compatible = "arm,cortex-a53-pmu";
 		interrupts-extended = <&gic GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>,
@@ -250,6 +243,13 @@
 		interrupt-affinity = <&a53_0>, <&a53_1>, <&a53_2>, <&a53_3>;
 	};
 
+	pmu_a57 {
+		compatible = "arm,cortex-a57-pmu";
+		interrupts-extended = <&gic GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
+				      <&gic GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&a57_0>, <&a57_1>;
+	};
+
 	psci {
 		compatible = "arm,psci-1.0", "arm,psci-0.2";
 		method = "smc";
-- 
2.11.0
