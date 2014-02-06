From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu,  6 Feb 2014 10:40:31 +0100
Subject: [PATCH v2 1/2] clocksource: sunxi: Add new compatibles
In-Reply-To: <1391679632-15139-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1391679632-15139-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1391679632-15139-2-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Allwinner A10 compatibles were following a slightly different compatible
patterns than the rest of the SoCs for historical reasons. Add compatibles
matching the other pattern to the timer driver for consistency, and keep the
older one for backward compatibility.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 Documentation/devicetree/bindings/timer/allwinner,sun4i-timer.txt | 4 ++--
 drivers/clocksource/sun4i_timer.c                                 | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/timer/allwinner,sun4i-timer.txt b/Documentation/devicetree/bindings/timer/allwinner,sun4i-timer.txt
index 48aeb78..5c2e235 100644
--- a/Documentation/devicetree/bindings/timer/allwinner,sun4i-timer.txt
+++ b/Documentation/devicetree/bindings/timer/allwinner,sun4i-timer.txt
@@ -2,7 +2,7 @@ Allwinner A1X SoCs Timer Controller
 
 Required properties:
 
-- compatible : should be "allwinner,sun4i-timer"
+- compatible : should be "allwinner,sun4i-a10-timer"
 - reg : Specifies base physical address and size of the registers.
 - interrupts : The interrupt of the first timer
 - clocks: phandle to the source clock (usually a 24 MHz fixed clock)
@@ -10,7 +10,7 @@ Required properties:
 Example:
 
 timer {
-	compatible = "allwinner,sun4i-timer";
+	compatible = "allwinner,sun4i-a10-timer";
 	reg = <0x01c20c00 0x400>;
 	interrupts = <22>;
 	clocks = <&osc>;
diff --git a/drivers/clocksource/sun4i_timer.c b/drivers/clocksource/sun4i_timer.c
index bf497af..efb17c3 100644
--- a/drivers/clocksource/sun4i_timer.c
+++ b/drivers/clocksource/sun4i_timer.c
@@ -196,5 +196,5 @@ static void __init sun4i_timer_init(struct device_node *node)
 	clockevents_config_and_register(&sun4i_clockevent, rate,
 					TIMER_SYNC_TICKS, 0xffffffff);
 }
-CLOCKSOURCE_OF_DECLARE(sun4i, "allwinner,sun4i-timer",
+CLOCKSOURCE_OF_DECLARE(sun4i, "allwinner,sun4i-a10-timer",
 		       sun4i_timer_init);
-- 
1.8.4.2
