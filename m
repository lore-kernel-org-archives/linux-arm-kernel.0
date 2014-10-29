From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 29 Oct 2014 14:00:05 +0900
Subject: [PATCH 1/2] ARM: shmobile: r8a7778: Remove wrapper
 r8a7778_init_delay()
In-Reply-To: <cover.1414556645.git.horms+renesas@verge.net.au>
References: <cover.1414556645.git.horms+renesas@verge.net.au>
Message-ID: <92ee341e0b87551ab8838116782a4f3929108136.1414556645.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

r8a7778_init_delay() just calls shmobile_init_delay(), hence replace
calls to it by direct calls to shmobile_init_delay().

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/r8a7778.h       | 1 -
 arch/arm/mach-shmobile/setup-r8a7778.c | 7 +------
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/arm/mach-shmobile/r8a7778.h b/arch/arm/mach-shmobile/r8a7778.h
index f4076a5..4802cee 100644
--- a/arch/arm/mach-shmobile/r8a7778.h
+++ b/arch/arm/mach-shmobile/r8a7778.h
@@ -71,7 +71,6 @@ extern void r8a7778_add_standard_devices_dt(void);
 extern void r8a7778_add_dt_devices(void);
 
 extern void r8a7778_init_late(void);
-extern void r8a7778_init_delay(void);
 extern void r8a7778_init_irq_dt(void);
 extern void r8a7778_clock_init(void);
 extern void r8a7778_init_irq_extpin(int irlm);
diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c b/arch/arm/mach-shmobile/setup-r8a7778.c
index 85fe016..97eac87 100644
--- a/arch/arm/mach-shmobile/setup-r8a7778.c
+++ b/arch/arm/mach-shmobile/setup-r8a7778.c
@@ -572,11 +572,6 @@ void __init r8a7778_init_irq_extpin(int irlm)
 			&irqpin_platform_data, sizeof(irqpin_platform_data));
 }
 
-void __init r8a7778_init_delay(void)
-{
-	shmobile_init_delay();
-}
-
 #ifdef CONFIG_USE_OF
 #define INT2SMSKCR0	0x82288 /* 0xfe782288 */
 #define INT2SMSKCR1	0x8228c /* 0xfe78228c */
@@ -608,7 +603,7 @@ static const char *r8a7778_compat_dt[] __initdata = {
 };
 
 DT_MACHINE_START(R8A7778_DT, "Generic R8A7778 (Flattened Device Tree)")
-	.init_early	= r8a7778_init_delay,
+	.init_early	= shmobile_init_delay,
 	.init_irq	= r8a7778_init_irq_dt,
 	.init_late	= shmobile_init_late,
 	.dt_compat	= r8a7778_compat_dt,
-- 
2.1.1
