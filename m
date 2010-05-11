From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Tue, 11 May 2010 16:30:51 -0700
Subject: [PATCH 5/6] OMAP3: GPIO: Removed a couple of unneeded registers from
	context save/restore
In-Reply-To: <1273620652-15927-1-git-send-email-khilman@deeprootsystems.com>
References: <1273620652-15927-1-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1273620652-15927-6-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tero Kristo <tero.kristo@nokia.com>

setwkuena and setdataout are covered already by wake_en and dataout fields.

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/plat-omap/gpio.c |   10 ----------
 1 files changed, 0 insertions(+), 10 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index c6e1de5..b895cc9 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -305,8 +305,6 @@ struct omap3_gpio_regs {
 	u32 risingdetect;
 	u32 fallingdetect;
 	u32 dataout;
-	u32 setwkuena;
-	u32 setdataout;
 };
 
 static struct omap3_gpio_regs gpio_context[OMAP34XX_NR_GPIOS];
@@ -2241,10 +2239,6 @@ void omap_gpio_save_context(void)
 			__raw_readl(bank->base + OMAP24XX_GPIO_FALLINGDETECT);
 		gpio_context[i].dataout =
 			__raw_readl(bank->base + OMAP24XX_GPIO_DATAOUT);
-		gpio_context[i].setwkuena =
-			__raw_readl(bank->base + OMAP24XX_GPIO_SETWKUENA);
-		gpio_context[i].setdataout =
-			__raw_readl(bank->base + OMAP24XX_GPIO_SETDATAOUT);
 	}
 }
 
@@ -2277,10 +2271,6 @@ void omap_gpio_restore_context(void)
 				bank->base + OMAP24XX_GPIO_FALLINGDETECT);
 		__raw_writel(gpio_context[i].dataout,
 				bank->base + OMAP24XX_GPIO_DATAOUT);
-		__raw_writel(gpio_context[i].setwkuena,
-				bank->base + OMAP24XX_GPIO_SETWKUENA);
-		__raw_writel(gpio_context[i].setdataout,
-				bank->base + OMAP24XX_GPIO_SETDATAOUT);
 	}
 }
 #endif
-- 
1.7.0.2
