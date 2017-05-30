From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 30 May 2017 23:51:22 +0200
Subject: [PATCH 41/58] ARM: dts: at91: ma5d4: use TCB2 as clocksource
In-Reply-To: <20170530215139.9983-1-alexandre.belloni@free-electrons.com>
References: <20170530215139.9983-1-alexandre.belloni@free-electrons.com>
Message-ID: <20170530215139.9983-42-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As TCB2 doesn't have any output pins, use it as a clocksource.

Cc: Marek Vasut <marex@denx.de>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/at91-sama5d4_ma5d4.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/at91-sama5d4_ma5d4.dtsi b/arch/arm/boot/dts/at91-sama5d4_ma5d4.dtsi
index b5a5a91bc2ef..cfe1d21ed4db 100644
--- a/arch/arm/boot/dts/at91-sama5d4_ma5d4.dtsi
+++ b/arch/arm/boot/dts/at91-sama5d4_ma5d4.dtsi
@@ -89,6 +89,18 @@
 				};
 			};
 
+			tcb2: timer at fc024000 {
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
 			adc0: adc at fc034000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <
-- 
2.11.0
