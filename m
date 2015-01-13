From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 13 Jan 2015 19:12:21 +0100
Subject: [PATCH v3 1/6] ARM: at91/dt: at91sam9n12: Add RTC node
In-Reply-To: <1421172746-18727-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1421172746-18727-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1421172746-18727-2-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add node for the RTC available on the at91sam9n12.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 arch/arm/boot/dts/at91sam9n12.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9n12.dtsi b/arch/arm/boot/dts/at91sam9n12.dtsi
index 68eb9aded164..1d69db2e9e28 100644
--- a/arch/arm/boot/dts/at91sam9n12.dtsi
+++ b/arch/arm/boot/dts/at91sam9n12.dtsi
@@ -893,6 +893,13 @@
 				status = "disabled";
 			};
 
+			rtc at fffffeb0 {
+				compatible = "atmel,at91rm9200-rtc";
+				reg = <0xfffffeb0 0x40>;
+				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+				status = "disabled";
+			};
+
 			pwm0: pwm at f8034000 {
 				compatible = "atmel,at91sam9rl-pwm";
 				reg = <0xf8034000 0x300>;
-- 
2.1.0
