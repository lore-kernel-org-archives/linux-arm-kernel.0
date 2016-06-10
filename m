From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Sat, 11 Jun 2016 00:03:19 +0200
Subject: [PATCH 16/48] ARM: dts: at91: at91sam9263ek: use TCB0 as clocksource
In-Reply-To: <1465596231-21766-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1465596231-21766-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1465596231-21766-17-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use tcb0 as the clocksource like previously selected in at91_dt_defconfig.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/at91sam9263ek.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9263ek.dts b/arch/arm/boot/dts/at91sam9263ek.dts
index 59df9d73d276..e3b51e8d01bb 100644
--- a/arch/arm/boot/dts/at91sam9263ek.dts
+++ b/arch/arm/boot/dts/at91sam9263ek.dts
@@ -37,6 +37,18 @@
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
 			usart0: serial at fff8c000 {
 				pinctrl-0 = <
 					&pinctrl_usart0
-- 
2.8.1
