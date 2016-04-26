From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 26 Apr 2016 13:38:12 +0200
Subject: [PATCH] ARM: dts: at91: sama5d4: add watchdog interrupt property
Message-ID: <1461670692-11741-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The "interrupts" property is missing from the watchdog node. Add it with
highest priority value of 7.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/sama5d4.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5d4.dtsi
index db1151c18466..058e56e431cd 100644
--- a/arch/arm/boot/dts/sama5d4.dtsi
+++ b/arch/arm/boot/dts/sama5d4.dtsi
@@ -1302,6 +1302,7 @@
 			watchdog at fc068640 {
 				compatible = "atmel,sama5d4-wdt";
 				reg = <0xfc068640 0x10>;
+				interrupts = <4 IRQ_TYPE_LEVEL_HIGH 7>;
 				clocks = <&clk32k>;
 				status = "disabled";
 			};
-- 
2.1.3
