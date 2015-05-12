From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 12 May 2015 13:51:49 +0100
Subject: [PATCH 12/13] ARM: STi: STiH407: Enable PMU IRQs
In-Reply-To: <1431435110-22595-1-git-send-email-lee.jones@linaro.org>
References: <1431435110-22595-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1431435110-22595-13-git-send-email-lee.jones@linaro.org>
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
index 412206e..e096105 100644
--- a/arch/arm/boot/dts/stih407-family.dtsi
+++ b/arch/arm/boot/dts/stih407-family.dtsi
@@ -10,6 +10,7 @@
 #include <dt-bindings/mfd/st-lpc.h>
 #include <dt-bindings/phy/phy.h>
 #include <dt-bindings/reset-controller/stih407-resets.h>
+#include <dt-bindings/interrupt-controller/irq-st.h>
 / {
 	#address-cells = <1>;
 	#size-cells = <1>;
@@ -127,6 +128,15 @@
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
