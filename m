From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 19 Dec 2017 22:31:32 +0100
Subject: [PATCH 08/45] ARM: dts: at91: ethernut5: use TCB0 as timers
In-Reply-To: <20171219213209.13823-1-alexandre.belloni@free-electrons.com>
References: <20171219213209.13823-1-alexandre.belloni@free-electrons.com>
Message-ID: <20171219213209.13823-9-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use tcb0 for timers as selected in at91_dt_defconfig.

Cc: Martin Reimann <martin.reimann@egnite.de>
Cc: Tim Schendekehl <tim.schendekehl@egnite.de>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/ethernut5.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/ethernut5.dts b/arch/arm/boot/dts/ethernut5.dts
index 123b203be06c..b554f85add41 100644
--- a/arch/arm/boot/dts/ethernut5.dts
+++ b/arch/arm/boot/dts/ethernut5.dts
@@ -36,6 +36,18 @@
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
 			usart0: serial at fffb0000 {
 				status = "okay";
 			};
-- 
2.15.1
