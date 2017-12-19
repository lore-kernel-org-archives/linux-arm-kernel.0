From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 19 Dec 2017 22:31:30 +0100
Subject: [PATCH 06/45] ARM: dts: at91: at91sam9260ek: use TCB0 as timers
In-Reply-To: <20171219213209.13823-1-alexandre.belloni@free-electrons.com>
References: <20171219213209.13823-1-alexandre.belloni@free-electrons.com>
Message-ID: <20171219213209.13823-7-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use tcb0 for timers as selected in at91_dt_defconfig.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/at91sam9260ek.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9260ek.dts b/arch/arm/boot/dts/at91sam9260ek.dts
index b2578feceb08..e16c706d91ef 100644
--- a/arch/arm/boot/dts/at91sam9260ek.dts
+++ b/arch/arm/boot/dts/at91sam9260ek.dts
@@ -69,6 +69,18 @@
 
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
-- 
2.15.1
