From: carlo@caione.org (Carlo Caione)
Date: Thu,  1 May 2014 14:29:34 +0200
Subject: [PATCH v5 8/8] ARM: sun7i/sun4i: dt: Add AXP209 support to various
 boards
In-Reply-To: <1398947374-3115-1-git-send-email-carlo@caione.org>
References: <1398947374-3115-1-git-send-email-carlo@caione.org>
Message-ID: <1398947374-3115-9-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Carlo Caione <carlo@caione.org>
---
 arch/arm/boot/dts/sun4i-a10-a1000.dts           | 58 ++++++++++++++++++++++
 arch/arm/boot/dts/sun4i-a10-cubieboard.dts      | 58 ++++++++++++++++++++++
 arch/arm/boot/dts/sun4i-a10-hackberry.dts       | 64 ++++++++++++++++++++++++
 arch/arm/boot/dts/sun4i-a10-inet97fv2.dts       | 58 ++++++++++++++++++++++
 arch/arm/boot/dts/sun4i-a10-mini-xplus.dts      | 65 +++++++++++++++++++++++++
 arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts  | 64 ++++++++++++++++++++++++
 arch/arm/boot/dts/sun4i-a10-pcduino.dts         | 58 ++++++++++++++++++++++
 arch/arm/boot/dts/sun7i-a20-cubieboard2.dts     | 59 ++++++++++++++++++++++
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts      | 59 ++++++++++++++++++++++
 arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts | 59 ++++++++++++++++++++++
 10 files changed, 602 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10-a1000.dts b/arch/arm/boot/dts/sun4i-a10-a1000.dts
index fa746aea..57d3fb4 100644
--- a/arch/arm/boot/dts/sun4i-a10-a1000.dts
+++ b/arch/arm/boot/dts/sun4i-a10-a1000.dts
@@ -88,6 +88,56 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&i2c0_pins_a>;
 			status = "okay";
+
+			axp209: pmic at 34 {
+				compatible = "x-powers,axp209";
+				reg = <0x34>;
+				interrupts = <0>;
+
+				interrupt-controller;
+				#interrupt-cells = <1>;
+
+				acin-supply = <&reg_axp_ipsout>;
+				vin2-supply = <&reg_axp_ipsout>;
+				vin3-supply = <&reg_axp_ipsout>;
+				ldo24in-supply = <&reg_axp_ipsout>;
+				ldo3in-supply = <&reg_axp_ipsout>;
+				ldo5in-supply = <&reg_axp_ipsout>;
+
+				regulators {
+					x-powers,dcdc-freq = <1500>;
+
+					axp_vcore_reg: dcdc2 {
+						regulator-min-microvolt = <700000>;
+						regulator-max-microvolt = <2275000>;
+						regulator-always-on;
+					};
+
+					axp_ddr_reg: dcdc3 {
+						regulator-always-on;
+					};
+
+					axp_rtc_reg: ldo1 {
+						regulator-always-on;
+					};
+
+					axp_analog_reg: ldo2 {
+						regulator-always-on;
+					};
+
+					axp_pll_reg: ldo3 {
+						regulator-always-on;
+					};
+
+					axp_hdmi_reg: ldo4 {
+						regulator-always-on;
+					};
+
+					axp_mic_reg: ldo5 {
+						regulator-always-on;
+					};
+				};
+			};
 		};
 	};
 
@@ -125,4 +175,12 @@
 	reg_usb2_vbus: usb2-vbus {
 		status = "okay";
 	};
+
+	reg_axp_ipsout: axp_ipsout {
+		compatible = "regulator-fixed";
+		regulator-name = "axp-ipsout";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+	};
 };
diff --git a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
index 4684cbe..0aed114 100644
--- a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
+++ b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
@@ -80,6 +80,56 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&i2c0_pins_a>;
 			status = "okay";
