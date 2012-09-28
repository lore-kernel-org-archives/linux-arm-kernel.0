From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Fri, 28 Sep 2012 16:16:51 +0200
Subject: [PATCH 1/4] ARM: ux500: Remove cpufreq platform device
In-Reply-To: <1348841814-13645-1-git-send-email-ulf.hansson@stericsson.com>
References: <1348841814-13645-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <1348841814-13645-2-git-send-email-ulf.hansson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulf Hansson <ulf.hansson@linaro.org>

The cpufreq device is already added from the prcmu driver as
a mfd child device.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 arch/arm/mach-ux500/cpu-db8500.c |    6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
index bcdfe6b..41b2779 100644
--- a/arch/arm/mach-ux500/cpu-db8500.c
+++ b/arch/arm/mach-ux500/cpu-db8500.c
@@ -214,9 +214,6 @@ struct device * __init u8500_init_devices(struct ab8500_platform_data *ab8500)
 	db8500_add_gpios(parent);
 	db8500_add_usb(parent, usb_db8500_rx_dma_cfg, usb_db8500_tx_dma_cfg);
 
-	platform_device_register_data(parent,
-		"cpufreq-u8500", -1, NULL, 0);
-
 	for (i = 0; i < ARRAY_SIZE(platform_devs); i++)
 		platform_devs[i]->dev.parent = parent;
 
@@ -236,9 +233,6 @@ struct device * __init u8500_of_init_devices(void)
 
 	db8500_add_usb(parent, usb_db8500_rx_dma_cfg, usb_db8500_tx_dma_cfg);
 
-	platform_device_register_data(parent,
-		"cpufreq-u8500", -1, NULL, 0);
-
 	u8500_dma40_device.dev.parent = parent;
 
 	/*
-- 
1.7.10
