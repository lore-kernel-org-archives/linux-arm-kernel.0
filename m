From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Sat, 11 Jun 2016 00:03:23 +0200
Subject: [PATCH 20/48] ARM: dts: at91: pm9g45: use TCB0 as clocksource
In-Reply-To: <1465596231-21766-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1465596231-21766-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1465596231-21766-21-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use tcb0 as the clocksource like previously selected in at91_dt_defconfig.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/pm9g45.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/pm9g45.dts b/arch/arm/boot/dts/pm9g45.dts
index 66afcff67fde..5d5ccefa8644 100644
--- a/arch/arm/boot/dts/pm9g45.dts
+++ b/arch/arm/boot/dts/pm9g45.dts
@@ -63,6 +63,18 @@
 				};
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
 			mmc0: mmc at fff80000 {
 				pinctrl-0 = <
 					&pinctrl_board_mmc
-- 
2.8.1
