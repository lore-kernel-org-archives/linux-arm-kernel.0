From: sonnyrao@chromium.org (Sonny Rao)
Date: Tue,  7 Apr 2015 10:52:39 -0700
Subject: [PATCH] arm: dts: rk3288: Enable Cortex-A12 HW PMU events
Message-ID: <1428429159-24102-1-git-send-email-sonnyrao@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the dts node for the PMU with the correct PMUIRQ interrupts
for each core.

Signed-off-by: Sonny Rao <sonnyrao@chromium.org>
---
 arch/arm/boot/dts/rk3288.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 165968d..8253abb 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -44,6 +44,14 @@
 		spi2 = &spi2;
 	};
 
+	arm-pmu {
+		compatible = "arm,cortex-a12-pmu";
+		interrupts = <GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
2.2.0.rc0.207.ga3a616c
