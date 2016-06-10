From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Sat, 11 Jun 2016 00:03:36 +0200
Subject: [PATCH 33/48] ARM: dts: at91: kizbox2: use TCB0 as clocksource
In-Reply-To: <1465596231-21766-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1465596231-21766-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1465596231-21766-34-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use tcb0 as the clocksource like previously selected in sama5_defconfig.

Cc: Antoine Aubert <a.aubert@overkiz.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/at91-kizbox2.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/at91-kizbox2.dts b/arch/arm/boot/dts/at91-kizbox2.dts
index 50a14568f094..03c47eab3771 100644
--- a/arch/arm/boot/dts/at91-kizbox2.dts
+++ b/arch/arm/boot/dts/at91-kizbox2.dts
@@ -94,6 +94,18 @@
 				};
 			};
 
+			tcb0: timer at f0010000 {
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
 			usart0: serial at f001c000 {
 				status = "okay";
 			};
-- 
2.8.1
