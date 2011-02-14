From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 14 Feb 2011 17:23:02 +0900
Subject: [PATCH 06/11] ARM: EXYNOS4: Moved board support files
In-Reply-To: <1297671787-10571-1-git-send-email-kgene.kim@samsung.com>
References: <1297671787-10571-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1297671787-10571-7-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch moves board support files, SMDKC210, SMKDV310
and UNIVERSAL_C210 into arch/arm/mach-exynos4/ according
to the change of ARCH name, EXYNOS4.

Cc: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 .../{mach-s5pv310 => mach-exynos4}/mach-smdkc210.c |   48 ++++++++++----------
 .../{mach-s5pv310 => mach-exynos4}/mach-smdkv310.c |   48 ++++++++++----------
 .../mach-universal_c210.c                          |   22 +++++-----
 3 files changed, 59 insertions(+), 59 deletions(-)
 rename arch/arm/{mach-s5pv310 => mach-exynos4}/mach-smdkc210.c (87%)
 rename arch/arm/{mach-s5pv310 => mach-exynos4}/mach-smdkv310.c (87%)
 rename arch/arm/{mach-s5pv310 => mach-exynos4}/mach-universal_c210.c (93%)

diff --git a/arch/arm/mach-s5pv310/mach-smdkc210.c b/arch/arm/mach-exynos4/mach-smdkc210.c
similarity index 87%
rename from arch/arm/mach-s5pv310/mach-smdkc210.c
rename to arch/arm/mach-exynos4/mach-smdkc210.c
index d9cab02..25a2568 100644
--- a/arch/arm/mach-s5pv310/mach-smdkc210.c
+++ b/arch/arm/mach-exynos4/mach-smdkc210.c
@@ -1,7 +1,7 @@
-/* linux/arch/arm/mach-s5pv310/mach-smdkc210.c
+/* linux/arch/arm/mach-exynos4/mach-smdkc210.c
  *
- * Copyright (c) 2010 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
+ * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -21,7 +21,7 @@
 
 #include <plat/regs-serial.h>
 #include <plat/regs-srom.h>
-#include <plat/s5pv310.h>
+#include <plat/exynos4.h>
 #include <plat/cpu.h>
 #include <plat/devs.h>
 #include <plat/sdhci.h>
@@ -77,10 +77,10 @@ static struct s3c2410_uartcfg smdkc210_uartcfgs[] __initdata = {
 
 static struct s3c_sdhci_platdata smdkc210_hsmmc0_pdata __initdata = {
 	.cd_type		= S3C_SDHCI_CD_GPIO,
-	.ext_cd_gpio		= S5PV310_GPK0(2),
+	.ext_cd_gpio		= EXYNOS4_GPK0(2),
 	.ext_cd_gpio_invert	= 1,
 	.clk_type		= S3C_SDHCI_CLK_DIV_EXTERNAL,
-#ifdef CONFIG_S5PV310_SDHCI_CH0_8BIT
+#ifdef CONFIG_EXYNOS4_SDHCI_CH0_8BIT
 	.max_width		= 8,
 	.host_caps		= MMC_CAP_8_BIT_DATA,
 #endif
@@ -88,17 +88,17 @@ static struct s3c_sdhci_platdata smdkc210_hsmmc0_pdata __initdata = {
 
 static struct s3c_sdhci_platdata smdkc210_hsmmc1_pdata __initdata = {
 	.cd_type		= S3C_SDHCI_CD_GPIO,
-	.ext_cd_gpio		= S5PV310_GPK0(2),
+	.ext_cd_gpio		= EXYNOS4_GPK0(2),
 	.ext_cd_gpio_invert	= 1,
 	.clk_type		= S3C_SDHCI_CLK_DIV_EXTERNAL,
 };
 
 static struct s3c_sdhci_platdata smdkc210_hsmmc2_pdata __initdata = {
 	.cd_type		= S3C_SDHCI_CD_GPIO,
-	.ext_cd_gpio		= S5PV310_GPK2(2),
+	.ext_cd_gpio		= EXYNOS4_GPK2(2),
 	.ext_cd_gpio_invert	= 1,
 	.clk_type		= S3C_SDHCI_CLK_DIV_EXTERNAL,
-#ifdef CONFIG_S5PV310_SDHCI_CH2_8BIT
+#ifdef CONFIG_EXYNOS4_SDHCI_CH2_8BIT
 	.max_width		= 8,
 	.host_caps		= MMC_CAP_8_BIT_DATA,
 #endif
@@ -106,15 +106,15 @@ static struct s3c_sdhci_platdata smdkc210_hsmmc2_pdata __initdata = {
 
 static struct s3c_sdhci_platdata smdkc210_hsmmc3_pdata __initdata = {
 	.cd_type		= S3C_SDHCI_CD_GPIO,
-	.ext_cd_gpio		= S5PV310_GPK2(2),
+	.ext_cd_gpio		= EXYNOS4_GPK2(2),
 	.ext_cd_gpio_invert	= 1,
 	.clk_type		= S3C_SDHCI_CLK_DIV_EXTERNAL,
 };
 
 static struct resource smdkc210_smsc911x_resources[] = {
 	[0] = {
-		.start	= S5PV310_PA_SROM_BANK(1),
-		.end	= S5PV310_PA_SROM_BANK(1) + SZ_64K - 1,
+		.start	= EXYNOS4_PA_SROM_BANK(1),
+		.end	= EXYNOS4_PA_SROM_BANK(1) + SZ_64K - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
@@ -154,16 +154,16 @@ static struct platform_device *smdkc210_devices[] __initdata = {
 	&s3c_device_i2c1,
 	&s3c_device_rtc,
 	&s3c_device_wdt,
-	&s5pv310_device_ac97,
-	&s5pv310_device_i2s0,
-	&s5pv310_device_pd[PD_MFC],
-	&s5pv310_device_pd[PD_G3D],
-	&s5pv310_device_pd[PD_LCD0],
-	&s5pv310_device_pd[PD_LCD1],
-	&s5pv310_device_pd[PD_CAM],
-	&s5pv310_device_pd[PD_TV],
-	&s5pv310_device_pd[PD_GPS],
-	&s5pv310_device_sysmmu,
+	&exynos4_device_ac97,
+	&exynos4_device_i2s0,
+	&exynos4_device_pd[PD_MFC],
+	&exynos4_device_pd[PD_G3D],
+	&exynos4_device_pd[PD_LCD0],
+	&exynos4_device_pd[PD_LCD1],
+	&exynos4_device_pd[PD_CAM],
+	&exynos4_device_pd[PD_TV],
+	&exynos4_device_pd[PD_GPS],
+	&exynos4_device_sysmmu,
 	&samsung_asoc_dma,
 	&smdkc210_smsc911x,
 };
@@ -216,8 +216,8 @@ static void __init smdkc210_machine_init(void)
 MACHINE_START(SMDKC210, "SMDKC210")
 	/* Maintainer: Kukjin Kim <kgene.kim@samsung.com> */
 	.boot_params	= S5P_PA_SDRAM + 0x100,
