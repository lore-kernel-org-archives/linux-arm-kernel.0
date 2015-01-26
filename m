From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Mon, 26 Jan 2015 17:21:14 +0100
Subject: [PATCH] ARM: shmobile: R-Car Gen2: CONFIG_COMMON_CLK is always set
Message-ID: <1422289274-20605-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since commit e042681894b62d60 ("ARM: shmobile: r8a7790: Remove legacy
code"), all R-Car Gen2 SoCs are supported by multiplatform kernels only.
As CONFIG_COMMON_CLK is always set for multiplatform kernels, we can
remove related #ifdefs in code specific to R-Car Gen2 SoCs.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Depends on renesas-lager-board-removal-for-v3.20
---
 arch/arm/mach-shmobile/setup-rcar-gen2.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-rcar-gen2.c b/arch/arm/mach-shmobile/setup-rcar-gen2.c
index e2b9bb46393d898d..aa3339258d9c0232 100644
--- a/arch/arm/mach-shmobile/setup-rcar-gen2.c
+++ b/arch/arm/mach-shmobile/setup-rcar-gen2.c
@@ -51,9 +51,7 @@ u32 rcar_gen2_read_mode_pins(void)
 
 void __init rcar_gen2_timer_init(void)
 {
-#if defined(CONFIG_ARM_ARCH_TIMER) || defined(CONFIG_COMMON_CLK)
 	u32 mode = rcar_gen2_read_mode_pins();
-#endif
 #ifdef CONFIG_ARM_ARCH_TIMER
 	void __iomem *base;
 	int extal_mhz = 0;
@@ -129,9 +127,7 @@ void __init rcar_gen2_timer_init(void)
 	iounmap(base);
 #endif /* CONFIG_ARM_ARCH_TIMER */
 
-#ifdef CONFIG_COMMON_CLK
 	rcar_gen2_clocks_init(mode);
-#endif
 	clocksource_of_init();
 }
 
-- 
1.9.1
