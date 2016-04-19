From: martinayotte@gmail.com (Martin Ayotte)
Date: Tue, 19 Apr 2016 15:50:39 -0400
Subject: [PATCH v2 1/1] add missing UARTs pins and I2C entriesfor AllWinner H3
 DTSI
Message-ID: <CAKQ8BtjPhfJC+njOUvo-4ZQ+Oj==LqQEhJ1LQROjY85hswE9Mg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This patch is submit to provide endusers access to additional UARTs on
AllWinner H3 SoC along with I2C ports.

Regards,
Martin.

---
 arch/arm/boot/dts/sun8i-h3.dtsi | 75 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
index 4a4926b..c947360d 100644
--- a/arch/arm/boot/dts/sun8i-h3.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3.dtsi
@@ -508,6 +508,48 @@
                 allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
             };

+            uart1_pins_a: uart1 at 0 {
+                allwinner,pins = "PG6", "PG7";
+                allwinner,function = "uart1";
+                allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+                allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+            };
+
+            uart2_pins_a: uart2 at 0 {
+                allwinner,pins = "PA0", "PA1";
+                allwinner,function = "uart2";
+                allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+                allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+            };
+
+            uart3_pins_a: uart3 at 0 {
+                allwinner,pins = "PA13", "PA14";
+                allwinner,function = "uart3";
+                allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+                allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+            };
+
+            i2c0_pins_a: i2c0 at 0 {
+                allwinner,pins = "PA11", "PA12";
+                allwinner,function = "i2c0";
+                allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+                allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+            };
+
+            i2c1_pins_a: i2c1 at 0 {
+                allwinner,pins = "PA18", "PA19";
+                allwinner,function = "i2c1";
+                allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+                allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+            };
+
+            i2c2_pins_a: i2c2 at 0 {
+                allwinner,pins = "PE12", "PE13";
+                allwinner,function = "i2c2";
+                allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+                allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+            };
+
             mmc0_pins_a: mmc0 at 0 {
                 allwinner,pins = "PF0", "PF1", "PF2", "PF3",
                          "PF4", "PF5";
@@ -626,6 +668,39 @@
             status = "disabled";
         };

+        i2c0: i2c at 01c2ac00 {
+            compatible = "allwinner,sun6i-a31-i2c";
+            reg = <0x01c2ac00 0x400>;
+            interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
+            clocks = <&bus_gates 96>;
+            resets = <&apb2_rst 0>;
+            status = "disabled";
+            #address-cells = <1>;
+            #size-cells = <0>;
+        };
+
+        i2c1: i2c at 01c2b000 {
+            compatible = "allwinner,sun6i-a31-i2c";
+            reg = <0x01c2b000 0x400>;
+            interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
+            clocks = <&bus_gates 97>;
+            resets = <&apb2_rst 1>;
+            status = "disabled";
+            #address-cells = <1>;
+            #size-cells = <0>;
+        };
+
+        i2c2: i2c at 01c2b400 {
+            compatible = "allwinner,sun6i-a31-i2c";
+            reg = <0x01c2b400 0x400>;
+            interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
+            clocks = <&bus_gates 98>;
+            resets = <&apb2_rst 2>;
+            status = "disabled";
+            #address-cells = <1>;
+            #size-cells = <0>;
+        };
+
         gic: interrupt-controller at 01c81000 {
             compatible = "arm,cortex-a7-gic", "arm,cortex-a15-gic";
             reg = <0x01c81000 0x1000>,
-- 
2.7.4
