From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  4 Nov 2014 10:50:07 +0900
Subject: [PATCH 2/4] ARM: shmobile: sh7372: Add shmobile_init_late()
In-Reply-To: <cover.1415058939.git.horms+renesas@verge.net.au>
References: <cover.1415058939.git.horms+renesas@verge.net.au>
Message-ID: <27c1bb20d45830a64bf344cc1cb5e0a745e2d206.1415058939.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Extend sh7372 SoC machine vector to include shmobile_init_late()
so Suspend-to-RAM and CPUIdle are setup as expected.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-sh7372.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-shmobile/setup-sh7372.c b/arch/arm/mach-shmobile/setup-sh7372.c
index d646c8d..769ff00 100644
--- a/arch/arm/mach-shmobile/setup-sh7372.c
+++ b/arch/arm/mach-shmobile/setup-sh7372.c
@@ -1012,6 +1012,7 @@ DT_MACHINE_START(SH7372_DT, "Generic SH7372 (Flattened Device Tree)")
 	.init_irq	= sh7372_init_irq,
 	.handle_irq	= shmobile_handle_irq_intc,
 	.init_machine	= sh7372_add_standard_devices_dt,
+	.init_late	= shmobile_init_late,
 	.dt_compat	= sh7372_boards_compat_dt,
 MACHINE_END
 
-- 
2.1.1
