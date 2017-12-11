From: yixun.lan@amlogic.com (Yixun Lan)
Date: Mon, 11 Dec 2017 14:48:53 +0800
Subject: [PATCH v6 6/6] arm64: dts: meson-axg: switch uart_ao clock to CLK81
In-Reply-To: <20171211064853.32111-1-yixun.lan@amlogic.com>
References: <20171211064853.32111-1-yixun.lan@amlogic.com>
Message-ID: <20171211064853.32111-7-yixun.lan@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Switch the uart_ao pclk to CLK81 since the clock driver is ready.
Also move the clock info to the board.dts instead in the soc.dtsi.

Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts | 2 ++
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi     | 5 +----
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
index 70eca1f8736a..718bbebff107 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
@@ -19,4 +19,6 @@
 
 &uart_AO {
 	status = "okay";
+	clocks = <&xtal>, <&clkc CLKID_CLK81>, <&xtal>;
+	clock-names = "xtal", "pclk", "baud";
 };
diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index 6fe5ee0c144e..f5b496bfd4de 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -7,6 +7,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/clock/axg-clkc.h>
 
 / {
 	compatible = "amlogic,meson-axg";
@@ -200,8 +201,6 @@
 				compatible = "amlogic,meson-gx-uart", "amlogic,meson-ao-uart";
 				reg = <0x0 0x3000 0x0 0x18>;
 				interrupts = <GIC_SPI 193 IRQ_TYPE_EDGE_RISING>;
-				clocks = <&xtal>, <&xtal>, <&xtal>;
-				clock-names = "xtal", "pclk", "baud";
 				status = "disabled";
 			};
 
@@ -209,8 +208,6 @@
 				compatible = "amlogic,meson-gx-uart", "amlogic,meson-ao-uart";
 				reg = <0x0 0x4000 0x0 0x18>;
 				interrupts = <GIC_SPI 197 IRQ_TYPE_EDGE_RISING>;
-				clocks = <&xtal>, <&xtal>, <&xtal>;
-				clock-names = "xtal", "pclk", "baud";
 				status = "disabled";
 			};
 		};
-- 
2.15.1
