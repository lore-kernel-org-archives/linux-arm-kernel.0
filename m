From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 19 Dec 2017 22:31:42 +0100
Subject: [PATCH 18/45] ARM: dts: at91: calao: use TCB0 as timers
In-Reply-To: <20171219213209.13823-1-alexandre.belloni@free-electrons.com>
References: <20171219213209.13823-1-alexandre.belloni@free-electrons.com>
Message-ID: <20171219213209.13823-19-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use tcb0 for timers as selected in at91_dt_defconfig.

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
index f46352790a41..72e9148ca096 100644
--- a/arch/arm/boot/dts/at91-qil_a9260.dts
+++ b/arch/arm/boot/dts/at91-qil_a9260.dts
@@ -31,6 +31,18 @@
 
 	ahb {
 		apb {
+			tcb0: timer at fffa0000 {
+				timer at 0 {
+					compatible = "atmel,tcb-timer";
+					reg = <0>, <1>;
+				};
+
+				timer at 2 {
+					compatible = "atmel,tcb-timer";
+					reg = <2>;
+				};
+			};
+
 			usb1: gadget at fffa4000 {
 				atmel,vbus-gpio = <&pioC 5 GPIO_ACTIVE_HIGH>;
 				status = "okay";
diff --git a/arch/arm/boot/dts/tny_a9260_common.dtsi b/arch/arm/boot/dts/tny_a9260_common.dtsi
index 5d83df4675a1..8e3cf5109f98 100644
--- a/arch/arm/boot/dts/tny_a9260_common.dtsi
+++ b/arch/arm/boot/dts/tny_a9260_common.dtsi
@@ -27,6 +27,18 @@
 
 	ahb {
 		apb {
+			tcb0: timer at fffa0000 {
+				timer at 0 {
+					compatible = "atmel,tcb-timer";
+					reg = <0>, <1>;
+				};
+
+				timer at 2 {
+					compatible = "atmel,tcb-timer";
+					reg = <2>;
+				};
+			};
+
 			dbgu: serial at fffff200 {
 				status = "okay";
 			};
diff --git a/arch/arm/boot/dts/tny_a9263.dts b/arch/arm/boot/dts/tny_a9263.dts
index 8cf0a9e08571..7b403db4cd34 100644
--- a/arch/arm/boot/dts/tny_a9263.dts
+++ b/arch/arm/boot/dts/tny_a9263.dts
@@ -36,6 +36,18 @@
 				status = "okay";
 			};
 
+			tcb0: timer at fff7c000 {
+				timer at 0 {
+					compatible = "atmel,tcb-timer";
+					reg = <0>, <1>;
+				};
+
+				timer at 2 {
+					compatible = "atmel,tcb-timer";
+					reg = <2>;
+				};
+			};
+
 			usb1: gadget at fff78000 {
 				atmel,vbus-gpio = <&pioB 11 GPIO_ACTIVE_HIGH>;
 				status = "okay";
diff --git a/arch/arm/boot/dts/usb_a9260_common.dtsi b/arch/arm/boot/dts/usb_a9260_common.dtsi
index 34a49995eda3..de3fa3ab34d6 100644
--- a/arch/arm/boot/dts/usb_a9260_common.dtsi
+++ b/arch/arm/boot/dts/usb_a9260_common.dtsi
@@ -23,6 +23,18 @@
 				status = "okay";
 			};
 
+			tcb0: timer at fffa0000 {
+				timer at 0 {
+					compatible = "atmel,tcb-timer";
+					reg = <0>, <1>;
+				};
+
+				timer at 2 {
+					compatible = "atmel,tcb-timer";
+					reg = <2>;
+				};
+			};
+
 			macb0: ethernet at fffc4000 {
 				phy-mode = "rmii";
 				status = "okay";
diff --git a/arch/arm/boot/dts/usb_a9263.dts b/arch/arm/boot/dts/usb_a9263.dts
index 7b1125be99c4..0a753b4c74e7 100644
--- a/arch/arm/boot/dts/usb_a9263.dts
+++ b/arch/arm/boot/dts/usb_a9263.dts
@@ -36,6 +36,18 @@
 				status = "okay";
 			};
 
+			tcb0: timer at fff7c000 {
+				timer at 0 {
+					compatible = "atmel,tcb-timer";
+					reg = <0>, <1>;
+				};
+
+				timer at 2 {
+					compatible = "atmel,tcb-timer";
+					reg = <2>;
+				};
+			};
+
 			macb0: ethernet at fffbc000 {
 				phy-mode = "rmii";
 				status = "okay";
-- 
2.15.1
