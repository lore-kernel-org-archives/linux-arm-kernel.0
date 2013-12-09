From: michael.opdenacker@free-electrons.com (Michael Opdenacker)
Date: Mon,  9 Dec 2013 06:10:10 +0100
Subject: [PATCH][RESEND] ARM: w90x900: remove deprecated IRQF_DISABLED
In-Reply-To: <CAKT61h8QGU0ZZhms9WgMmyWhEmB_odTOfD0guihf6TfRpZ2YUw@mail.gmail.com>
References: <CAKT61h8QGU0ZZhms9WgMmyWhEmB_odTOfD0guihf6TfRpZ2YUw@mail.gmail.com>
Message-ID: <1386565810-19467-1-git-send-email-michael.opdenacker@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch proposes to remove the use of the IRQF_DISABLED flag

It's a NOOP since 2.6.35 and it will be removed one day.

Signed-off-by: Michael Opdenacker <michael.opdenacker@free-electrons.com>
Acked-by: Wan zongshun <mcuos.com@gmail.com>
---
 arch/arm/mach-w90x900/time.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-w90x900/time.c b/arch/arm/mach-w90x900/time.c
index 30fbca844575..9230d3725599 100644
--- a/arch/arm/mach-w90x900/time.c
+++ b/arch/arm/mach-w90x900/time.c
@@ -111,7 +111,7 @@ static irqreturn_t nuc900_timer0_interrupt(int irq, void *dev_id)
 
 static struct irqaction nuc900_timer0_irq = {
 	.name		= "nuc900-timer0",
-	.flags		= IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
+	.flags		= IRQF_TIMER | IRQF_IRQPOLL,
 	.handler	= nuc900_timer0_interrupt,
 };
 
-- 
1.8.3.2
