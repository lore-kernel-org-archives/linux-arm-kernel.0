From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 20 Jun 2012 13:56:50 +0100
Subject: [PATCH 14/15] ARM: ux500: Remove PMU platform registration when
 booting with DT
In-Reply-To: <1340197011-5435-1-git-send-email-lee.jones@linaro.org>
References: <1340197011-5435-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1340197011-5435-15-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PMU registration is successfully completed by Device Tree now, so
there is no longer a requirement to register it from platform code.
This patch removes platform registration during a DT boot.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/cpu-db8500.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
index a12bd9e..c8dd94f 100644
--- a/arch/arm/mach-ux500/cpu-db8500.c
+++ b/arch/arm/mach-ux500/cpu-db8500.c
@@ -139,7 +139,6 @@ static struct platform_device *platform_devs[] __initdata = {
 
 static struct platform_device *of_platform_devs[] __initdata = {
 	&u8500_dma40_device,
-	&db8500_pmu_device,
 };
 
 static resource_size_t __initdata db8500_gpio_base[] = {
@@ -248,7 +247,7 @@ struct device * __init u8500_of_init_devices(void)
 	/*
 	 * Devices to be DT:ed:
 	 *   u8500_dma40_device  = todo
-	 *   db8500_pmu_device   = todo
+	 *   db8500_pmu_device   = done
 	 *   db8500_prcmu_device = done
 	 */
 	platform_add_devices(of_platform_devs, ARRAY_SIZE(of_platform_devs));
-- 
1.7.9.5
