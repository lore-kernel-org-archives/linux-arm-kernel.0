From: jbrunet@baylibre.com (Jerome Brunet)
Date: Wed, 19 Oct 2016 17:21:20 +0200
Subject: [PATCH v2 9/9] ARM: dts: amlogic: enable gpio interrupt controller on
 meson8
In-Reply-To: <1476890480-8884-1-git-send-email-jbrunet@baylibre.com>
References: <1476890480-8884-1-git-send-email-jbrunet@baylibre.com>
Message-ID: <1476890480-8884-10-git-send-email-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm/boot/dts/meson8.dtsi  | 11 +++++++++++
 arch/arm/boot/dts/meson8b.dtsi | 11 +++++++++++
 2 files changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/meson8.dtsi b/arch/arm/boot/dts/meson8.dtsi
index 45619f6162c5..713a22456ff1 100644
--- a/arch/arm/boot/dts/meson8.dtsi
+++ b/arch/arm/boot/dts/meson8.dtsi
@@ -43,6 +43,8 @@
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
 
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/gpio/meson8-gpio.h>
 /include/ "meson.dtsi"
 
@@ -91,6 +93,13 @@
 		clock-frequency = <141666666>;
 	};
 
+	gpio_interrupt: interrupt-controller at c1109880 {
+		compatible = "amlogic,meson8-gpio-intc";
+		reg = <0xc1109880 0x10>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
 	pinctrl_cbus: pinctrl at c1109880 {
 		compatible = "amlogic,meson8-cbus-pinctrl";
 		reg = <0xc1109880 0x10>;
@@ -106,6 +115,7 @@
 			reg-names = "mux", "pull", "pull-enable", "gpio";
 			gpio-controller;
 			#gpio-cells = <2>;
+			interrupt-parent = <&gpio_interrupt>;
 		};
 
 		spi_nor_pins: nor {
@@ -148,6 +158,7 @@
 			reg-names = "mux", "pull", "gpio";
 			gpio-controller;
 			#gpio-cells = <2>;
+			interrupt-parent = <&gpio_interrupt>;
 		};
 
 		uart_ao_a_pins: uart_ao_a {
diff --git a/arch/arm/boot/dts/meson8b.dtsi b/arch/arm/boot/dts/meson8b.dtsi
index 41fd53671859..36a239a645f5 100644
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
@@ -183,6 +185,13 @@
 			status = "disabled";
 		};
 
+		gpio_interrupt: interrupt-controller at c1109880 {
+			compatible = "amlogic,meson8b-gpio-intc";
+			reg = <0xc1109880 0x10>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
 		pinctrl_cbus: pinctrl at c1109880 {
 			compatible = "amlogic,meson8b-cbus-pinctrl";
 			reg = <0xc1109880 0x10>;
@@ -198,6 +207,7 @@
 				reg-names = "mux", "pull", "pull-enable", "gpio";
 				gpio-controller;
 				#gpio-cells = <2>;
+				interrupt-parent = <&gpio_interrupt>;
 			};
 		};
 
@@ -215,6 +225,7 @@
 				reg-names = "mux", "pull", "gpio";
 				gpio-controller;
 				#gpio-cells = <2>;
+				interrupt-parent = <&gpio_interrupt>;
 			};
 
 			uart_ao_a_pins: uart_ao_a {
-- 
2.7.4
