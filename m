From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 19 Dec 2017 22:31:58 +0100
Subject: [PATCH 34/45] ARM: dts: at91: kizbox2: use TCB0 as timers
In-Reply-To: <20171219213209.13823-1-alexandre.belloni@free-electrons.com>
References: <20171219213209.13823-1-alexandre.belloni@free-electrons.com>
Message-ID: <20171219213209.13823-35-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use tcb0 for timers as selected in sama5_defconfig.

Cc: Antoine Aubert <a.aubert@overkiz.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/at91-kizbox2.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/at91-kizbox2.dts b/arch/arm/boot/dts/at91-kizbox2.dts
index ec6c28c521a5..30041e8f12d5 100644
--- a/arch/arm/boot/dts/at91-kizbox2.dts
+++ b/arch/arm/boot/dts/at91-kizbox2.dts
@@ -94,6 +94,18 @@
 				};
 			};
 
+			tcb0: timer at f0010000 {
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
 			usart0: serial at f001c000 {
 				status = "okay";
 			};
-- 
2.15.1
