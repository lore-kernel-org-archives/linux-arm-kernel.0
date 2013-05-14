From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 14 May 2013 17:38:47 +0200
Subject: [PATCH 14/20] ARM: msm: Remove init_irq declaration in machine
 description
In-Reply-To: <1368545933-7430-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1368545933-7430-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1368545933-7430-15-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit ebafed7a ("ARM: irq: Call irqchip_init if no init_irq function is
specified") removed the need to explictly setup the init_irq field in
the machine description when using only irqchip_init. Remove that
declaration for msm as well.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/mach-msm/board-dt-8660.c | 2 --
 arch/arm/mach-msm/board-dt-8960.c | 2 --
 2 files changed, 4 deletions(-)

diff --git a/arch/arm/mach-msm/board-dt-8660.c b/arch/arm/mach-msm/board-dt-8660.c
index 7dcfc53..492f5cd 100644
--- a/arch/arm/mach-msm/board-dt-8660.c
+++ b/arch/arm/mach-msm/board-dt-8660.c
@@ -11,7 +11,6 @@
  */
 
 #include <linux/init.h>
-#include <linux/irqchip.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
 
@@ -44,7 +43,6 @@ static const char *msm8x60_fluid_match[] __initdata = {
 DT_MACHINE_START(MSM_DT, "Qualcomm MSM (Flattened Device Tree)")
 	.smp = smp_ops(msm_smp_ops),
 	.map_io = msm_map_msm8x60_io,
-	.init_irq = irqchip_init,
 	.init_machine = msm8x60_dt_init,
 	.init_late = msm8x60_init_late,
 	.init_time	= msm_dt_timer_init,
diff --git a/arch/arm/mach-msm/board-dt-8960.c b/arch/arm/mach-msm/board-dt-8960.c
index 7301936..bb55309 100644
--- a/arch/arm/mach-msm/board-dt-8960.c
+++ b/arch/arm/mach-msm/board-dt-8960.c
@@ -11,7 +11,6 @@
  */
 
 #include <linux/init.h>
-#include <linux/irqchip.h>
 #include <linux/of_platform.h>
 
 #include <asm/mach/arch.h>
@@ -31,7 +30,6 @@ static const char * const msm8960_dt_match[] __initconst = {
 DT_MACHINE_START(MSM8960_DT, "Qualcomm MSM (Flattened Device Tree)")
 	.smp = smp_ops(msm_smp_ops),
 	.map_io = msm_map_msm8960_io,
-	.init_irq = irqchip_init,
 	.init_time	= msm_dt_timer_init,
 	.init_machine = msm_dt_init,
 	.dt_compat = msm8960_dt_match,
-- 
1.8.1.2
