From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 14 May 2013 17:38:44 +0200
Subject: [PATCH 11/20] ARM: shmobile: sh73a0: Remove init_irq declaration in
 machine description
In-Reply-To: <1368545933-7430-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1368545933-7430-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1368545933-7430-12-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit ebafed7a ("ARM: irq: Call irqchip_init if no init_irq function is
specified") removed the need to explictly setup the init_irq field in
the machine description when using only irqchip_init. Remove that
declaration for shmobile as well.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/mach-shmobile/setup-sh73a0.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-sh73a0.c b/arch/arm/mach-shmobile/setup-sh73a0.c
index fdf3894..73dd75b 100644
--- a/arch/arm/mach-shmobile/setup-sh73a0.c
+++ b/arch/arm/mach-shmobile/setup-sh73a0.c
@@ -22,7 +22,6 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
-#include <linux/irqchip.h>
 #include <linux/platform_device.h>
 #include <linux/of_platform.h>
 #include <linux/delay.h>
@@ -1035,7 +1034,6 @@ DT_MACHINE_START(SH73A0_DT, "Generic SH73A0 (Flattened Device Tree)")
 	.map_io		= sh73a0_map_io,
 	.init_early	= sh73a0_init_delay,
 	.nr_irqs	= NR_IRQS_LEGACY,
-	.init_irq	= irqchip_init,
 	.init_machine	= sh73a0_add_standard_devices_dt,
 	.dt_compat	= sh73a0_boards_compat_dt,
 MACHINE_END
-- 
1.8.1.2
