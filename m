From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Sat, 11 Jun 2016 00:03:20 +0200
Subject: [PATCH 17/48] ARM: dts: at91: calao: use TCB0 as clocksource
In-Reply-To: <1465596231-21766-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1465596231-21766-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1465596231-21766-18-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use tcb0 as the clocksource like previously selected in at91_dt_defconfig.

Cc: Gregory Hermant <gregory.hermant@calao-systems.com>
[tested on usb_a9g20 and usb_a9263]
Tested-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/at91-qil_a9260.dts    | 12 ++++++++++++
 arch/arm/boot/dts/tny_a9260_common.dtsi | 12 ++++++++++++
 arch/arm/boot/dts/tny_a9263.dts         | 12 ++++++++++++
 arch/arm/boot/dts/usb_a9260_common.dtsi | 12 ++++++++++++
 arch/arm/boot/dts/usb_a9263.dts         | 12 ++++++++++++
 5 files changed, 60 insertions(+)

diff --git a/arch/arm/boot/dts/at91-qil_a9260.dts b/arch/arm/boot/dts/at91-qil_a9260.dts
index 4f2eebf4a560..bbc1f667cc65 100644
--- a/arch/arm/boot/dts/at91-qil_a9260.dts
+++ b/arch/arm/boot/dts/at91-qil_a9260.dts
@@ -40,6 +40,18 @@
 
 	ahb {
 		apb {
+			tcb0: timer at fffa0000 {
+				timer at 0 {
+					compatible = "atmel,tcb-clksrc";
+					reg = <0>, <1>;
+				};
+
+				timer at 2 {
+					compatible = "atmel,tcb-clkevt";
+					reg = <2>;
+				};
+			};
+
 			usb1: gadget at fffa4000 {
 				atmel,vbus-gpio = <&pioC 5 GPIO_ACTIVE_HIGH>;
 				status = "okay";
diff --git a/arch/arm/boot/dts/tny_a9260_common.dtsi b/arch/arm/boot/dts/tny_a9260_common.dtsi
index ce7138c3af1b..0b2902d7ccd3 100644
--- a/arch/arm/boot/dts/tny_a9260_common.dtsi
+++ b/arch/arm/boot/dts/tny_a9260_common.dtsi
@@ -36,6 +36,18 @@
 
 	ahb {
 		apb {
+			tcb0: timer at fffa0000 {
+				timer at 0 {
+					compatible = "atmel,tcb-clksrc";
+					reg = <0>, <1>;
+				};
+
+				timer at 2 {
+					compatible = "atmel,tcb-clkevt";
+					reg = <2>;
+				};
+			};
+
 			dbgu: serial at fffff200 {
 				status = "okay";
 			};
diff --git a/arch/arm/boot/dts/tny_a9263.dts b/arch/arm/boot/dts/tny_a9263.dts
index 3043296345b7..32ee65a9f99f 100644
--- a/arch/arm/boot/dts/tny_a9263.dts
+++ b/arch/arm/boot/dts/tny_a9263.dts
@@ -45,6 +45,18 @@
 				status = "okay";
 			};
 
+			tcb0: timer at fff7c000 {
+				timer at 0 {
+					compatible = "atmel,tcb-clksrc";
+					reg = <0>, <1>;
+				};
+
+				timer at 2 {
+					compatible = "atmel,tcb-clkevt";
+					reg = <2>;
+				};
+			};
+
 			usb1: gadget at fff78000 {
 				atmel,vbus-gpio = <&pioB 11 GPIO_ACTIVE_HIGH>;
 				status = "okay";
diff --git a/arch/arm/boot/dts/usb_a9260_common.dtsi b/arch/arm/boot/dts/usb_a9260_common.dtsi
index 9beea8976584..369a26bc5edc 100644
--- a/arch/arm/boot/dts/usb_a9260_common.dtsi
+++ b/arch/arm/boot/dts/usb_a9260_common.dtsi
@@ -32,6 +32,18 @@
 				status = "okay";
 			};
 
+			tcb0: timer at fffa0000 {
+				timer at 0 {
+					compatible = "atmel,tcb-clksrc";
+					reg = <0>, <1>;
+				};
+
+				timer at 2 {
+					compatible = "atmel,tcb-clkevt";
+					reg = <2>;
+				};
+			};
+
 			macb0: ethernet at fffc4000 {
 				phy-mode = "rmii";
 				status = "okay";
diff --git a/arch/arm/boot/dts/usb_a9263.dts b/arch/arm/boot/dts/usb_a9263.dts
index 8cc6edb29694..49a25c26b8e4 100644
--- a/arch/arm/boot/dts/usb_a9263.dts
+++ b/arch/arm/boot/dts/usb_a9263.dts
@@ -45,6 +45,18 @@
 				status = "okay";
 			};
 
+			tcb0: timer at fff7c000 {
+				timer at 0 {
+					compatible = "atmel,tcb-clksrc";
+					reg = <0>, <1>;
+				};
+
+				timer at 2 {
+					compatible = "atmel,tcb-clkevt";
+					reg = <2>;
+				};
+			};
+
 			macb0: ethernet at fffbc000 {
 				phy-mode = "rmii";
 				status = "okay";
-- 
2.8.1
