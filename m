From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 31 Jul 2015 11:39:39 +0200
Subject: [PATCH 03/23] Documentation: watchdog: at91sam9_wdt: add clocks
 property
In-Reply-To: <1438335599-3301-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1438335599-3301-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1438335599-3301-4-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The watchdog has an input clock, the slow clock. It is required as it will
not function without it.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---
Cc: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog at vger.kernel.org
 Documentation/devicetree/bindings/watchdog/atmel-wdt.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt b/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt
index a4d869744f59..86fa6de1019b 100644
--- a/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt
@@ -6,6 +6,7 @@ Required properties:
 - compatible: must be "atmel,at91sam9260-wdt".
 - reg: physical base address of the controller and length of memory mapped
   region.
+- clocks: phandle to input clock.
 
 Optional properties:
 - timeout-sec: contains the watchdog timeout in seconds.
@@ -39,6 +40,7 @@ Example:
 		compatible = "atmel,at91sam9260-wdt";
 		reg = <0xfffffd40 0x10>;
 		interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+		clocks = <&clk32k>;
 		timeout-sec = <15>;
 		atmel,watchdog-type = "hardware";
 		atmel,reset-type = "all";
-- 
2.1.4
