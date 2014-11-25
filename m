From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 25 Nov 2014 16:25:04 +0000
Subject: [PATCH v2 7/8] ARM: STi: STiH407: Enable PMU IRQs
In-Reply-To: <1416932705-16880-1-git-send-email-lee.jones@linaro.org>
References: <1416932705-16880-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1416932705-16880-8-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This driver is used to enable System Configuration Register controlled
External, CTI (Core Sight), PMU (Performance Management), and PL310 L2
Cache IRQs prior to use.

Here we are enabling PMU IRQs on both channels.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/stih407.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/stih407.dtsi b/arch/arm/boot/dts/stih407.dtsi
index 53bfcd9..e3b235f 100644
--- a/arch/arm/boot/dts/stih407.dtsi
+++ b/arch/arm/boot/dts/stih407.dtsi
@@ -8,6 +8,7 @@
  */
 #include "stih407-clock.dtsi"
 #include "stih407-pinctrl.dtsi"
+#include <dt-bindings/interrupt-controller/irq-st.h>
 / {
 	#address-cells = <1>;
 	#size-cells = <1>;
@@ -104,6 +105,15 @@
 			reg = <0x94b5100 0x1000>;
 		};
 
+		irq-syscfg {
+			compatible    = "st,stih407-irq-syscfg";
+			st,syscfg     = <&syscfg_core>;
+			st,irq-device = <ST_IRQ_SYSCFG_PMU_0>,
+					<ST_IRQ_SYSCFG_PMU_1>;
+			st,fiq-device = <ST_IRQ_SYSCFG_DISABLED>,
+					<ST_IRQ_SYSCFG_DISABLED>;
+		};
+
 		serial at 9830000 {
 			compatible = "st,asc";
 			reg = <0x9830000 0x2c>;
-- 
1.9.1
