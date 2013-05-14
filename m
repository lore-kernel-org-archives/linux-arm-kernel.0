From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 14 May 2013 17:38:51 +0200
Subject: [PATCH 18/20] ARM: vexpress: Remove init_irq declaration in machine
 description
In-Reply-To: <1368545933-7430-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1368545933-7430-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1368545933-7430-19-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit ebafed7a ("ARM: irq: Call irqchip_init if no init_irq function is
specified") removed the need to explictly setup the init_irq field in
the machine description when using only irqchip_init. Remove that
declaration for vexpress as well.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Acked-by: Pawel Moll <pawel.moll@arm.com>
---
 arch/arm/mach-vexpress/v2m.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-vexpress/v2m.c b/arch/arm/mach-vexpress/v2m.c
index 8802030..d601697 100644
--- a/arch/arm/mach-vexpress/v2m.c
+++ b/arch/arm/mach-vexpress/v2m.c
@@ -9,7 +9,6 @@
 #include <linux/clocksource.h>
 #include <linux/smp.h>
 #include <linux/init.h>
-#include <linux/irqchip.h>
 #include <linux/of_address.h>
 #include <linux/of_fdt.h>
 #include <linux/of_irq.h>
@@ -458,7 +457,6 @@ DT_MACHINE_START(VEXPRESS_DT, "ARM-Versatile Express")
 	.smp		= smp_ops(vexpress_smp_ops),
 	.map_io		= v2m_dt_map_io,
 	.init_early	= v2m_dt_init_early,
-	.init_irq	= irqchip_init,
 	.init_time	= v2m_dt_timer_init,
 	.init_machine	= v2m_dt_init,
 MACHINE_END
-- 
1.8.1.2
