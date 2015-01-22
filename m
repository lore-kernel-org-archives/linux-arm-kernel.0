From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 22 Jan 2015 09:48:52 +0000
Subject: [PATCH v2 RESEND 7/8] ARM: STi: STiH407: Enable PMU IRQs
In-Reply-To: <1421920133-7914-1-git-send-email-lee.jones@linaro.org>
References: <1421920133-7914-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1421920133-7914-8-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This driver is used to enable System Configuration Register controlled
External, CTI (Core Sight), PMU (Performance Management), and PL310 L2
Cache IRQs prior to use.

Here we are enabling PMU IRQs on both channels.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/stih407-family.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
index 939e46e..aa86d99 100644
--- a/arch/arm/boot/dts/stih407-family.dtsi
+++ b/arch/arm/boot/dts/stih407-family.dtsi
@@ -8,6 +8,7 @@
  */
 #include "stih407-pinctrl.dtsi"
 #include <dt-bindings/reset-controller/stih407-resets.h>
+#include <dt-bindings/interrupt-controller/irq-st.h>
 / {
 	#address-cells = <1>;
 	#size-cells = <1>;
@@ -119,6 +120,15 @@
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
