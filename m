From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 19 Feb 2013 11:56:07 +0900
Subject: [PATCH 2/5] ARM: shmobile: marzen: Do not use early devices
In-Reply-To: <1361242570-8867-1-git-send-email-horms+renesas@verge.net.au>
References: <1361242570-8867-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1361242570-8867-3-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Do not initialise any early devices when using the minimal DT reference
code. Only the delay needs to be initialised.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-marzen-reference.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/board-marzen-reference.c b/arch/arm/mach-shmobile/board-marzen-reference.c
index 47df64d..a126f07 100644
--- a/arch/arm/mach-shmobile/board-marzen-reference.c
+++ b/arch/arm/mach-shmobile/board-marzen-reference.c
@@ -63,7 +63,7 @@ static const char *marzen_boards_compat_dt[] __initdata = {
 DT_MACHINE_START(MARZEN, "marzen")
 	.smp		= smp_ops(r8a7779_smp_ops),
 	.map_io		= r8a7779_map_io,
-	.init_early	= r8a7779_add_early_devices_dt,
+	.init_early	= r8a7779_init_delay,
 	.nr_irqs	= NR_IRQS_LEGACY,
 	.init_irq	= r8a7779_init_irq_dt,
 	.init_machine	= marzen_init,
-- 
1.7.10.4
