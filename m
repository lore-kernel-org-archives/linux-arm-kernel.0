From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  7 Aug 2013 13:28:34 +0900
Subject: [GIT PULL 13/19] ARM: shmobile: sh73a0: add PMU information to
 sh73a0.dtsi
In-Reply-To: <cover.1375838900.git.horms+renesas@verge.net.au>
References: <cover.1375838900.git.horms+renesas@verge.net.au>
Message-ID: <4c90483a9c09ac8c18df43901c493e546bdaaabe.1375838900.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add PMU information to sh73a0.dtsi. With this
included KZM9G DT reference may use the PMU.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/sh73a0.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
index b977502..7137c0f 100644
--- a/arch/arm/boot/dts/sh73a0.dtsi
+++ b/arch/arm/boot/dts/sh73a0.dtsi
@@ -38,6 +38,12 @@
 		      <0xf0000100 0x100>;
 	};
 
+	pmu {
+		compatible = "arm,cortex-a9-pmu";
+		interrupts = <0 55 4>,
+			     <0 56 4>;
+	};
+
 	irqpin0: irqpin at e6900000 {
 		compatible = "renesas,intc-irqpin";
 		#interrupt-cells = <2>;
-- 
1.8.3.2
