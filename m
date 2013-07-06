From: michael.opdenacker@free-electrons.com (Michael Opdenacker)
Date: Sat,  6 Jul 2013 07:15:30 +0200
Subject: [PATCH] ARM: at91: remove IRQF_DISABLED
Message-ID: <1373087730-19917-1-git-send-email-michael.opdenacker@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This flag is a NOOP since 2.6.36 and can be removed.

Signed-off-by: Michael Opdenacker <michael.opdenacker@free-electrons.com>
---
 arch/arm/mach-at91/at91rm9200_time.c  | 2 +-
 arch/arm/mach-at91/at91sam926x_time.c | 2 +-
 arch/arm/mach-at91/at91x40_time.c     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-at91/at91rm9200_time.c b/arch/arm/mach-at91/at91rm9200_time.c
index 180b302..f607deb 100644
--- a/arch/arm/mach-at91/at91rm9200_time.c
+++ b/arch/arm/mach-at91/at91rm9200_time.c
@@ -93,7 +93,7 @@ static irqreturn_t at91rm9200_timer_interrupt(int irq, void *dev_id)
 
 static struct irqaction at91rm9200_timer_irq = {
 	.name		= "at91_tick",
-	.flags		= IRQF_SHARED | IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
+	.flags		= IRQF_SHARED | IRQF_TIMER | IRQF_IRQPOLL,
 	.handler	= at91rm9200_timer_interrupt,
 	.irq		= NR_IRQS_LEGACY + AT91_ID_SYS,
 };
diff --git a/arch/arm/mach-at91/at91sam926x_time.c b/arch/arm/mach-at91/at91sam926x_time.c
index 3a4bc2e..bb39232 100644
--- a/arch/arm/mach-at91/at91sam926x_time.c
+++ b/arch/arm/mach-at91/at91sam926x_time.c
@@ -171,7 +171,7 @@ static irqreturn_t at91sam926x_pit_interrupt(int irq, void *dev_id)
 
 static struct irqaction at91sam926x_pit_irq = {
 	.name		= "at91_tick",
-	.flags		= IRQF_SHARED | IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
+	.flags		= IRQF_SHARED | IRQF_TIMER | IRQF_IRQPOLL,
 	.handler	= at91sam926x_pit_interrupt,
 	.irq		= NR_IRQS_LEGACY + AT91_ID_SYS,
 };
diff --git a/arch/arm/mach-at91/at91x40_time.c b/arch/arm/mach-at91/at91x40_time.c
index 2919eba..c0e637a 100644
--- a/arch/arm/mach-at91/at91x40_time.c
+++ b/arch/arm/mach-at91/at91x40_time.c
@@ -57,7 +57,7 @@ static irqreturn_t at91x40_timer_interrupt(int irq, void *dev_id)
 
 static struct irqaction at91x40_timer_irq = {
 	.name		= "at91_tick",
-	.flags		= IRQF_DISABLED | IRQF_TIMER,
+	.flags		= IRQF_TIMER,
 	.handler	= at91x40_timer_interrupt
 };
 
-- 
1.8.1.2
