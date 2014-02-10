From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Mon, 10 Feb 2014 18:41:18 +0200
Subject: [PATCH v3 1/4] ARM: dts: keystone: add gpio device entry
In-Reply-To: <1392050481-19086-1-git-send-email-grygorii.strashko@ti.com>
References: <1392050481-19086-1-git-send-email-grygorii.strashko@ti.com>
Message-ID: <1392050481-19086-2-git-send-email-grygorii.strashko@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds Keystone GPIO IP device definitions in DT which supports
up to 32 GPIO lines and each GPIO line can be configured as separate
interrupt source (so called "unbanked" IRQ).

For more information see:
 http://www.ti.com/lit/ug/sprugv1/sprugv1.pdf

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 arch/arm/boot/dts/keystone.dtsi |   45 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm/boot/dts/keystone.dtsi b/arch/arm/boot/dts/keystone.dtsi
index 3a83ffe..0f82bb9 100644
--- a/arch/arm/boot/dts/keystone.dtsi
+++ b/arch/arm/boot/dts/keystone.dtsi
@@ -7,6 +7,7 @@
  */
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/gpio/gpio.h>
 
 #include "skeleton.dtsi"
 
@@ -214,5 +215,49 @@
 			reg = <0x022f0080 0x80>;
 			clocks = <&clkwdtimer0>;
 		};
+
+		gpio0: gpio at 260bf00 {
+			compatible = "ti,keystone-gpio";
+			reg = <0x0260bf00 0x100>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			/* HW Interrupts mapped to GPIO pins */
+			interrupts = <GIC_SPI 120 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 121 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 122 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 123 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 124 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 125 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 126 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 127 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 128 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 129 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 130 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 131 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 132 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 133 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 134 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 135 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 136 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 137 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 138 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 139 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 140 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 141 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 142 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 143 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 144 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 145 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 146 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 147 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 148 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 149 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 150 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 151 IRQ_TYPE_EDGE_RISING>;
+			clocks = <&clkgpio>;
+			clock-names = "gpio";
+			ti,ngpio = <32>;
+			ti,davinci-gpio-unbanked = <32>;
+		};
 	};
 };
-- 
1.7.9.5
