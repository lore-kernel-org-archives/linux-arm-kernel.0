From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Sat, 11 Jun 2016 00:03:27 +0200
Subject: [PATCH 24/48] ARM: dts: at91: at91sam9n12ek: use TCB0 as clocksource
In-Reply-To: <1465596231-21766-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1465596231-21766-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1465596231-21766-25-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use tcb0 as the clocksource like previously selected in at91_dt_defconfig.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/at91sam9n12ek.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9n12ek.dts b/arch/arm/boot/dts/at91sam9n12ek.dts
index 626c67d66626..3491db62d6b3 100644
--- a/arch/arm/boot/dts/at91sam9n12ek.dts
+++ b/arch/arm/boot/dts/at91sam9n12ek.dts
@@ -42,6 +42,18 @@
 				status = "okay";
 			};
 
+			tcb0: timer at f8008000 {
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
 			i2c0: i2c at f8010000 {
 				status = "okay";
 
-- 
2.8.1
