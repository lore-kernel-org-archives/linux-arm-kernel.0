From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Wed, 14 Nov 2012 15:16:09 +0800
Subject: [PATCH 11/11] ARM: dts: add the watchdog nodes for atmel SoC
In-Reply-To: <1352877369-19740-1-git-send-email-wenyou.yang@atmel.com>
References: <1352877369-19740-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <1352877369-19740-12-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
Cc: grant.likely at secretlab.ca
Cc: rob.herring at calxeda.com
Cc: rob at landley.net
Cc: linux at arm.linux.org.uk
Cc: devicetree-discuss at lists.ozlabs.org
Cc: linux-doc at vger.kernel.org
---
 .../devicetree/bindings/watchdog/atmel-wdt.txt     |   14 ++++++++++++++
 arch/arm/boot/dts/at91sam9260.dtsi                 |    6 ++++++
 arch/arm/boot/dts/at91sam9263.dtsi                 |    6 ++++++
 arch/arm/boot/dts/at91sam9263ek.dts                |    4 ++++
 arch/arm/boot/dts/at91sam9g20ek_common.dtsi        |    4 ++++
 arch/arm/boot/dts/at91sam9g25ek.dts                |    4 ++++
 arch/arm/boot/dts/at91sam9g45.dtsi                 |    5 +++++
 arch/arm/boot/dts/at91sam9m10g45ek.dts             |    4 ++++
 arch/arm/boot/dts/at91sam9n12.dtsi                 |    6 ++++++
 arch/arm/boot/dts/at91sam9n12ek.dts                |    4 ++++
 arch/arm/boot/dts/at91sam9x5.dtsi                  |    6 ++++++
 11 files changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/atmel-wdt.txt

diff --git a/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt b/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt
new file mode 100644
index 0000000..5d09b87
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt
@@ -0,0 +1,14 @@
+* Atmel's Watchdog Timer Controller
+
+Required properties:
+- compatible : should be "atmel,at91sam-wdt"
+- reg : base physical address of the controller and length of memory mapped
+	region.
+
+Example:
+
+	watchdog at fffffd40 {
+		compatible = "atmel,at91sam-wdt";
+		reg = <0xfffffd40 0x10>;
+		status = "okay";
+	};
diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/at91sam9260.dtsi
index d410581..81687a3 100644
--- a/arch/arm/boot/dts/at91sam9260.dtsi
+++ b/arch/arm/boot/dts/at91sam9260.dtsi
@@ -86,6 +86,12 @@
 				interrupts = <1 4 7>;
 			};
 
+			watchdog at fffffd40 {
+				compatible = "atmel,at91sam-wdt";
+				reg = <0xfffffd40 0x10>;
+				status = "disabled";
+			};
+
 			tcb0: timer at fffa0000 {
 				compatible = "atmel,at91rm9200-tcb";
 				reg = <0xfffa0000 0x100>;
diff --git a/arch/arm/boot/dts/at91sam9263.dtsi b/arch/arm/boot/dts/at91sam9263.dtsi
index 3e6e5c1..a25826b 100644
--- a/arch/arm/boot/dts/at91sam9263.dtsi
+++ b/arch/arm/boot/dts/at91sam9263.dtsi
@@ -73,6 +73,12 @@
 				interrupts = <1 4 7>;
 			};
 
+			watchdog at fffffd40 {
+				compatible = "atmel,at91sam-wdt";
+				reg = <0xfffffd40 0x10>;
+				status = "disabled";
+			};
+
 			tcb0: timer at fff7c000 {
 				compatible = "atmel,at91rm9200-tcb";
 				reg = <0xfff7c000 0x100>;
diff --git a/arch/arm/boot/dts/at91sam9263ek.dts b/arch/arm/boot/dts/at91sam9263ek.dts
index f86ac4b..bc947ea 100644
--- a/arch/arm/boot/dts/at91sam9263ek.dts
+++ b/arch/arm/boot/dts/at91sam9263ek.dts
@@ -50,6 +50,10 @@
 				atmel,vbus-gpio = <&pioA 25 0>;
 				status = "okay";
 			};
