From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 23 Aug 2013 13:23:07 +0100
Subject: [PATCH 07/40] ARM: ux500: Remove support for Snowball's Ethernet
 regulator when booting with ATAGs
In-Reply-To: <1377260620-18829-1-git-send-email-lee.jones@linaro.org>
References: <1377260620-18829-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1377260620-18829-8-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's time to remove all ATAG support from ux500 and rely solely on
Device Tree booting. This patch is part of that endeavour.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/board-mop500.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index 062f8bf..68bd9d3 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -54,23 +54,6 @@
 #include "board-mop500.h"
 #include "board-mop500-regulators.h"
 
-static struct fixed_voltage_config snowball_gpio_en_3v3_data = {
-       .supply_name            = "EN-3V3",
-       .gpio                   = SNOWBALL_EN_3V3_ETH_GPIO,
-       .microvolts             = 3300000,
-       .enable_high            = 1,
-       .init_data              = &gpio_en_3v3_regulator,
-       .startup_delay          = 5000, /* 1200us */
-};
-
-static struct platform_device snowball_gpio_en_3v3_regulator_dev = {
-       .name   = "reg-fixed-voltage",
-       .id     = 1,
-       .dev    = {
-               .platform_data  = &snowball_gpio_en_3v3_data,
-       },
-};
-
 /* Dynamically populated. */
 static struct gpio sdi0_reg_gpios[] = {
 	{ 0, GPIOF_OUT_INIT_LOW, "mmci_vsel" },
@@ -368,7 +351,6 @@ static void __init u8500_cryp1_hash1_init(struct device *parent)
 }
 
 static struct platform_device *snowball_platform_devs[] __initdata = {
-	&snowball_gpio_en_3v3_regulator_dev,
 	&u8500_cpufreq_cooling_device,
 	&sdi0_regulator,
 };
-- 
1.8.1.2
