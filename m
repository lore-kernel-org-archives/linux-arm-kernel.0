From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Sat, 11 Jun 2016 00:03:08 +0200
Subject: [PATCH 05/48] ARM: dts: at91: mpa1600; use TCB0 as clocksource
In-Reply-To: <1465596231-21766-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1465596231-21766-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1465596231-21766-6-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use tcb0 as the clocksource like previously selected in at91_dt_defconfig.

Cc: Joachim Eastwood <manabian@gmail.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/mpa1600.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/mpa1600.dts b/arch/arm/boot/dts/mpa1600.dts
index f0f5e1098928..d1c3ec1db086 100644
--- a/arch/arm/boot/dts/mpa1600.dts
+++ b/arch/arm/boot/dts/mpa1600.dts
@@ -41,6 +41,18 @@
 				status = "okay";
 			};
 
+			tcb0: timer at fffa0000 {
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
 			macb0: ethernet at fffbc000 {
 				phy-mode = "rmii";
 				status = "okay";
-- 
2.8.1
