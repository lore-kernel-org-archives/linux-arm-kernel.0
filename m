From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 18 Apr 2014 20:52:29 +0200
Subject: [PATCH 2/2] ARM: sun6i: Add ARM PMU in A31 DTSI
In-Reply-To: <1397847149-26501-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1397847149-26501-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1397847149-26501-2-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the performance monitoring unit found in the A20 SoCs.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun6i-a31.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index bc46814d2ff0..4b0f1231efc4 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -59,6 +59,14 @@
 		reg = <0x40000000 0x80000000>;
 	};
 
+	pmu {
+		compatible = "arm,cortex-a7-pmu", "arm,cortex-a15-pmu";
+		interrupts = <0 120 4>,
+			     <0 121 4>,
+			     <0 122 4>,
+			     <0 123 4>;
+	};
+
 	clocks {
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
1.9.1