+
+			axp209: pmic at 34 {
+				compatible = "x-powers,axp209";
+				reg = <0x34>;
+				interrupts = <0>;
+
+				interrupt-controller;
+				#interrupt-cells = <1>;
+
+				acin-supply = <&reg_axp_ipsout>;
+				vin2-supply = <&reg_axp_ipsout>;
+				vin3-supply = <&reg_axp_ipsout>;
+				ldo24in-supply = <&reg_axp_ipsout>;
+				ldo3in-supply = <&reg_axp_ipsout>;
+				ldo5in-supply = <&reg_axp_ipsout>;
+
+				regulators {
+					x-powers,dcdc-freq = <1500>;
+
+					axp_vcore_reg: dcdc2 {
+						regulator-min-microvolt = <700000>;
+						regulator-max-microvolt = <2275000>;
+						regulator-always-on;
+					};
+
+					axp_ddr_reg: dcdc3 {
+						regulator-always-on;
+					};
+
+					axp_rtc_reg: ldo1 {
+						regulator-always-on;
+					};
+
+					axp_analog_reg: ldo2 {
+						regulator-always-on;
+					};
+
+					axp_pll_reg: ldo3 {
+						regulator-always-on;
+					};
+
+					axp_hdmi_reg: ldo4 {
+						regulator-always-on;
+					};
+
+					axp_mic_reg: ldo5 {
+						regulator-always-on;
+					};
+				};
+			};
 		};
 
 		i2c1: i2c at 01c2b000 {
@@ -117,4 +167,12 @@
 	reg_usb2_vbus: usb2-vbus {
 		status = "okay";
 	};
+
+	reg_axp_ipsout: axp_ipsout {
+		compatible = "regulator-fixed";
+		regulator-name = "axp-ipsout";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+	};
 };
diff --git a/arch/arm/boot/dts/sun4i-a10-hackberry.dts b/arch/arm/boot/dts/sun4i-a10-hackberry.dts
index d7c17e4..c81db47 100644
--- a/arch/arm/boot/dts/sun4i-a10-hackberry.dts
+++ b/arch/arm/boot/dts/sun4i-a10-hackberry.dts
@@ -82,6 +82,62 @@
 			pinctrl-0 = <&uart0_pins_a>;
 			status = "okay";
 		};
+
+		i2c0: i2c at 01c2ac00 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c0_pins_a>;
+			status = "okay";
+
+			axp209: pmic at 34 {
+				compatible = "x-powers,axp209";
+				reg = <0x34>;
+				interrupts = <0>;
+
+				interrupt-controller;
+				#interrupt-cells = <1>;
+
+				acin-supply = <&reg_axp_ipsout>;
+				vin2-supply = <&reg_axp_ipsout>;
+				vin3-supply = <&reg_axp_ipsout>;
+				ldo24in-supply = <&reg_axp_ipsout>;
+				ldo3in-supply = <&reg_axp_ipsout>;
+				ldo5in-supply = <&reg_axp_ipsout>;
+
+				regulators {
+					x-powers,dcdc-freq = <1500>;
+
+					axp_vcore_reg: dcdc2 {
+						regulator-min-microvolt = <700000>;
+						regulator-max-microvolt = <2275000>;
+						regulator-always-on;
+					};
+
+					axp_ddr_reg: dcdc3 {
+						regulator-always-on;
+					};
+
+					axp_rtc_reg: ldo1 {
+						regulator-always-on;
+					};
+
+					axp_analog_reg: ldo2 {
+						regulator-always-on;
+					};
+
+					axp_pll_reg: ldo3 {
+						regulator-always-on;
+					};
+
+					axp_hdmi_reg: ldo4 {
+						regulator-always-on;
+					};
+
+					axp_mic_reg: ldo5 {
+						regulator-always-on;
+					};
+				};
+			};
+		};
 	};
 
 	reg_emac_3v3: emac-3v3 {
@@ -102,4 +158,12 @@
 		gpio = <&pio 7 12 0>;
 		status = "okay";
 	};
+
+	reg_axp_ipsout: axp_ipsout {
+		compatible = "regulator-fixed";
+		regulator-name = "axp-ipsout";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+	};
 };
diff --git a/arch/arm/boot/dts/sun4i-a10-inet97fv2.dts b/arch/arm/boot/dts/sun4i-a10-inet97fv2.dts
index fe9272e..5d0d3c2 100644
--- a/arch/arm/boot/dts/sun4i-a10-inet97fv2.dts
+++ b/arch/arm/boot/dts/sun4i-a10-inet97fv2.dts
@@ -34,6 +34,56 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&i2c0_pins_a>;
 			status = "okay";
