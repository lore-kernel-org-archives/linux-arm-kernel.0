From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Tue, 18 Mar 2014 18:51:20 +0200
Subject: [PATCH] ARM: davinci: remove gpio data from davinci_soc_info
Message-ID: <1395161480-30223-1-git-send-email-grygorii.strashko@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

GPIO's related fields can be safely removed from davinci_soc_info now,
since their last user, tnetv107x gpio driver, was removed already by
commit "gpio: remove obsolete tnetv107x driver".

CC: Sekhar Nori <nsekhar@ti.com>
CC: Kevin Hilman <khilman@linaro.org>
CC: Arnd Bergmann <arnd@arndb.de>

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
Compile time tested only.

 arch/arm/mach-davinci/include/mach/common.h |    9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/arm/mach-davinci/include/mach/common.h b/arch/arm/mach-davinci/include/mach/common.h
index 0b3c169..8807e3b 100644
--- a/arch/arm/mach-davinci/include/mach/common.h
+++ b/arch/arm/mach-davinci/include/mach/common.h
@@ -36,8 +36,6 @@ struct davinci_timer_info {
 	unsigned int			clocksource_id;
 };
 
-struct davinci_gpio_controller;
-
 /*
  * SoC info passed into common davinci modules.
  *
@@ -65,13 +63,6 @@ struct davinci_soc_info {
 	unsigned long			intc_irq_num;
 	u32				*intc_host_map;
 	struct davinci_timer_info	*timer_info;
-	int				gpio_type;
-	u32				gpio_base;
-	unsigned			gpio_num;
-	unsigned			gpio_irq;
-	unsigned			gpio_unbanked;
-	struct davinci_gpio_controller	*gpio_ctlrs;
-	int				gpio_ctlrs_num;
 	struct emac_platform_data	*emac_pdata;
 	dma_addr_t			sram_dma;
 	unsigned			sram_len;
-- 
1.7.9.5
