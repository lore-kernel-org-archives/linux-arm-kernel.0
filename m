From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 18 Apr 2014 20:52:28 +0200
Subject: [PATCH 1/2] ARM: sun7i: Add ARM PMU in A20 DTSI
Message-ID: <1397847149-26501-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the performance monitoring unit found in the A20 SoCs.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 899fd0e2b749..cc0d37fe5ae1 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -57,6 +57,12 @@
 			     <1 10 0xf08>;
 	};
 
+	pmu {
+		compatible = "arm,cortex-a7-pmu", "arm,cortex-a15-pmu";
+		interrupts = <0 120 4>,
+			     <0 121 4>;
+	};
+
 	clocks {
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
1.9.1
