From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 29 Jul 2014 15:05:43 +0100
Subject: [PATCH 5/6] ARM: STi: STiH416: Enable PMU IRQs
In-Reply-To: <1406642744-22589-1-git-send-email-lee.jones@linaro.org>
References: <1406642744-22589-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1406642744-22589-6-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This driver is used to enable System Configuration Register controlled
External, CTI (Core Sight), PMU (Performance Management), and PL310 L2
Cache IRQs prior to use.

Here we are enabling PMU IRQs on both channels.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/stih416.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/stih416.dtsi b/arch/arm/boot/dts/stih416.dtsi
index badefd6..7276125 100644
--- a/arch/arm/boot/dts/stih416.dtsi
+++ b/arch/arm/boot/dts/stih416.dtsi
@@ -11,6 +11,7 @@
 #include "stih416-pinctrl.dtsi"
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/reset-controller/stih416-resets.h>
+#include <dt-bindings/interrupt-controller/irq-st.h>
 / {
 	L2: cache-controller {
 		compatible = "arm,pl310-cache";
@@ -27,6 +28,15 @@
 		interrupts = <GIC_PPI 15 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
+	irq-syscfg {
+		compatible    = "st,stih416-irq-syscfg";
+		st,syscfg     = <&syscfg_cpu>;
+		st,irq-device = <ST_IRQ_SYSCFG_PMU_0>,
+				<ST_IRQ_SYSCFG_PMU_1>;
+		st,fiq-device = <ST_IRQ_SYSCFG_DISABLED>,
+				<ST_IRQ_SYSCFG_DISABLED>;
+	};
+
 	soc {
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
1.9.1
