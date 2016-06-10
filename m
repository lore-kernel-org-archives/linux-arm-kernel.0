From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Sat, 11 Jun 2016 00:03:40 +0200
Subject: [PATCH 37/48] ARM: dts: at91: sama5d4 Xplained: use TCB2 as
 clocksource
In-Reply-To: <1465596231-21766-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1465596231-21766-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1465596231-21766-38-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As TCB2 doesn't have any output pins, use it as a clocksource.

Tested-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/at91-sama5d4_xplained.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/at91-sama5d4_xplained.dts b/arch/arm/boot/dts/at91-sama5d4_xplained.dts
index da84e65b56ef..c0be79d5cf50 100644
--- a/arch/arm/boot/dts/at91-sama5d4_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d4_xplained.dts
@@ -122,6 +122,18 @@
 				status = "okay";
 			};
 
+			tcb2: timer at fc024000 {
+				timer at 0 {
+					compatible = "atmel,tcb-clksrc";
+					reg = <0>;
+				};
+
+				timer at 1 {
+					compatible = "atmel,tcb-clkevt";
+					reg = <1>;
+				};
+			};
+
 			adc0: adc at fc034000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <
-- 
2.8.1
