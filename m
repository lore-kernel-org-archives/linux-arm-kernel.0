From: j-keerthy@ti.com (Keerthy)
Date: Wed, 26 Jul 2017 11:20:28 +0530
Subject: [PATCH v2 2/2] ARM: dts: keystone-k2g-evm: Add gpio nodes
In-Reply-To: <1501048228-3492-1-git-send-email-j-keerthy@ti.com>
References: <1501048228-3492-1-git-send-email-j-keerthy@ti.com>
Message-ID: <1501048228-3492-2-git-send-email-j-keerthy@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

66AK2G has 2 instances of gpio. The first one has all the 144 GPIOs
functional( 9 banks with 16 gpios = 144). The second instance has
only the GPIO0:GPIO67 functional and rest are marked reserved.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---

The patch depends on the below series:

http://marc.info/?l=linux-arm-kernel&m=150034845427555&w=2
http://marc.info/?l=linux-arm-kernel&m=150034856627618&w=2

Driver patches related are already posted:

https://www.spinics.net/lists/arm-kernel/msg594862.html

Changes in v2:

  * Split the documentation part into a separate patch.

 arch/arm/boot/dts/keystone-k2g.dtsi | 42 +++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm/boot/dts/keystone-k2g.dtsi b/arch/arm/boot/dts/keystone-k2g.dtsi
index bf4d1fa..f9ff299 100644
--- a/arch/arm/boot/dts/keystone-k2g.dtsi
+++ b/arch/arm/boot/dts/keystone-k2g.dtsi
@@ -15,6 +15,7 @@
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/pinctrl/keystone.h>
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	compatible = "ti,k2g","ti,keystone";
@@ -168,5 +169,46 @@
 				#reset-cells = <2>;
 			};
 		};
+
+		gpio0: gpio at 2603000 {
+			compatible = "ti,keystone-k2g-gpio", "ti,keystone-gpio";
+			reg = <0x02603000 0x100>;
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupts = <GIC_SPI 432 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 433 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 434 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 435 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 436 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 437 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 438 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 439 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 440 IRQ_TYPE_EDGE_RISING>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			ti,ngpio = <144>;
+			ti,davinci-gpio-unbanked = <0>;
+			clocks = <&k2g_clks 0x001b 0x0>;
+			clock-names = "gpio";
+		};
+
+		gpio1: gpio at 260a000 {
+			compatible = "ti,keystone-k2g-gpio", "ti,keystone-gpio";
+			reg = <0x0260a000 0x100>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupts = <GIC_SPI 442 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 443 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 444 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 445 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 446 IRQ_TYPE_EDGE_RISING>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			ti,ngpio = <68>;
+			ti,davinci-gpio-unbanked = <0>;
+			clocks = <&k2g_clks 0x001c 0x0>;
+			clock-names = "gpio";
+		};
 	};
 };
-- 
1.9.1
