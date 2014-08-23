From: horms+renesas@verge.net.au (Simon Horman)
Date: Sat, 23 Aug 2014 10:43:36 +0900
Subject: [PATCH 7/8] ARM: shmobile: kzm9g: Remove unneeded nr_irqs
 initialization
In-Reply-To: <cover.1408671094.git.horms+renesas@verge.net.au>
References: <cover.1408671094.git.horms+renesas@verge.net.au>
Message-ID: <f185a01b3877880135ea73ddfcec52bd9a4d4864.1408671094.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

As per arch_probe_nr_irqs(), the default value is NR_IRQS, which maps to
NR_IRQS_LEGACY if CONFIG_SPARSE_IRQ=y.

Since SPARSE_IRQ is selected by both ARCH_MULTIPLATFORM and
ARCH_SHMOBILE_LEGACY, it's always enabled on shmobile.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-kzm9g.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/board-kzm9g.c b/arch/arm/mach-shmobile/board-kzm9g.c
index f8bc7f8..36593cb 100644
--- a/arch/arm/mach-shmobile/board-kzm9g.c
+++ b/arch/arm/mach-shmobile/board-kzm9g.c
@@ -910,7 +910,6 @@ DT_MACHINE_START(KZM9G_DT, "kzm9g")
 	.smp		= smp_ops(sh73a0_smp_ops),
 	.map_io		= sh73a0_map_io,
 	.init_early	= sh73a0_add_early_devices,
-	.nr_irqs	= NR_IRQS_LEGACY,
 	.init_irq	= sh73a0_init_irq,
 	.init_machine	= kzm_init,
 	.init_late	= shmobile_init_late,
-- 
2.0.1
