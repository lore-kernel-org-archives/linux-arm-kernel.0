From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Wed, 17 Jun 2015 11:34:20 +0200
Subject: [PATCH 1/2] ARM: shmobile: R-Car Gen2: CONFIG_ARCH_SHMOBILE_MULTI is
 always set
Message-ID: <1434533661-22730-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since commit e042681894b62d60 ("ARM: shmobile: r8a7790: Remove legacy
code"), all R-Car Gen2 SoCs are supported by multiplatform kernels only.
As CONFIG_ARCH_SHMOBILE_MULTI is always set for shmobile multiplatform
kernels, we can remove related #ifdefs in code specific to R-Car Gen2
SoCs.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/mach-shmobile/setup-rcar-gen2.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-rcar-gen2.c b/arch/arm/mach-shmobile/setup-rcar-gen2.c
index 5d13595aa027447d..aa3339258d9c0232 100644
--- a/arch/arm/mach-shmobile/setup-rcar-gen2.c
+++ b/arch/arm/mach-shmobile/setup-rcar-gen2.c
@@ -128,9 +128,7 @@ void __init rcar_gen2_timer_init(void)
 #endif /* CONFIG_ARM_ARCH_TIMER */
 
 	rcar_gen2_clocks_init(mode);
-#ifdef CONFIG_ARCH_SHMOBILE_MULTI
 	clocksource_of_init();
-#endif
 }
 
 struct memory_reserve_config {
-- 
1.9.1
