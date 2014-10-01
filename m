From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed,  1 Oct 2014 18:41:32 +0200
Subject: [PATCH] ARM: at91/dt: at91sam9rl: add rtc
Message-ID: <1412181692-21138-1-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add rtc support to the at91sam9rl dtsi file.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/at91sam9rl.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9rl.dtsi b/arch/arm/boot/dts/at91sam9rl.dtsi
index ab56c8b81dfa..984468a56fa4 100644
--- a/arch/arm/boot/dts/at91sam9rl.dtsi
+++ b/arch/arm/boot/dts/at91sam9rl.dtsi
@@ -1059,6 +1059,13 @@
 					clocks = <&slow_rc_osc &slow_osc>;
 				};
 			};
+
+			rtc at fffffeb0 {
+				compatible = "atmel,at91rm9200-rtc";
+				reg = <0xfffffeb0 0x40>;
+				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+				status = "disabled";
+			};
 		};
 	};
 
-- 
1.9.1
