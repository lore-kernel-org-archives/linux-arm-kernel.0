From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 18 Apr 2013 11:12:09 +0100
Subject: [PATCH 27/32] ARM: ux500: Stop registering DMA40 from platform data
 when DT is enabled
In-Reply-To: <1366279934-30761-1-git-send-email-lee.jones@linaro.org>
References: <1366279934-30761-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1366279934-30761-28-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now the DMA40 has been DT:ed, there's no requirement to register it
using traditional methods. This is the penultimate device to be DT:ed.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/cpu-db8500.c |   10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
index a15678d..eae3e3a 100644
--- a/arch/arm/mach-ux500/cpu-db8500.c
+++ b/arch/arm/mach-ux500/cpu-db8500.c
@@ -229,16 +229,6 @@ static struct device * __init u8500_of_init_devices(void)
 
 	db8500_add_usb(parent, usb_db8500_dma_cfg, usb_db8500_dma_cfg);
 
-	u8500_dma40_device.dev.parent = parent;
-
-	/*
-	 * Devices to be DT:ed:
-	 *   u8500_dma40_device  = todo
-	 *   db8500_pmu_device   = done
-	 *   db8500_prcmu_device = done
-	 */
-	platform_device_register(&u8500_dma40_device);
-
 	return parent;
 }
 
-- 
1.7.10.4