+
+			axp209: pmic at 34 {
+				compatible = "x-powers,axp209";
+				reg = <0x34>;
+				interrupts = <0>;
+
+				interrupt-controller;
+				#interrupt-cells = <1>;
+
+				acin-supply = <&reg_axp_ipsout>;
+				vin2-supply = <&reg_axp_ipsout>;
+				vin3-supply = <&reg_axp_ipsout>;
+				ldo24in-supply = <&reg_axp_ipsout>;
+				ldo3in-supply = <&reg_axp_ipsout>;
+				ldo5in-supply = <&reg_axp_ipsout>;
+
+				regulators {
+					x-powers,dcdc-freq = <1500>;
+
+					axp_vcore_reg: dcdc2 {
+						regulator-min-microvolt = <700000>;
+						regulator-max-microvolt = <2275000>;
+						regulator-always-on;
+					};
+
+					axp_ddr_reg: dcdc3 {
+						regulator-always-on;
+					};
+
+					axp_rtc_reg: ldo1 {
+						regulator-always-on;
+					};
+
+					axp_analog_reg: ldo2 {
+						regulator-always-on;
+					};
+
+					axp_pll_reg: ldo3 {
+						regulator-always-on;
+					};
+
+					axp_hdmi_reg: ldo4 {
+						regulator-always-on;
+					};
+
+					axp_mic_reg: ldo5 {
+						regulator-always-on;
+					};
+				};
+			};
 		};
 
 		usbphy: phy at 01c13400 {
@@ -66,4 +116,12 @@
 	reg_usb2_vbus: usb2-vbus {
 		status = "okay";
 	};
+
+	reg_axp_ipsout: axp_ipsout {
+		compatible = "regulator-fixed";
+		regulator-name = "axp-ipsout";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+	};
 };
diff --git a/arch/arm/boot/dts/sun4i-a10-mini-xplus.dts b/arch/arm/boot/dts/sun4i-a10-mini-xplus.dts
index dd84a9e..b23989d 100644
--- a/arch/arm/boot/dts/sun4i-a10-mini-xplus.dts
+++ b/arch/arm/boot/dts/sun4i-a10-mini-xplus.dts
@@ -47,6 +47,62 @@
 			pinctrl-0 = <&uart0_pins_a>;
 			status = "okay";
 		};
+
+		i2c0: i2c at 01c2ac00 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c0_pins_a>;
+			status = "okay";
+
+			axp209: pmic at 34 {
+				compatible = "x-powers,axp209";
+				reg = <0x34>;
+				interrupts = <0>;
+
+				interrupt-controller;
+				#interrupt-cells = <1>;
+
+				acin-supply = <&reg_axp_ipsout>;
+				vin2-supply = <&reg_axp_ipsout>;
+				vin3-supply = <&reg_axp_ipsout>;
+				ldo24in-supply = <&reg_axp_ipsout>;
+				ldo3in-supply = <&reg_axp_ipsout>;
+				ldo5in-supply = <&reg_axp_ipsout>;
+
+				regulators {
+					x-powers,dcdc-freq = <1500>;
+
+					axp_vcore_reg: dcdc2 {
+						regulator-min-microvolt = <700000>;
+						regulator-max-microvolt = <2275000>;
+						regulator-always-on;
+					};
+
+					axp_ddr_reg: dcdc3 {
+						regulator-always-on;
+					};
+
+					axp_rtc_reg: ldo1 {
+						regulator-always-on;
+					};
+
+					axp_analog_reg: ldo2 {
+						regulator-always-on;
+					};
+
+					axp_pll_reg: ldo3 {
+						regulator-always-on;
+					};
+
+					axp_hdmi_reg: ldo4 {
+						regulator-always-on;
+					};
+
+					axp_mic_reg: ldo5 {
+						regulator-always-on;
+					};
+				};
+			};
+		};
 	};
 
 	reg_usb1_vbus: usb1-vbus {
@@ -56,4 +112,13 @@
 	reg_usb2_vbus: usb2-vbus {
 		status = "okay";
 	};
+
+
+	reg_axp_ipsout: axp_ipsout {
+		compatible = "regulator-fixed";
+		regulator-name = "axp-ipsout";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+	};
 };
diff --git a/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts b/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts
index 66cf0c7..004a6f0 100644
--- a/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts
+++ b/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts
@@ -81,6 +81,62 @@
 			pinctrl-0 = <&uart0_pins_a>;
 			status = "okay";
 		};
