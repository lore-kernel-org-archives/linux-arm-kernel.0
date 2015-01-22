From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 22 Jan 2015 09:48:50 +0000
Subject: [PATCH v2 RESEND 5/8] ARM: STi: STiH416: Enable PMU IRQs
In-Reply-To: <1421920133-7914-1-git-send-email-lee.jones@linaro.org>
References: <1421920133-7914-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1421920133-7914-6-git-send-email-lee.jones@linaro.org>
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
index cdbf29c..de2afb9 100644
--- a/arch/arm/boot/dts/stih416.dtsi
+++ b/arch/arm/boot/dts/stih416.dtsi
@@ -13,6 +13,7 @@
 #include <dt-bindings/phy/phy-miphy365x.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/reset-controller/stih416-resets.h>
+#include <dt-bindings/interrupt-controller/irq-st.h>
 / {
 	L2: cache-controller {
 		compatible = "arm,pl310-cache";
@@ -92,6 +93,15 @@
 			reg		= <0xfe4b5100 0x8>;
 		};
 
+		irq-syscfg {
+			compatible    = "st,stih416-irq-syscfg";
+			st,syscfg     = <&syscfg_cpu>;
+			st,irq-device = <ST_IRQ_SYSCFG_PMU_0>,
+					<ST_IRQ_SYSCFG_PMU_1>;
+			st,fiq-device = <ST_IRQ_SYSCFG_DISABLED>,
+					<ST_IRQ_SYSCFG_DISABLED>;
+		};
+
 		serial2: serial at fed32000{
 			compatible	= "st,asc";
 			status 		= "disabled";
-- 
1.9.1
