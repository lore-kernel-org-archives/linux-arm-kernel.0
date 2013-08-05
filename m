From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 5 Aug 2013 14:11:13 -0400
Subject: [RESEND PATCH 6/7] ARM: Keystone: Convert device tree file to use IRQ
 defines
In-Reply-To: <1375726274-26000-1-git-send-email-santosh.shilimkar@ti.com>
References: <1375726274-26000-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1375726274-26000-7-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the GIC and standard IRQ binding defines in all IRQ specifiers.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/boot/dts/keystone.dts |   27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/keystone.dts b/arch/arm/boot/dts/keystone.dts
index 612ba8c..a68e34b 100644
--- a/arch/arm/boot/dts/keystone.dts
+++ b/arch/arm/boot/dts/keystone.dts
@@ -7,6 +7,8 @@
  */
 
 /dts-v1/;
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
 #include "skeleton.dtsi"
 
 / {
@@ -67,18 +69,23 @@
 
 	timer {
 		compatible = "arm,armv7-timer";
-		interrupts = <1 13 0xf08>,
-			     <1 14 0xf08>,
-			     <1 11 0xf08>,
-			     <1 10 0x308>;
+		interrupts =
+			<GIC_PPI 13
+				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			<GIC_PPI 14
+				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			<GIC_PPI 11
+				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			<GIC_PPI 10
+				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
 	};
 
 	pmu {
 		compatible = "arm,cortex-a15-pmu";
-		interrupts = <0 20 0xf01>,
-			     <0 21 0xf01>,
-			     <0 22 0xf01>,
-			     <0 23 0xf01>;
+		interrupts = <GIC_SPI 20 IRQ_TYPE_EDGE_RISING>,
+			     <GIC_SPI 21 IRQ_TYPE_EDGE_RISING>,
+			     <GIC_SPI 22 IRQ_TYPE_EDGE_RISING>,
+			     <GIC_SPI 23 IRQ_TYPE_EDGE_RISING>;
 	};
 
 	soc {
@@ -100,7 +107,7 @@
 			reg-io-width = <4>;
 			reg = <0x02530c00 0x100>;
 			clock-frequency = <133120000>;
-			interrupts = <0 277 0xf01>;
+			interrupts = <GIC_SPI 277 IRQ_TYPE_EDGE_RISING>;
 		};
 
 		uart1:	serial at 02531000 {
@@ -110,7 +117,7 @@
 			reg-io-width = <4>;
 			reg = <0x02531000 0x100>;
 			clock-frequency = <133120000>;
-			interrupts = <0 280 0xf01>;
+			interrupts = <GIC_SPI 280 IRQ_TYPE_EDGE_RISING>;
 		};
 
 	};
-- 
1.7.9.5
