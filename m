From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 30 May 2017 23:51:23 +0200
Subject: [PATCH 42/58] ARM: dts: at91: vinco: use TCB2 as clocksource
In-Reply-To: <20170530215139.9983-1-alexandre.belloni@free-electrons.com>
References: <20170530215139.9983-1-alexandre.belloni@free-electrons.com>
Message-ID: <20170530215139.9983-43-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As TCB2 doesn't have any output pins, use it as a clocksource.

Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/at91-vinco.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/at91-vinco.dts b/arch/arm/boot/dts/at91-vinco.dts
index e0c0b2897a49..d495a5e2aeac 100644
--- a/arch/arm/boot/dts/at91-vinco.dts
+++ b/arch/arm/boot/dts/at91-vinco.dts
@@ -151,6 +151,18 @@
 				status = "okay";
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
 			macb1: ethernet at fc028000 {
 				phy-mode = "rmii";
 				status = "okay";
-- 
2.11.0
