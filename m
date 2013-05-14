From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 14 May 2013 17:38:50 +0200
Subject: [PATCH 17/20] ARM: sirf: Remove init_irq declaration in machine
 description
In-Reply-To: <1368545933-7430-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1368545933-7430-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1368545933-7430-18-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit ebafed7a ("ARM: irq: Call irqchip_init if no init_irq function is
specified") removed the need to explictly setup the init_irq field in
the machine description when using only irqchip_init. Remove that
declaration for sirf as well.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Acked-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/mach-prima2/common.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/mach-prima2/common.c b/arch/arm/mach-prima2/common.c
index 4f94cd8..a9f475c 100644
--- a/arch/arm/mach-prima2/common.c
+++ b/arch/arm/mach-prima2/common.c
@@ -9,7 +9,6 @@
 #include <linux/clocksource.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
-#include <linux/irqchip.h>
 #include <asm/sizes.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -55,7 +54,6 @@ DT_MACHINE_START(ATLAS6_DT, "Generic ATLAS6 (Flattened Device Tree)")
 	/* Maintainer: Barry Song <baohua.song@csr.com> */
 	.nr_irqs	= 128,
 	.map_io         = sirfsoc_map_io,
-	.init_irq	= irqchip_init,
 	.init_time	= sirfsoc_init_time,
 	.init_machine	= sirfsoc_mach_init,
 	.init_late	= sirfsoc_init_late,
@@ -74,7 +72,6 @@ DT_MACHINE_START(PRIMA2_DT, "Generic PRIMA2 (Flattened Device Tree)")
 	/* Maintainer: Barry Song <baohua.song@csr.com> */
 	.nr_irqs	= 128,
 	.map_io         = sirfsoc_map_io,
-	.init_irq	= irqchip_init,
 	.init_time	= sirfsoc_init_time,
 	.dma_zone_size	= SZ_256M,
 	.init_machine	= sirfsoc_mach_init,
@@ -94,7 +91,6 @@ DT_MACHINE_START(MARCO_DT, "Generic MARCO (Flattened Device Tree)")
 	/* Maintainer: Barry Song <baohua.song@csr.com> */
 	.smp            = smp_ops(sirfsoc_smp_ops),
 	.map_io         = sirfsoc_map_io,
-	.init_irq	= irqchip_init,
 	.init_time	= sirfsoc_init_time,
 	.init_machine	= sirfsoc_mach_init,
 	.init_late	= sirfsoc_init_late,
-- 
1.8.1.2
