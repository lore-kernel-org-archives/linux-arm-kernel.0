From: jbrunet@baylibre.com (Jerome Brunet)
Date: Tue,  4 Oct 2016 17:08:27 +0200
Subject: [RFC 09/10] ARM: dts: amlogic: enable gpio interrupt controller on
 meson8
In-Reply-To: <1475593708-10526-1-git-send-email-jbrunet@baylibre.com>
References: <1475593708-10526-1-git-send-email-jbrunet@baylibre.com>
Message-ID: <1475593708-10526-10-git-send-email-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm/boot/dts/meson8.dtsi  | 19 +++++++++++++++++++
 arch/arm/boot/dts/meson8b.dtsi | 19 +++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/arch/arm/boot/dts/meson8.dtsi b/arch/arm/boot/dts/meson8.dtsi
index 45619f6162c5..82690e0352c9 100644
--- a/arch/arm/boot/dts/meson8.dtsi
+++ b/arch/arm/boot/dts/meson8.dtsi
@@ -43,6 +43,8 @@
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
 
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/gpio/meson8-gpio.h>
 /include/ "meson.dtsi"
 
@@ -91,6 +93,21 @@
 		clock-frequency = <141666666>;
 	};
 
+	gpio_interrupt: interrupt-controller at c1109880 {
+		compatible = "amlogic,meson8-gpio-intc";
+		reg = <0xc1109880 0x10>;
+		interrupts = <GIC_SPI 64 IRQ_TYPE_NONE>,
+			   <GIC_SPI 65 IRQ_TYPE_NONE>,
+			   <GIC_SPI 66 IRQ_TYPE_NONE>,
+			   <GIC_SPI 67 IRQ_TYPE_NONE>,
+			   <GIC_SPI 68 IRQ_TYPE_NONE>,
+			   <GIC_SPI 69 IRQ_TYPE_NONE>,
+			   <GIC_SPI 70 IRQ_TYPE_NONE>,
+			   <GIC_SPI 71 IRQ_TYPE_NONE>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
 	pinctrl_cbus: pinctrl at c1109880 {
 		compatible = "amlogic,meson8-cbus-pinctrl";
 		reg = <0xc1109880 0x10>;
@@ -106,6 +123,7 @@
 			reg-names = "mux", "pull", "pull-enable", "gpio";
 			gpio-controller;
 			#gpio-cells = <2>;
+			interrupt-parent = <&gpio_interrupt>;
 		};
 
 		spi_nor_pins: nor {
@@ -148,6 +166,7 @@
 			reg-names = "mux", "pull", "gpio";
 			gpio-controller;
 			#gpio-cells = <2>;
+			interrupt-parent = <&gpio_interrupt>;
 		};
 
 		uart_ao_a_pins: uart_ao_a {
diff --git a/arch/arm/boot/dts/meson8b.dtsi b/arch/arm/boot/dts/meson8b.dtsi
index 41fd53671859..d76e7cb4d3dc 100644
--- a/arch/arm/boot/dts/meson8b.dtsi
+++ b/arch/arm/boot/dts/meson8b.dtsi
@@ -44,6 +44,8 @@
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
 
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/meson8b-clkc.h>
 #include <dt-bindings/gpio/meson8b-gpio.h>
 #include <dt-bindings/reset/amlogic,meson8b-reset.h>
@@ -183,6 +185,21 @@
 			status = "disabled";
 		};
 
+		gpio_interrupt: interrupt-controller at c1109880 {
+			compatible = "amlogic,meson8b-gpio-intc";
+			reg = <0xc1109880 0x10>;
+			interrupts = <GIC_SPI 64 IRQ_TYPE_NONE>,
+				   <GIC_SPI 65 IRQ_TYPE_NONE>,
+				   <GIC_SPI 66 IRQ_TYPE_NONE>,
+				   <GIC_SPI 67 IRQ_TYPE_NONE>,
+				   <GIC_SPI 68 IRQ_TYPE_NONE>,
+				   <GIC_SPI 69 IRQ_TYPE_NONE>,
+				   <GIC_SPI 70 IRQ_TYPE_NONE>,
+				   <GIC_SPI 71 IRQ_TYPE_NONE>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
 		pinctrl_cbus: pinctrl at c1109880 {
 			compatible = "amlogic,meson8b-cbus-pinctrl";
 			reg = <0xc1109880 0x10>;
@@ -198,6 +215,7 @@
 				reg-names = "mux", "pull", "pull-enable", "gpio";
 				gpio-controller;
 				#gpio-cells = <2>;
+				interrupt-parent = <&gpio_interrupt>;
 			};
 		};
 
@@ -215,6 +233,7 @@
 				reg-names = "mux", "pull", "gpio";
 				gpio-controller;
 				#gpio-cells = <2>;
+				interrupt-parent = <&gpio_interrupt>;
 			};
 
 			uart_ao_a_pins: uart_ao_a {
-- 
2.7.4