+
+			watchdog at fffffd40 {
+				status = "okay";
+			};
 		};
 
 		nand0: nand at 40000000 {
diff --git a/arch/arm/boot/dts/at91sam9g20ek_common.dtsi b/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
index e6391a4..e5797b7 100644
--- a/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
+++ b/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
@@ -51,6 +51,10 @@
 				atmel,vbus-gpio = <&pioC 5 0>;
 				status = "okay";
 			};
+
+			watchdog at fffffd40 {
+				status = "okay";
+			};
 		};
 
 		nand0: nand at 40000000 {
diff --git a/arch/arm/boot/dts/at91sam9g25ek.dts b/arch/arm/boot/dts/at91sam9g25ek.dts
index 877c08f..2f03edc 100644
--- a/arch/arm/boot/dts/at91sam9g25ek.dts
+++ b/arch/arm/boot/dts/at91sam9g25ek.dts
@@ -44,6 +44,10 @@
 			i2c2: i2c at f8018000 {
 				status = "okay";
 			};
+
+			watchdog at fffffe40 {
+				status = "okay";
+			};
 		};
 
 		usb0: ohci at 00600000 {
diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index 3add030..c6c2c09 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -84,6 +84,11 @@
 				interrupts = <1 4 7>;
 			};
 
+			watchdog at fffffd40 {
+				compatible = "atmel,at91sam-wdt";
+				reg = <0xfffffd40 0x10>;
+				status = "disabled";
+			};
 
 			shdwc at fffffd10 {
 				compatible = "atmel,at91sam9rl-shdwc";
diff --git a/arch/arm/boot/dts/at91sam9m10g45ek.dts b/arch/arm/boot/dts/at91sam9m10g45ek.dts
index 15e1dd4..371ab40 100644
--- a/arch/arm/boot/dts/at91sam9m10g45ek.dts
+++ b/arch/arm/boot/dts/at91sam9m10g45ek.dts
@@ -54,6 +54,10 @@
 			i2c1: i2c at fff88000 {
 				status = "okay";
 			};
+
+			watchdog at fffffd40 {
+				status = "okay";
+			};
 		};
 
 		nand0: nand at 40000000 {
diff --git a/arch/arm/boot/dts/at91sam9n12.dtsi b/arch/arm/boot/dts/at91sam9n12.dtsi
index 82508d6..e5e6363 100644
--- a/arch/arm/boot/dts/at91sam9n12.dtsi
+++ b/arch/arm/boot/dts/at91sam9n12.dtsi
@@ -79,6 +79,12 @@
 				interrupts = <1 4 7>;
 			};
 
+			watchdog at fffffe40 {
+				compatible = "atmel,at91sam-wdt";
+				reg = <0xfffffe40 0x10>;
+				status = "disabled";
+			};
+
 			shdwc at fffffe10 {
 				compatible = "atmel,at91sam9x5-shdwc";
 				reg = <0xfffffe10 0x10>;
diff --git a/arch/arm/boot/dts/at91sam9n12ek.dts b/arch/arm/boot/dts/at91sam9n12ek.dts
index 912b2c2..abeda7a 100644
--- a/arch/arm/boot/dts/at91sam9n12ek.dts
+++ b/arch/arm/boot/dts/at91sam9n12ek.dts
@@ -45,6 +45,10 @@
 			i2c1: i2c at f8014000 {
 				status = "okay";
 			};
+
+			watchdog at fffffe40 {
+				status = "okay";
+			};
 		};
 
 		nand0: nand at 40000000 {
diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index 03fc136..485f171 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -87,6 +87,12 @@
 				interrupts = <1 4 7>;
 			};
 
+			watchdog at fffffe40 {
+				compatible = "atmel,at91sam-wdt";
+				reg = <0xfffffe40 0x10>;
+				status = "disabled";
+			};
+
 			tcb0: timer at f8008000 {
 				compatible = "atmel,at91sam9x5-tcb";
 				reg = <0xf8008000 0x100>;
-- 
1.7.9.5
