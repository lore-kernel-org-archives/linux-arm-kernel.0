From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 30 May 2012 12:47:22 +0800
Subject: [PATCH 04/22] ARM: ux500: Remove DB8500 PRCMU platform registration
 when DT is enabled
In-Reply-To: <1338353260-10097-1-git-send-email-lee.jones@linaro.org>
References: <1338353260-10097-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1338353260-10097-5-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now the DB8500 has Device Tree support it will be probed when the DT
is parsed, rendering the requirement for platform registration void.
This patch removes DB8500 PRCMU platform registration.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/cpu-db8500.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
index 04244b0..33275eb 100644
--- a/arch/arm/mach-ux500/cpu-db8500.c
+++ b/arch/arm/mach-ux500/cpu-db8500.c
@@ -140,7 +140,6 @@ static struct platform_device *platform_devs[] __initdata = {
 static struct platform_device *of_platform_devs[] __initdata = {
 	&u8500_dma40_device,
 	&db8500_pmu_device,
-	&db8500_prcmu_device,
 };
 
 static resource_size_t __initdata db8500_gpio_base[] = {
@@ -251,7 +250,7 @@ struct device * __init u8500_of_init_devices(void)
 	 * Devices to be DT:ed:
 	 *   u8500_dma40_device  = todo
 	 *   db8500_pmu_device   = todo
-	 *   db8500_prcmu_device = todo
+	 *   db8500_prcmu_device = done
 	 */
 	platform_add_devices(of_platform_devs, ARRAY_SIZE(of_platform_devs));
 
-- 
1.7.9.5