+
+		i2c0: i2c at 01c2ac00 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c0_pins_a>;
+			status = "okay";
+
+			axp209: pmic at 34 {
+				compatible = "x-powers,axp209";
+				reg = <0x34>;
+				interrupts = <0>;
+
+				interrupt-controller;
+				#interrupt-cells = <1>;
+
+				acin-supply = <&reg_axp_ipsout>;
+				vin2-supply = <&reg_axp_ipsout>;
+				vin3-supply = <&reg_axp_ipsout>;
+				ldo24in-supply = <&reg_axp_ipsout>;
+				ldo3in-supply = <&reg_axp_ipsout>;
+				ldo5in-supply = <&reg_axp_ipsout>;
+
+				regulators {
+					x-powers,dcdc-freq = <1500>;
+
+					axp_vcore_reg: dcdc2 {
+						regulator-min-microvolt = <700000>;
+						regulator-max-microvolt = <2275000>;
+						regulator-always-on;
+					};
+
+					axp_ddr_reg: dcdc3 {
+						regulator-always-on;
+					};
+
+					axp_rtc_reg: ldo1 {
+						regulator-always-on;
+					};
+
+					axp_analog_reg: ldo2 {
+						regulator-always-on;
+					};
+
+					axp_pll_reg: ldo3 {
+						regulator-always-on;
+					};
+
+					axp_hdmi_reg: ldo4 {
+						regulator-always-on;
+					};
+
+					axp_mic_reg: ldo5 {
+						regulator-always-on;
+					};
+				};
+			};
+		};
 	};
 
 	leds {
@@ -108,4 +164,12 @@
 	reg_usb2_vbus: usb2-vbus {
 		status = "okay";
 	};
+
+	reg_axp_ipsout: axp_ipsout {
+		compatible = "regulator-fixed";
+		regulator-name = "axp-ipsout";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+	};
 };
diff --git a/arch/arm/boot/dts/sun4i-a10-pcduino.dts b/arch/arm/boot/dts/sun4i-a10-pcduino.dts
index 255b47e..fcd7c86 100644
--- a/arch/arm/boot/dts/sun4i-a10-pcduino.dts
+++ b/arch/arm/boot/dts/sun4i-a10-pcduino.dts
@@ -66,6 +66,56 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&i2c0_pins_a>;
 			status = "okay";
+
+			axp209: pmic at 34 {
+				compatible = "x-powers,axp209";
+				reg = <0x34>;
+				interrupts = <0>;
+
+				interrupt-controller;
+				#interrupt-cells = <1>;
+
+				acin-supply = <&reg_axp_ipsout>;
+				vin2-supply = <&reg_axp_ipsout>;
+				vin3-supply = <&reg_axp_ipsout>;
+				ldo24in-supply = <&reg_axp_ipsout>;
+				ldo3in-supply = <&reg_axp_ipsout>;
+				ldo5in-supply = <&reg_axp_ipsout>;
+
+				regulators {
+					x-powers,dcdc-freq = <1500>;
+
+					axp_vcore_reg: dcdc2 {
+						regulator-min-microvolt = <700000>;
+						regulator-max-microvolt = <2275000>;
+						regulator-always-on;
+					};
+
+					axp_ddr_reg: dcdc3 {
+						regulator-always-on;
+					};
+
+					axp_rtc_reg: ldo1 {
+						regulator-always-on;
+					};
+
+					axp_analog_reg: ldo2 {
+						regulator-always-on;
+					};
+
+					axp_pll_reg: ldo3 {
+						regulator-always-on;
+					};
+
+					axp_hdmi_reg: ldo4 {
+						regulator-always-on;
+					};
+
+					axp_mic_reg: ldo5 {
+						regulator-always-on;
+					};
+				};
+			};
 		};
 	};
 
@@ -76,4 +126,12 @@
 	reg_usb2_vbus: usb2-vbus {
 		status = "okay";
 	};
+
+	reg_axp_ipsout: axp_ipsout {
+		compatible = "regulator-fixed";
+		regulator-name = "axp-ipsout";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+	};
 };
diff --git a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
index 68de89f..3e748ed 100644
--- a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
+++ b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
@@ -66,6 +66,57 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&i2c0_pins_a>;
 			status = "okay";
+
+			axp209: pmic at 34 {
+				compatible = "x-powers,axp209";
+				reg = <0x34>;
+				interrupt-parent = <&nmi_intc>;
+				interrupts = <0 8>;
+
+				interrupt-controller;
+				#interrupt-cells = <1>;
+
+				acin-supply = <&reg_axp_ipsout>;
+				vin2-supply = <&reg_axp_ipsout>;
+				vin3-supply = <&reg_axp_ipsout>;
+				ldo24in-supply = <&reg_axp_ipsout>;
+				ldo3in-supply = <&reg_axp_ipsout>;
+				ldo5in-supply = <&reg_axp_ipsout>;
+
+				regulators {
+					x-powers,dcdc-freq = <1500>;
+
+					axp_vcore_reg: dcdc2 {
+						regulator-min-microvolt = <700000>;
+						regulator-max-microvolt = <2275000>;
+						regulator-always-on;
+					};
+
+					axp_ddr_reg: dcdc3 {
+						regulator-always-on;
+					};
+
+					axp_rtc_reg: ldo1 {
+						regulator-always-on;
+					};
+
+					axp_analog_reg: ldo2 {
+						regulator-always-on;
+					};
+
+					axp_pll_reg: ldo3 {
+						regulator-always-on;
+					};
+
+					axp_hdmi_reg: ldo4 {
+						regulator-always-on;
+					};
+
+					axp_mic_reg: ldo5 {
+						regulator-always-on;
+					};
+				};
+			};
 		};
 
 		i2c1: i2c at 01c2b000 {
@@ -114,4 +165,12 @@
 	reg_usb2_vbus: usb2-vbus {
 		status = "okay";
 	};
+
+	reg_axp_ipsout: axp_ipsout {
+		compatible = "regulator-fixed";
+		regulator-name = "axp-ipsout";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+	};
 };
