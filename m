From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 29 May 2015 19:47:14 +0200
Subject: [PATCH 01/16] ARM: at91/dt: at91sam9rl: fix rtc node
In-Reply-To: <1432921649-21943-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1432921649-21943-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1432921649-21943-2-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The RTC lives at 0xfffffe00. Also reorder the node properly.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/at91sam9rl.dtsi | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9rl.dtsi b/arch/arm/boot/dts/at91sam9rl.dtsi
index ebfd5ce9cb38..c9920c64791c 100644
--- a/arch/arm/boot/dts/at91sam9rl.dtsi
+++ b/arch/arm/boot/dts/at91sam9rl.dtsi
@@ -1065,13 +1065,6 @@
 				};
 			};
 
-			rtc at fffffeb0 {
-				compatible = "atmel,at91rm9200-rtc";
-				reg = <0xfffffeb0 0x40>;
-				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
-				status = "disabled";
-			};
-
 			rtc at fffffd20 {
 				compatible = "atmel,at91sam9260-rtt";
 				reg = <0xfffffd20 0x10>;
@@ -1085,6 +1078,14 @@
 				reg = <0xfffffd60 0x10>;
 				status = "disabled";
 			};
+
+			rtc at fffffe00 {
+				compatible = "atmel,at91rm9200-rtc";
+				reg = <0xfffffe00 0x40>;
+				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+				status = "disabled";
+			};
+
 		};
 	};
 
-- 
2.1.4
