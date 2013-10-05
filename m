From: michael.opdenacker@free-electrons.com (Michael Opdenacker)
Date: Sat,  5 Oct 2013 06:06:04 +0200
Subject: [PATCH] ARM: gemini: remove obsolete IRQF_DISABLED
Message-ID: <1380945964-3086-1-git-send-email-michael.opdenacker@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch proposes to remove the use of the IRQF_DISABLED flag

It's a NOOP since 2.6.35 and it will be removed one day.

Signed-off-by: Michael Opdenacker <michael.opdenacker@free-electrons.com>
---
 arch/arm/mach-gemini/time.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-gemini/time.c b/arch/arm/mach-gemini/time.c
index 21dc5a8..cc996ec 100644
--- a/arch/arm/mach-gemini/time.c
+++ b/arch/arm/mach-gemini/time.c
@@ -45,7 +45,7 @@ static irqreturn_t gemini_timer_interrupt(int irq, void *dev_id)
 
 static struct irqaction gemini_timer_irq = {
 	.name		= "Gemini Timer Tick",
-	.flags		= IRQF_DISABLED | IRQF_TIMER,
+	.flags		= IRQF_TIMER,
 	.handler	= gemini_timer_interrupt,
 };
 
-- 
1.8.1.2
