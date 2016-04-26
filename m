From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 26 Apr 2016 15:11:47 +0200
Subject: [PATCH] ARM: dts: at91: sama5d2: add slow clock to watchdog node
Message-ID: <1461676307-16059-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the watchdog timer needs the slow clock, add it to the currently defined
wdt node.

Reported-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/sama5d2.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
index 43015c2ad395..84eed47ffb0a 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -1050,6 +1050,7 @@
 				compatible = "atmel,sama5d4-wdt";
 				reg = <0xf8048040 0x10>;
 				interrupts = <4 IRQ_TYPE_LEVEL_HIGH 7>;
+				clocks = <&clk32k>;
 				status = "disabled";
 			};
 
-- 
2.1.3
