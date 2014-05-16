From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 May 2014 09:58:49 +0900
Subject: [PATCH 8/9] ARM: shmobile: Use shmobile_init_late() on r8a7740
In-Reply-To: <cover.1400200838.git.horms+renesas@verge.net.au>
References: <cover.1400200838.git.horms+renesas@verge.net.au>
Message-ID: <34b9fa401eeef4e388bb7563110733c73c452c80.1400200838.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Hook up ->init_late for r8a7740 to initialize Suspend-to-RAM
and CPUIdle in case of C-code less board support for r8a7740.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-r8a7740.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-shmobile/setup-r8a7740.c b/arch/arm/mach-shmobile/setup-r8a7740.c
index eaec043..7bdc51c 100644
--- a/arch/arm/mach-shmobile/setup-r8a7740.c
+++ b/arch/arm/mach-shmobile/setup-r8a7740.c
@@ -933,6 +933,7 @@ DT_MACHINE_START(R8A7740_DT, "Generic R8A7740 (Flattened Device Tree)")
 	.init_early	= shmobile_init_delay,
 	.init_irq	= r8a7740_init_irq_of,
 	.init_machine	= r8a7740_generic_init,
+	.init_late	= shmobile_init_late,
 	.dt_compat	= r8a7740_boards_compat_dt,
 MACHINE_END
 
-- 
1.8.5.2