diff --git a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
index cb25d3c..d863469 100644
--- a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
+++ b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
@@ -73,6 +73,57 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&i2c0_pins_a>;
 			status = "okay";
+
+			axp209: pmic at 34 {
+				compatible = "x-powers,axp209";
+				reg = <0x34>;
+				interrupt-parent = <&nmi_intc>;
+				interrupts = <0 8>;
+
+				interrupt-controller;
+				#interrupt-cells = <1>;
+
+				acin-supply = <&reg_axp_ipsout>;
+				vin2-supply = <&reg_axp_ipsout>;
+				vin3-supply = <&reg_axp_ipsout>;
+				ldo24in-supply = <&reg_axp_ipsout>;
+				ldo3in-supply = <&reg_axp_ipsout>;
+				ldo5in-supply = <&reg_axp_ipsout>;
+
+				regulators {
+					x-powers,dcdc-freq = <1500>;
+
+					axp_vcore_reg: dcdc2 {
+						regulator-min-microvolt = <700000>;
+						regulator-max-microvolt = <2275000>;
+						regulator-always-on;
+					};
+
+					axp_ddr_reg: dcdc3 {
+						regulator-always-on;
+					};
+
+					axp_rtc_reg: ldo1 {
+						regulator-always-on;
+					};
+
+					axp_analog_reg: ldo2 {
+						regulator-always-on;
+					};
+
+					axp_pll_reg: ldo3 {
+						regulator-always-on;
+					};
+
+					axp_hdmi_reg: ldo4 {
+						regulator-always-on;
+					};
+
+					axp_mic_reg: ldo5 {
+						regulator-always-on;
+					};
+				};
+			};
 		};
 
 		i2c1: i2c at 01c2b000 {
@@ -139,4 +190,12 @@
 	reg_usb2_vbus: usb2-vbus {
 		status = "okay";
 	};
+
+	reg_axp_ipsout: axp_ipsout {
+		compatible = "regulator-fixed";
+		regulator-name = "axp-ipsout";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+	};
 };
diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
index eeadf76..047340a 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
@@ -95,6 +95,57 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&i2c0_pins_a>;
 			status = "okay";
+
+			axp209: pmic at 34 {
+				compatible = "x-powers,axp209";
+				reg = <0x34>;
+				interrupt-parent = <&nmi_intc>;
+				interrupts = <0 8>;
+
+				interrupt-controller;
+				#interrupt-cells = <1>;
+
+				acin-supply = <&reg_axp_ipsout>;
+				vin2-supply = <&reg_axp_ipsout>;
+				vin3-supply = <&reg_axp_ipsout>;
+				ldo24in-supply = <&reg_axp_ipsout>;
+				ldo3in-supply = <&reg_axp_ipsout>;
+				ldo5in-supply = <&reg_axp_ipsout>;
+
+				regulators {
+					x-powers,dcdc-freq = <1500>;
+
+					axp_vcore_reg: dcdc2 {
+						regulator-min-microvolt = <700000>;
+						regulator-max-microvolt = <2275000>;
+						regulator-always-on;
+					};
+
+					axp_ddr_reg: dcdc3 {
+						regulator-always-on;
+					};
+
+					axp_rtc_reg: ldo1 {
+						regulator-always-on;
+					};
+
+					axp_analog_reg: ldo2 {
+						regulator-always-on;
+					};
+
+					axp_pll_reg: ldo3 {
+						regulator-always-on;
+					};
+
+					axp_hdmi_reg: ldo4 {
+						regulator-always-on;
+					};
+
+					axp_mic_reg: ldo5 {
+						regulator-always-on;
+					};
+				};
+			};
 		};
 
 		i2c1: i2c at 01c2b000 {
@@ -145,4 +196,12 @@
 	reg_usb2_vbus: usb2-vbus {
 		status = "okay";
 	};
+
+	reg_axp_ipsout: axp_ipsout {
+		compatible = "regulator-fixed";
+		regulator-name = "axp-ipsout";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+	};
 };
-- 
1.8.3.2
