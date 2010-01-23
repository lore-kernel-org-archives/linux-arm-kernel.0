From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Sat, 23 Jan 2010 22:01:39 +0100
Subject: [PATCH 1/2] ARM: ixp2000: fix type of ixp2000_timer_interrupt
Message-ID: <1264280500-22878-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes a build warning for 2.6.33-rc5:

	arch/arm/mach-ixp2000/core.c:217: warning: initialization from incompatible pointer type

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-ixp2000/core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-ixp2000/core.c b/arch/arm/mach-ixp2000/core.c
index babb225..e24e3d0 100644
--- a/arch/arm/mach-ixp2000/core.c
+++ b/arch/arm/mach-ixp2000/core.c
@@ -197,7 +197,7 @@ unsigned long ixp2000_gettimeoffset (void)
 	return offset / ticks_per_usec;
 }
 
-static int ixp2000_timer_interrupt(int irq, void *dev_id)
+static irqreturn_t ixp2000_timer_interrupt(int irq, void *dev_id)
 {
 	/* clear timer 1 */
 	ixp2000_reg_wrb(IXP2000_T1_CLR, 1);
-- 
1.6.6
