From: michael.opdenacker@free-electrons.com (Michael Opdenacker)
Date: Mon,  9 Dec 2013 06:06:59 +0100
Subject: [PATCH][RESEND] ARM: spear: remove deprecated IRQF_DISABLED
In-Reply-To: <1381549256-5301-1-git-send-email-michael.opdenacker@free-electrons.com>
References: <1381549256-5301-1-git-send-email-michael.opdenacker@free-electrons.com>
Message-ID: <1386565619-19355-1-git-send-email-michael.opdenacker@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch proposes to remove the use of the IRQF_DISABLED flag

It's a NOOP since 2.6.35 and it will be removed one day.

Signed-off-by: Michael Opdenacker <michael.opdenacker@free-electrons.com>
---
 arch/arm/mach-spear/time.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-spear/time.c b/arch/arm/mach-spear/time.c
index d449673e40f7..218ba5b67d92 100644
--- a/arch/arm/mach-spear/time.c
+++ b/arch/arm/mach-spear/time.c
@@ -172,7 +172,7 @@ static irqreturn_t spear_timer_interrupt(int irq, void *dev_id)
 
 static struct irqaction spear_timer_irq = {
 	.name = "timer",
-	.flags = IRQF_DISABLED | IRQF_TIMER,
+	.flags = IRQF_TIMER,
 	.handler = spear_timer_interrupt
 };
 
-- 
1.8.3.2
