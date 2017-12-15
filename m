From: yixun.lan@amlogic.com (Yixun Lan)
Date: Fri, 15 Dec 2017 22:17:41 +0800
Subject: [PATCH v8] arm64: dts: meson-axg: switch uart_ao clock to CLK81
Message-ID: <20171215141741.175985-1-yixun.lan@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Switch the uart_ao pclk to CLK81 since the clock driver is ready.

Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>

---
This is a fixup for the previous version

Changes in v8 since [1]
 - move clock DT info into soc.dtsi

[1]
http://lists.infradead.org/pipermail/linux-amlogic/2017-December/005741.html
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index 01beb211f442..d1f8043be426 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -7,6 +7,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/clock/axg-clkc.h>
 
 / {
 	compatible = "amlogic,meson-axg";
@@ -200,7 +201,7 @@
 				compatible = "amlogic,meson-gx-uart", "amlogic,meson-ao-uart";
 				reg = <0x0 0x3000 0x0 0x18>;
 				interrupts = <GIC_SPI 193 IRQ_TYPE_EDGE_RISING>;
-				clocks = <&xtal>, <&xtal>, <&xtal>;
+				clocks = <&xtal>, <&clkc CLKID_CLK81>, <&xtal>;
 				clock-names = "xtal", "pclk", "baud";
 				status = "disabled";
 			};
@@ -209,7 +210,7 @@
 				compatible = "amlogic,meson-gx-uart", "amlogic,meson-ao-uart";
 				reg = <0x0 0x4000 0x0 0x18>;
 				interrupts = <GIC_SPI 197 IRQ_TYPE_EDGE_RISING>;
-				clocks = <&xtal>, <&xtal>, <&xtal>;
+				clocks = <&xtal>, <&clkc CLKID_CLK81>, <&xtal>;
 				clock-names = "xtal", "pclk", "baud";
 				status = "disabled";
 			};
-- 
2.15.1
