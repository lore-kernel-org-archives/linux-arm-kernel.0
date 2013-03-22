From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 22 Mar 2013 15:27:43 +0000
Subject: [PATCH 3/5] ARM: ux500: Remove platform specific PRCMU and Clk
 initialisation
In-Reply-To: <1363966065-2478-1-git-send-email-lee.jones@linaro.org>
References: <1363966065-2478-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1363966065-2478-3-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For the moment at least, every platform which executes though
ux500_init_irq requires the same clk and prcmu initialisation.
So let's call those functions without clause.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/cpu.c |    9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-ux500/cpu.c b/arch/arm/mach-ux500/cpu.c
index 537870d..1fc3608 100644
--- a/arch/arm/mach-ux500/cpu.c
+++ b/arch/arm/mach-ux500/cpu.c
@@ -68,13 +68,8 @@ void __init ux500_init_irq(void)
 	 * Init clocks here so that they are available for system timer
 	 * initialization.
 	 */
-	if (cpu_is_u8500_family() || cpu_is_u9540())
-		db8500_prcmu_early_init();
-
-	if (cpu_is_u8500_family() || cpu_is_u9540())
-		u8500_clk_init();
-	else if (cpu_is_u8540())
-		u8540_clk_init();
+	db8500_prcmu_early_init();
+	u8500_clk_init();
 }
 
 void __init ux500_init_late(void)
-- 
1.7.10.4
