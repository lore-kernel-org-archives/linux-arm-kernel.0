From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 30 May 2017 23:51:08 +0200
Subject: [PATCH 27/58] ARM: dts: at91: at91sam9x5cm: use TCB0 as clocksource
In-Reply-To: <20170530215139.9983-1-alexandre.belloni@free-electrons.com>
References: <20170530215139.9983-1-alexandre.belloni@free-electrons.com>
Message-ID: <20170530215139.9983-28-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use tcb0 as the clocksource like previously selected in at91_dt_defconfig.

[tested on at91sam9x25ek and at91sam9x35ek]
Tested-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/at91sam9x5cm.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9x5cm.dtsi b/arch/arm/boot/dts/at91sam9x5cm.dtsi
index b098ad8cd93a..9110bcafb322 100644
--- a/arch/arm/boot/dts/at91sam9x5cm.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5cm.dtsi
@@ -24,6 +24,18 @@
 
 	ahb {
 		apb {
+			tcb0: timer at f8008000 {
+				timer at 0 {
+					compatible = "atmel,tcb-timer";
+					reg = <0>;
+				};
+
+				timer at 1 {
+					compatible = "atmel,tcb-timer";
+					reg = <1>;
+				};
+			};
+
 			pinctrl at fffff400 {
 				1wire_cm {
 					pinctrl_1wire_cm: 1wire_cm-0 {
-- 
2.11.0
