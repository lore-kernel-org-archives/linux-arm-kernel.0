From: lee.jones@linaro.org (Lee Jones)
Date: Wed,  6 Nov 2013 10:05:45 +0000
Subject: [PATCH 4/7] ARM: ux500: Clean-up non-DT IRQ initialisation
In-Reply-To: <1383732348-18576-1-git-send-email-lee.jones@linaro.org>
References: <1383732348-18576-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1383732348-18576-5-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/cpu.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-ux500/cpu.c b/arch/arm/mach-ux500/cpu.c
index 8f8004f..d11ac4b 100644
--- a/arch/arm/mach-ux500/cpu.c
+++ b/arch/arm/mach-ux500/cpu.c
@@ -63,12 +63,7 @@ void __init ux500_init_irq(void)
 	} else
 		ux500_unknown_soc();
 
-#ifdef CONFIG_OF
-	if (of_have_populated_dt())
-		irqchip_init();
-	else
-#endif
-		gic_init(0, 29, dist_base, cpu_base);
+	irqchip_init();
 
 	/*
 	 * Init clocks here so that they are available for system timer
@@ -78,16 +73,11 @@ void __init ux500_init_irq(void)
 		prcmu_early_init(U8500_PRCMU_BASE, SZ_8K - 1);
 		ux500_pm_init(U8500_PRCMU_BASE, SZ_8K - 1);
 
-		if (of_have_populated_dt())
-			u8500_of_clk_init(U8500_CLKRST1_BASE,
-					  U8500_CLKRST2_BASE,
-					  U8500_CLKRST3_BASE,
-					  U8500_CLKRST5_BASE,
-					  U8500_CLKRST6_BASE);
-		else
-			u8500_clk_init(U8500_CLKRST1_BASE, U8500_CLKRST2_BASE,
-				       U8500_CLKRST3_BASE, U8500_CLKRST5_BASE,
-				       U8500_CLKRST6_BASE);
+		u8500_of_clk_init(U8500_CLKRST1_BASE,
+				  U8500_CLKRST2_BASE,
+				  U8500_CLKRST3_BASE,
+				  U8500_CLKRST5_BASE,
+				  U8500_CLKRST6_BASE);
 	} else if (cpu_is_u9540()) {
 		prcmu_early_init(U8500_PRCMU_BASE, SZ_8K - 1);
 		ux500_pm_init(U8500_PRCMU_BASE, SZ_8K - 1);
-- 
1.8.1.2
