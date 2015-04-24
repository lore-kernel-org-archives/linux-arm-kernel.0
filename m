From: eric@anholt.net (Eric Anholt)
Date: Fri, 24 Apr 2015 12:08:53 -0700
Subject: [PATCH 1/2] ARM: BCM2835: Drop the init_irq() hook.
Message-ID: <1429902534-2348-1-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the default function that gets called if the hook is NULL.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 arch/arm/mach-bcm/board_bcm2835.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-bcm/board_bcm2835.c b/arch/arm/mach-bcm/board_bcm2835.c
index 9851ee8..49dd5b0 100644
--- a/arch/arm/mach-bcm/board_bcm2835.c
+++ b/arch/arm/mach-bcm/board_bcm2835.c
@@ -113,7 +113,6 @@ static const char * const bcm2835_compat[] = {
 };
 
 DT_MACHINE_START(BCM2835, "BCM2835")
-	.init_irq = irqchip_init,
 	.init_machine = bcm2835_init,
 	.restart = bcm2835_restart,
 	.dt_compat = bcm2835_compat
-- 
2.1.4
