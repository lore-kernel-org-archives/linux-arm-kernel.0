From: david.lanzendoerfer@o2s.ch (David =?utf-8?q?Lanzend=C3=B6rfer?=)
Date: Wed, 05 Feb 2014 14:54:49 +0100
Subject: [PATCH v3 6/7] ARM: dts: sun4i: Add support for mmc
In-Reply-To: <20140205134741.3027.50207.stgit@dizzy-6.o2s.ch>
References: <20140205134741.3027.50207.stgit@dizzy-6.o2s.ch>
Message-ID: <20140205135448.3027.51611.stgit@dizzy-6.o2s.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: David Lanzend?rfer <david.lanzendoerfer@o2s.ch>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun4i-a10-a1000.dts      |    8 ++++
 arch/arm/boot/dts/sun4i-a10-cubieboard.dts |    8 ++++
 arch/arm/boot/dts/sun4i-a10.dtsi           |   54 ++++++++++++++++++++++++++++
 3 files changed, 70 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10-a1000.dts b/arch/arm/boot/dts/sun4i-a10-a1000.dts
index d4b081d..a879ef3 100644
--- a/arch/arm/boot/dts/sun4i-a10-a1000.dts
+++ b/arch/arm/boot/dts/sun4i-a10-a1000.dts
@@ -35,6 +35,14 @@
 			};
 		};
 
+		mmc0: mmc at 01c0f000 {
+			pinctrl-names = "default", "default";
+			pinctrl-0 = <&mmc0_pins_a>;
+			pinctrl-1 = <&mmc0_cd_pin_reference_design>;
+			cd-gpios = <&pio 7 1 0>; /* PH1 */
+			status = "okay";
+		};
+
 		pinctrl at 01c20800 {
 			emac_power_pin_a1000: emac_power_pin at 0 {
 				allwinner,pins = "PH15";
diff --git a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
index b139ee6..20b976a 100644
--- a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
+++ b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
@@ -33,6 +33,14 @@
 			};
 		};
 
+		mmc0: mmc at 01c0f000 {
+			pinctrl-names = "default", "default";
+			pinctrl-0 = <&mmc0_pins_a>;
+			pinctrl-1 = <&mmc0_cd_pin_reference_design>;
+			cd-gpios = <&pio 7 1 0>; /* PH1 */
+			status = "okay";
+		};
+
 		pinctrl at 01c20800 {
 			led_pins_cubieboard: led_pins at 0 {
 				allwinner,pins = "PH20", "PH21";
diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index 040bb0e..c941ca3 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -330,6 +330,46 @@
 			#size-cells = <0>;
 		};
 
+		mmc0: mmc at 01c0f000 {
+			compatible = "allwinner,sun5i-a13-mmc";
+			reg = <0x01c0f000 0x1000>;
+			clocks = <&ahb_gates 8>, <&mmc0_clk>;
+			clock-names = "ahb", "mod";
+			interrupts = <32>;
+			bus-width = <4>;
+			status = "disabled";
+		};
+
+		mmc1: mmc at 01c10000 {
+			compatible = "allwinner,sun5i-a13-mmc";
+			reg = <0x01c10000 0x1000>;
+			clocks = <&ahb_gates 9>, <&mmc1_clk>;
+			clock-names = "ahb", "mod";
+			interrupts = <33>;
+			bus-width = <4>;
+			status = "disabled";
+		};
+
+		mmc2: mmc at 01c11000 {
+			compatible = "allwinner,sun5i-a13-mmc";
+			reg = <0x01c11000 0x1000>;
+			clocks = <&ahb_gates 10>, <&mmc2_clk>;
+			clock-names = "ahb", "mod";
+			interrupts = <34>;
+			bus-width = <4>;
+			status = "disabled";
+		};
+
+		mmc3: mmc at 01c12000 {
+			compatible = "allwinner,sun5i-a13-mmc";
+			reg = <0x01c12000 0x1000>;
+			clocks = <&ahb_gates 11>, <&mmc3_clk>;
+			clock-names = "ahb", "mod";
+			interrupts = <35>;
+			bus-width = <4>;
+			status = "disabled";
+		};
+
 		intc: interrupt-controller at 01c20400 {
 			compatible = "allwinner,sun4i-ic";
 			reg = <0x01c20400 0x400>;
@@ -400,6 +440,20 @@
 				allwinner,drive = <0>;
 				allwinner,pull = <0>;
 			};
+
+			mmc0_pins_a: mmc0 at 0 {
+				allwinner,pins = "PF0","PF1","PF2","PF3","PF4","PF5";
+				allwinner,function = "mmc0";
+				allwinner,drive = <3>;
+				allwinner,pull = <0>;
+			};
+
+			mmc0_cd_pin_reference_design: mmc0_cd_pin at 0 {
+				allwinner,pins = "PH1";
+				allwinner,function = "gpio_in";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
 		};
 
 		timer at 01c20c00 {
