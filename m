From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 10 Mar 2015 09:43:03 +0900
Subject: [PATCH 2/3] ARM: shmobile: R-Car Gen2: CONFIG_COMMON_CLK is always set
In-Reply-To: <cover.1425947508.git.horms+renesas@verge.net.au>
References: <cover.1425947508.git.horms+renesas@verge.net.au>
Message-ID: <c77e9e7327218244d181a297f0742cf15d370fd1.1425947508.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Since commit e042681894b62d60 ("ARM: shmobile: r8a7790: Remove legacy
code"), all R-Car Gen2 SoCs are supported by multiplatform kernels only.
As CONFIG_COMMON_CLK is always set for multiplatform kernels, we can
remove related #ifdefs in code specific to R-Car Gen2 SoCs.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-rcar-gen2.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-rcar-gen2.c b/arch/arm/mach-shmobile/setup-rcar-gen2.c
index d1fa625..51464cc 100644
--- a/arch/arm/mach-shmobile/setup-rcar-gen2.c
+++ b/arch/arm/mach-shmobile/setup-rcar-gen2.c
@@ -50,9 +50,7 @@ u32 rcar_gen2_read_mode_pins(void)
 
 void __init rcar_gen2_timer_init(void)
 {
-#if defined(CONFIG_ARM_ARCH_TIMER) || defined(CONFIG_COMMON_CLK)
 	u32 mode = rcar_gen2_read_mode_pins();
-#endif
 #ifdef CONFIG_ARM_ARCH_TIMER
 	void __iomem *base;
 	int extal_mhz = 0;
@@ -128,9 +126,7 @@ void __init rcar_gen2_timer_init(void)
 	iounmap(base);
 #endif /* CONFIG_ARM_ARCH_TIMER */
 
-#ifdef CONFIG_COMMON_CLK
 	rcar_gen2_clocks_init(mode);
-#endif
 #ifdef CONFIG_ARCH_SHMOBILE_MULTI
 	clocksource_of_init();
 #endif
-- 
2.1.4