-	.init_irq	= s5pv310_init_irq,
+	.init_irq	= exynos4_init_irq,
 	.map_io		= smdkc210_map_io,
 	.init_machine	= smdkc210_machine_init,
-	.timer		= &s5pv310_timer,
+	.timer		= &exynos4_timer,
 MACHINE_END
diff --git a/arch/arm/mach-s5pv310/mach-smdkv310.c b/arch/arm/mach-exynos4/mach-smdkv310.c
similarity index 87%
rename from arch/arm/mach-s5pv310/mach-smdkv310.c
rename to arch/arm/mach-exynos4/mach-smdkv310.c
index b1cddbf..07860a5 100644
--- a/arch/arm/mach-s5pv310/mach-smdkv310.c
+++ b/arch/arm/mach-exynos4/mach-smdkv310.c
@@ -1,7 +1,7 @@
-/* linux/arch/arm/mach-s5pv310/mach-smdkv310.c
+/* linux/arch/arm/mach-exynos4/mach-smdkv310.c
  *
- * Copyright (c) 2010 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
+ * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -21,7 +21,7 @@
 
 #include <plat/regs-serial.h>
 #include <plat/regs-srom.h>
-#include <plat/s5pv310.h>
+#include <plat/exynos4.h>
 #include <plat/cpu.h>
 #include <plat/devs.h>
 #include <plat/sdhci.h>
@@ -77,10 +77,10 @@ static struct s3c2410_uartcfg smdkv310_uartcfgs[] __initdata = {
 
 static struct s3c_sdhci_platdata smdkv310_hsmmc0_pdata __initdata = {
 	.cd_type		= S3C_SDHCI_CD_GPIO,
-	.ext_cd_gpio		= S5PV310_GPK0(2),
+	.ext_cd_gpio		= EXYNOS4_GPK0(2),
 	.ext_cd_gpio_invert	= 1,
 	.clk_type		= S3C_SDHCI_CLK_DIV_EXTERNAL,
-#ifdef CONFIG_S5PV310_SDHCI_CH0_8BIT
+#ifdef CONFIG_EXYNOS4_SDHCI_CH0_8BIT
 	.max_width		= 8,
 	.host_caps		= MMC_CAP_8_BIT_DATA,
 #endif
@@ -88,17 +88,17 @@ static struct s3c_sdhci_platdata smdkv310_hsmmc0_pdata __initdata = {
 
 static struct s3c_sdhci_platdata smdkv310_hsmmc1_pdata __initdata = {
 	.cd_type		= S3C_SDHCI_CD_GPIO,
-	.ext_cd_gpio		= S5PV310_GPK0(2),
+	.ext_cd_gpio		= EXYNOS4_GPK0(2),
 	.ext_cd_gpio_invert	= 1,
 	.clk_type		= S3C_SDHCI_CLK_DIV_EXTERNAL,
 };
 
 static struct s3c_sdhci_platdata smdkv310_hsmmc2_pdata __initdata = {
 	.cd_type		= S3C_SDHCI_CD_GPIO,
-	.ext_cd_gpio		= S5PV310_GPK2(2),
+	.ext_cd_gpio		= EXYNOS4_GPK2(2),
 	.ext_cd_gpio_invert	= 1,
 	.clk_type		= S3C_SDHCI_CLK_DIV_EXTERNAL,
-#ifdef CONFIG_S5PV310_SDHCI_CH2_8BIT
+#ifdef CONFIG_EXYNOS4_SDHCI_CH2_8BIT
 	.max_width		= 8,
 	.host_caps		= MMC_CAP_8_BIT_DATA,
 #endif
@@ -106,15 +106,15 @@ static struct s3c_sdhci_platdata smdkv310_hsmmc2_pdata __initdata = {
 
 static struct s3c_sdhci_platdata smdkv310_hsmmc3_pdata __initdata = {
 	.cd_type		= S3C_SDHCI_CD_GPIO,
-	.ext_cd_gpio		= S5PV310_GPK2(2),
+	.ext_cd_gpio		= EXYNOS4_GPK2(2),
 	.ext_cd_gpio_invert	= 1,
 	.clk_type		= S3C_SDHCI_CLK_DIV_EXTERNAL,
 };
 
 static struct resource smdkv310_smsc911x_resources[] = {
 	[0] = {
-		.start	= S5PV310_PA_SROM_BANK(1),
-		.end	= S5PV310_PA_SROM_BANK(1) + SZ_64K - 1,
+		.start	= EXYNOS4_PA_SROM_BANK(1),
+		.end	= EXYNOS4_PA_SROM_BANK(1) + SZ_64K - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
@@ -154,16 +154,16 @@ static struct platform_device *smdkv310_devices[] __initdata = {
 	&s3c_device_i2c1,
 	&s3c_device_rtc,
 	&s3c_device_wdt,
-	&s5pv310_device_ac97,
-	&s5pv310_device_i2s0,
-	&s5pv310_device_pd[PD_MFC],
-	&s5pv310_device_pd[PD_G3D],
-	&s5pv310_device_pd[PD_LCD0],
-	&s5pv310_device_pd[PD_LCD1],
-	&s5pv310_device_pd[PD_CAM],
-	&s5pv310_device_pd[PD_TV],
-	&s5pv310_device_pd[PD_GPS],
-	&s5pv310_device_sysmmu,
+	&exynos4_device_ac97,
+	&exynos4_device_i2s0,
+	&exynos4_device_pd[PD_MFC],
+	&exynos4_device_pd[PD_G3D],
+	&exynos4_device_pd[PD_LCD0],
+	&exynos4_device_pd[PD_LCD1],
+	&exynos4_device_pd[PD_CAM],
+	&exynos4_device_pd[PD_TV],
+	&exynos4_device_pd[PD_GPS],
+	&exynos4_device_sysmmu,
 	&samsung_asoc_dma,
 	&smdkv310_smsc911x,
 };
@@ -217,8 +217,8 @@ MACHINE_START(SMDKV310, "SMDKV310")
 	/* Maintainer: Kukjin Kim <kgene.kim@samsung.com> */
 	/* Maintainer: Changhwan Youn <chaos.youn@samsung.com> */
 	.boot_params	= S5P_PA_SDRAM + 0x100,
