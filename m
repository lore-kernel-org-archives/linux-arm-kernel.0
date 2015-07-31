From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Sat,  1 Aug 2015 00:58:29 +0200
Subject: [PATCH 8/9] ARM: at91/dt: at91sam9x5dm: add support for the
 touschscreen
In-Reply-To: <1438383510-10521-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1438383510-10521-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1438383510-10521-9-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The display module on the at91sam9x5-ek has a resistive touchscreen, add
it.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/at91sam9x5dm.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9x5dm.dtsi b/arch/arm/boot/dts/at91sam9x5dm.dtsi
index 31676f1b6e31..3e6b4a042186 100644
--- a/arch/arm/boot/dts/at91sam9x5dm.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5dm.dtsi
@@ -25,6 +25,12 @@
 					};
 				};
 			};
+
+			adc0: adc at f804c000 {
+				atmel,adc-ts-wires = <4>;
+				atmel,adc-ts-pressure-threshold = <10000>;
+				status = "okay";
+			};
 		};
 	};
 
-- 
2.1.4
