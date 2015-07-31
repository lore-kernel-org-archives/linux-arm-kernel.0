From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 31 Jul 2015 11:39:40 +0200
Subject: [PATCH 04/23] Documentation: dt: rtc: at91rm9200: add clocks property
In-Reply-To: <1438335599-3301-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1438335599-3301-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1438335599-3301-5-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The RTC needs an input clock, it is the slow clock. It is required as it
will not function without it.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: rtc-linux at googlegroups.com
 Documentation/devicetree/bindings/rtc/atmel,at91rm9200-rtc.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/rtc/atmel,at91rm9200-rtc.txt b/Documentation/devicetree/bindings/rtc/atmel,at91rm9200-rtc.txt
index 34c1505774bf..5d3791e789c6 100644
--- a/Documentation/devicetree/bindings/rtc/atmel,at91rm9200-rtc.txt
+++ b/Documentation/devicetree/bindings/rtc/atmel,at91rm9200-rtc.txt
@@ -5,6 +5,7 @@ Required properties:
 - reg: physical base address of the controller and length of memory mapped
   region.
 - interrupts: rtc alarm/event interrupt
+- clocks: phandle to input clock.
 
 Example:
 
@@ -12,4 +13,5 @@ rtc at fffffe00 {
 	compatible = "atmel,at91rm9200-rtc";
 	reg = <0xfffffe00 0x100>;
 	interrupts = <1 4 7>;
+	clocks = <&clk32k>;
 };
-- 
2.1.4
