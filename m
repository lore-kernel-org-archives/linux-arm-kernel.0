From: nicolas.ferre@microchip.com (Nicolas Ferre)
Date: Wed, 20 Dec 2017 10:04:40 +0100
Subject: [PATCH] ARM: dts: at91: sama5d2_ptc_ek: use TCB0 as timers
In-Reply-To: <20171219213209.13823-1-alexandre.belloni@free-electrons.com>
References: <20171219213209.13823-1-alexandre.belloni@free-electrons.com>
Message-ID: <20171220090440.18153-1-nicolas.ferre@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use tcb0 for timers as selected in sama5_defconfig.

Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
Hi Alex,

Adding the newly added sama5d2_ptc_ek to the series.
Not tested though.

Regards,
  Nicolas

 arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts b/arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts
index 186cb03e2672..e603a267bdf1 100644
--- a/arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts
@@ -149,6 +149,18 @@
 				};
 			};
 
+			tcb0: timer at f800c000 {
+				timer0: timer at 0 {
+					compatible = "atmel,tcb-timer";
+					reg = <0>;
+				};
+
+				timer1: timer at 1 {
+					compatible = "atmel,tcb-timer";
+					reg = <1>;
+				};
+			};
+
 			uart0: serial at f801c000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_uart0_default>;
-- 
2.9.0
