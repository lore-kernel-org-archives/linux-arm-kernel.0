From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  7 Aug 2013 13:28:33 +0900
Subject: [GIT PULL 12/19] ARM: shmobile: r8a7740: add PMU information to
 r8a7740.dtsi
In-Reply-To: <cover.1375838900.git.horms+renesas@verge.net.au>
References: <cover.1375838900.git.horms+renesas@verge.net.au>
Message-ID: <b21ed4eb948e6c59dea30a7102d9736903bff26e.1375838900.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add PMU information to r8a7740.dtsi. With this
included Armadillo800eva DT reference may use the PMU.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7740.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7740.dtsi b/arch/arm/boot/dts/r8a7740.dtsi
index 24e9306..4b0728f 100644
--- a/arch/arm/boot/dts/r8a7740.dtsi
+++ b/arch/arm/boot/dts/r8a7740.dtsi
@@ -32,6 +32,11 @@
 		      <0xc2000000 0x1000>;
 	};
 
+	pmu {
+		compatible = "arm,cortex-a9-pmu";
+		interrupts = <0 83 4>;
+	};
+
 	/* irqpin0: IRQ0 - IRQ7 */
 	irqpin0: irqpin at e6900000 {
 		compatible = "renesas,intc-irqpin";
-- 
1.8.3.2
