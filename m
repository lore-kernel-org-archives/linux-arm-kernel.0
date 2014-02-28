From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 28 Feb 2014 11:10:04 +0100
Subject: [PATCH] ARM: ux500: delete pointless DT config option
Message-ID: <1393582204-9156-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Supporting device tree on the Ux500 is not optional anymore,
so delete the config option and compile this in at all times.

Cc: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ux500/Kconfig      | 5 -----
 arch/arm/mach-ux500/cpu-db8500.c | 3 ---
 2 files changed, 8 deletions(-)

diff --git a/arch/arm/mach-ux500/Kconfig b/arch/arm/mach-ux500/Kconfig
index 0034d2cd6973..b2019dc50e40 100644
--- a/arch/arm/mach-ux500/Kconfig
+++ b/arch/arm/mach-ux500/Kconfig
@@ -73,11 +73,6 @@ config UX500_AUTO_PLATFORM
 	  a working kernel. If everything else is disabled, this
 	  automatically enables MACH_MOP500.
 
-config MACH_UX500_DT
-	bool "Generic U8500 support using device tree"
-	depends on MACH_MOP500
-	select USE_OF
-
 endmenu
 
 config UX500_DEBUG_UART
diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
index 180b3c59be36..5e8a4021e4e0 100644
--- a/arch/arm/mach-ux500/cpu-db8500.c
+++ b/arch/arm/mach-ux500/cpu-db8500.c
@@ -146,7 +146,6 @@ static struct device * __init db8500_soc_device_init(void)
 	return ux500_soc_device_init(soc_id);
 }
 
-#ifdef CONFIG_MACH_UX500_DT
 static struct of_dev_auxdata u8500_auxdata_lookup[] __initdata = {
 	/* Requires call-back bindings. */
 	OF_DEV_AUXDATA("arm,cortex-a9-pmu", 0, "arm-pmu", &db8500_pmu_platdata),
@@ -219,5 +218,3 @@ DT_MACHINE_START(U8500_DT, "ST-Ericsson Ux5x0 platform (Device Tree Support)")
 	.dt_compat      = stericsson_dt_platform_compat,
 	.restart        = ux500_restart,
 MACHINE_END
-
-#endif
-- 
1.8.5.3
