From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 30 May 2017 23:50:44 +0200
Subject: [PATCH 03/58] ARM: dts: at91: at91rm9200ek: use TCB0 as clocksource
In-Reply-To: <20170530215139.9983-1-alexandre.belloni@free-electrons.com>
References: <20170530215139.9983-1-alexandre.belloni@free-electrons.com>
Message-ID: <20170530215139.9983-4-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use tcb0 as the clocksource like previously selected in at91_dt_defconfig.

Tested-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/at91rm9200ek.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/at91rm9200ek.dts b/arch/arm/boot/dts/at91rm9200ek.dts
index f90e1c2d3caa..a446e12cbaa8 100644
--- a/arch/arm/boot/dts/at91rm9200ek.dts
+++ b/arch/arm/boot/dts/at91rm9200ek.dts
@@ -32,6 +32,18 @@
 
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
 			usb1: gadget at fffb0000 {
 				atmel,vbus-gpio = <&pioD 4 GPIO_ACTIVE_HIGH>;
 				atmel,pullup-gpio = <&pioD 5 GPIO_ACTIVE_HIGH>;
-- 
2.11.0