-	.init_irq	= s5pv310_init_irq,
+	.init_irq	= exynos4_init_irq,
 	.map_io		= smdkv310_map_io,
 	.init_machine	= smdkv310_machine_init,
-	.timer		= &s5pv310_timer,
+	.timer		= &exynos4_timer,
 MACHINE_END
diff --git a/arch/arm/mach-s5pv310/mach-universal_c210.c b/arch/arm/mach-exynos4/mach-universal_c210.c
similarity index 93%
rename from arch/arm/mach-s5pv310/mach-universal_c210.c
rename to arch/arm/mach-exynos4/mach-universal_c210.c
index 36bc3cf..b22b6ef 100644
--- a/arch/arm/mach-s5pv310/mach-universal_c210.c
+++ b/arch/arm/mach-exynos4/mach-universal_c210.c
@@ -1,4 +1,4 @@
-/* linux/arch/arm/mach-s5pv310/mach-universal_c210.c
+/* linux/arch/arm/mach-exynos4/mach-universal_c210.c
  *
  * Copyright (c) 2010 Samsung Electronics Co., Ltd.
  *
@@ -21,7 +21,7 @@
 #include <asm/mach-types.h>
 
 #include <plat/regs-serial.h>
-#include <plat/s5pv310.h>
+#include <plat/exynos4.h>
 #include <plat/cpu.h>
 #include <plat/devs.h>
 #include <plat/sdhci.h>
@@ -72,35 +72,35 @@ static struct s3c2410_uartcfg universal_uartcfgs[] __initdata = {
 static struct gpio_keys_button universal_gpio_keys_tables[] = {
 	{
 		.code			= KEY_VOLUMEUP,
-		.gpio			= S5PV310_GPX2(0),	/* XEINT16 */
+		.gpio			= EXYNOS4_GPX2(0),	/* XEINT16 */
 		.desc			= "gpio-keys: KEY_VOLUMEUP",
 		.type			= EV_KEY,
 		.active_low		= 1,
 		.debounce_interval	= 1,
 	}, {
 		.code			= KEY_VOLUMEDOWN,
-		.gpio			= S5PV310_GPX2(1),	/* XEINT17 */
+		.gpio			= EXYNOS4_GPX2(1),	/* XEINT17 */
 		.desc			= "gpio-keys: KEY_VOLUMEDOWN",
 		.type			= EV_KEY,
 		.active_low		= 1,
 		.debounce_interval	= 1,
 	}, {
 		.code			= KEY_CONFIG,
-		.gpio			= S5PV310_GPX2(2),	/* XEINT18 */
+		.gpio			= EXYNOS4_GPX2(2),	/* XEINT18 */
 		.desc			= "gpio-keys: KEY_CONFIG",
 		.type			= EV_KEY,
 		.active_low		= 1,
 		.debounce_interval	= 1,
 	}, {
 		.code			= KEY_CAMERA,
-		.gpio			= S5PV310_GPX2(3),	/* XEINT19 */
+		.gpio			= EXYNOS4_GPX2(3),	/* XEINT19 */
 		.desc			= "gpio-keys: KEY_CAMERA",
 		.type			= EV_KEY,
 		.active_low		= 1,
 		.debounce_interval	= 1,
 	}, {
 		.code			= KEY_OK,
-		.gpio			= S5PV310_GPX3(5),	/* XEINT29 */
+		.gpio			= EXYNOS4_GPX3(5),	/* XEINT29 */
 		.desc			= "gpio-keys: KEY_OK",
 		.type			= EV_KEY,
 		.active_low		= 1,
@@ -146,7 +146,7 @@ static struct regulator_init_data mmc0_fixed_voltage_init_data = {
 static struct fixed_voltage_config mmc0_fixed_voltage_config = {
 	.supply_name		= "MASSMEMORY_EN",
 	.microvolts		= 2800000,
-	.gpio			= S5PV310_GPE1(3),
+	.gpio			= EXYNOS4_GPE1(3),
 	.enable_high		= true,
 	.init_data		= &mmc0_fixed_voltage_init_data,
 };
@@ -165,7 +165,7 @@ static struct s3c_sdhci_platdata universal_hsmmc2_data __initdata = {
 	.host_caps		= MMC_CAP_4_BIT_DATA |
 				MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED |
 				MMC_CAP_DISABLE,
-	.ext_cd_gpio		= S5PV310_GPX3(4),      /* XEINT_28 */
+	.ext_cd_gpio		= EXYNOS4_GPX3(4),      /* XEINT_28 */
 	.ext_cd_gpio_invert	= 1,
 	.cd_type		= S3C_SDHCI_CD_GPIO,
 	.clk_type		= S3C_SDHCI_CLK_DIV_EXTERNAL,
@@ -230,8 +230,8 @@ static void __init universal_machine_init(void)
 MACHINE_START(UNIVERSAL_C210, "UNIVERSAL_C210")
 	/* Maintainer: Kyungmin Park <kyungmin.park@samsung.com> */
 	.boot_params	= S5P_PA_SDRAM + 0x100,
-	.init_irq	= s5pv310_init_irq,
+	.init_irq	= exynos4_init_irq,
 	.map_io		= universal_map_io,
 	.init_machine	= universal_machine_init,
-	.timer		= &s5pv310_timer,
+	.timer		= &exynos4_timer,
 MACHINE_END
-- 
1.7.1
