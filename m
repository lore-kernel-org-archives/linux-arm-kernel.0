From: tarun.kanti@ti.com (Tarun Kanti DebBarma)
Date: Mon, 19 Mar 2012 17:36:57 +0530
Subject: [PATCH v2 4/4] ARM: OMAP: Remove OMAP_GPIO_IRQ macro definition
In-Reply-To: <1332158817-26311-1-git-send-email-tarun.kanti@ti.com>
References: <1332158817-26311-1-git-send-email-tarun.kanti@ti.com>
Message-ID: <1332158817-26311-5-git-send-email-tarun.kanti@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since all references to OMAP_GPIO_IRQ macro are replaced now
with gpio_to_irq(), this can be removed altogether.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
---
 arch/arm/plat-omap/include/plat/gpio.h |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/gpio.h b/arch/arm/plat-omap/include/plat/gpio.h
index 9e86ee0..d4df414 100644
--- a/arch/arm/plat-omap/include/plat/gpio.h
+++ b/arch/arm/plat-omap/include/plat/gpio.h
@@ -158,10 +158,6 @@
 #define OMAP_MPUIO(nr)		(OMAP_MAX_GPIO_LINES + (nr))
 #define OMAP_GPIO_IS_MPUIO(nr)	((nr) >= OMAP_MAX_GPIO_LINES)
 
-#define OMAP_GPIO_IRQ(nr)	(OMAP_GPIO_IS_MPUIO(nr) ? \
-				 IH_MPUIO_BASE + ((nr) & 0x0f) : \
-				 IH_GPIO_BASE + (nr))
-
 #define METHOD_MPUIO		0
 #define METHOD_GPIO_1510	1
 #define METHOD_GPIO_1610	2
-- 
1.7.0.4
