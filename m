From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 23 Feb 2012 15:25:49 +0100
Subject: [PATCH v3 05/21] ARM: at91/ST: remove not needed casts
In-Reply-To: <cover.1330006537.git.nicolas.ferre@atmel.com>
References: <cover.1330006537.git.nicolas.ferre@atmel.com>
Message-ID: <9e1c0b2ee8ae69dd4b35187ffbfb749272db3e00.1330006537.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the unnecessary (void) cast on at91_st_read()
return value.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Acked-by: Ryan Mallon <rmallon@gmail.com>
---
 arch/arm/mach-at91/at91rm9200_time.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-at91/at91rm9200_time.c b/arch/arm/mach-at91/at91rm9200_time.c
index 0c1980c..dd7f782 100644
--- a/arch/arm/mach-at91/at91rm9200_time.c
+++ b/arch/arm/mach-at91/at91rm9200_time.c
@@ -111,7 +111,7 @@ clkevt32k_mode(enum clock_event_mode mode, struct clock_event_device *dev)
 {
 	/* Disable and flush pending timer interrupts */
 	at91_st_write(AT91_ST_IDR, AT91_ST_PITS | AT91_ST_ALMS);
-	(void) at91_st_read(AT91_ST_SR);
+	at91_st_read(AT91_ST_SR);
 
 	last_crtr = read_CRTR();
 	switch (mode) {
@@ -157,7 +157,7 @@ clkevt32k_next_event(unsigned long delta, struct clock_event_device *dev)
 
 	/* Cancel any pending alarm; flush any pending IRQ */
 	at91_st_write(AT91_ST_RTAR, alm);
-	(void) at91_st_read(AT91_ST_SR);
+	at91_st_read(AT91_ST_SR);
 
 	/* Schedule alarm by writing RTAR. */
 	alm += delta;
@@ -192,7 +192,7 @@ void __init at91rm9200_timer_init(void)
 	/* Disable all timer interrupts, and clear any pending ones */
 	at91_st_write(AT91_ST_IDR,
 		AT91_ST_PITS | AT91_ST_WDOVF | AT91_ST_RTTINC | AT91_ST_ALMS);
-	(void) at91_st_read(AT91_ST_SR);
+	at91_st_read(AT91_ST_SR);
 
 	/* Make IRQs happen for the system timer */
 	setup_irq(AT91_ID_SYS, &at91rm9200_timer_irq);
-- 
1.7.9
