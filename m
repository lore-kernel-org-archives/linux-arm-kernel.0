From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon,  8 Aug 2016 15:33:52 +0200
Subject: [PATCH v2 3/4] clocksource: timer-atmel-pit: remove uselesss
 WARN_ON_ONCE
In-Reply-To: <1470663233-15118-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1470663233-15118-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1470663233-15118-4-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

IRQ handlers are running with IRQ disabled for a while, remove wrong
comment and useless test.

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/clocksource/timer-atmel-pit.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/clocksource/timer-atmel-pit.c b/drivers/clocksource/timer-atmel-pit.c
index 6767768a7849..af657fdce665 100644
--- a/drivers/clocksource/timer-atmel-pit.c
+++ b/drivers/clocksource/timer-atmel-pit.c
@@ -149,12 +149,6 @@ static irqreturn_t at91sam926x_pit_interrupt(int irq, void *dev_id)
 {
 	struct pit_data *data = dev_id;
 
-	/*
-	 * irqs should be disabled here, but as the irq is shared they are only
-	 * guaranteed to be off if the timer irq is registered first.
-	 */
-	WARN_ON_ONCE(!irqs_disabled());
-
 	/* The PIT interrupt may be disabled, and is shared */
 	if (clockevent_state_periodic(&data->clkevt) &&
 	    (pit_read(data->base, AT91_PIT_SR) & AT91_PIT_PITS)) {
-- 
2.8.1
