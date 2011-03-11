From: pawel.moll@arm.com (Pawel Moll)
Date: Fri, 11 Mar 2011 16:29:27 +0000
Subject: [PATCH] arm: realview: Fix secondary GIC initialisation for EB with
	MPCore tile
Message-ID: <1299860967-31330-1-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The second GIC, present when EB board is used with a MPCore tile,
was initialised starting with irq number 64, which made interrupts
64-95 in the primary GIC unusable.

Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 arch/arm/mach-realview/realview_eb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-realview/realview_eb.c b/arch/arm/mach-realview/realview_eb.c
index 6ef5c5e..7b5557b 100644
--- a/arch/arm/mach-realview/realview_eb.c
+++ b/arch/arm/mach-realview/realview_eb.c
@@ -369,7 +369,7 @@ static void __init gic_init_irq(void)
 
 #ifndef CONFIG_REALVIEW_EB_ARM11MP_REVB
 		/* board GIC, secondary */
-		gic_init(1, 64, __io_address(REALVIEW_EB_GIC_DIST_BASE),
+		gic_init(1, 96, __io_address(REALVIEW_EB_GIC_DIST_BASE),
 			 __io_address(REALVIEW_EB_GIC_CPU_BASE));
 		gic_cascade_irq(1, IRQ_EB11MP_EB_IRQ1);
 #endif
-- 
1.6.3.3
