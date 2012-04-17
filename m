From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 17 Apr 2012 11:44:07 +0100
Subject: [PATCH 15/16] ARM: ux500: Apply Device Tree settings for the DB8500
 PRCMU
In-Reply-To: <1334659448-11521-1-git-send-email-lee.jones@linaro.org>
References: <1334659448-11521-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1334659448-11521-16-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In this patch we enable the db8500-prcmu via DT and take out
any enablement previously carried out by platform code.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/cpu-db8500.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
index c97eab7..2512b6a 100644
--- a/arch/arm/mach-ux500/cpu-db8500.c
+++ b/arch/arm/mach-ux500/cpu-db8500.c
@@ -124,7 +124,6 @@ static struct platform_device *platform_devs[] __initdata = {
 static struct platform_device *of_platform_devs[] __initdata = {
 	&u8500_dma40_device,
 	&db8500_pmu_device,
-	&db8500_prcmu_device,
 };
 
 static resource_size_t __initdata db8500_gpio_base[] = {
@@ -234,7 +233,7 @@ struct device * __init u8500_of_init_devices(void)
 	 * Devices to be DT:ed:
 	 *   u8500_dma40_device  = todo
 	 *   db8500_pmu_device   = todo
-	 *   db8500_prcmu_device = todo
+	 *   db8500_prcmu_device = done
 	 */
 	platform_add_devices(of_platform_devs, ARRAY_SIZE(of_platform_devs));
 
-- 
1.7.9.1
