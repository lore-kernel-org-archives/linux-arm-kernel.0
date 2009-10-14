From: a.j.buxton@gmail.com (Alistair Buxton)
Date: Wed, 14 Oct 2009 20:51:42 +0100
Subject: [PATCH 14/17] OMAP7XX: omap_uwire.c: Convert to omap7xx.h
Message-ID: <3d374d00910141251j1a80c39au55c19378c4e3665d@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This also replaces CPU checks with cpu_is_omap7xx()

Signed-off-by: Alistair Buxton <a.j.buxton@gmail.com>
Reviewed-by: Zebediah C. McClure <zmc@lurian.net>
---
 drivers/spi/omap_uwire.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/omap_uwire.c b/drivers/spi/omap_uwire.c
index e75ba9b..7bcf409 100644
--- a/drivers/spi/omap_uwire.c
+++ b/drivers/spi/omap_uwire.c
@@ -52,7 +52,7 @@
 #include <asm/mach-types.h>

 #include <mach/mux.h>
-#include <mach/omap730.h>	/* OMAP730_IO_CONF registers */
+#include <mach/omap7xx.h>	/* OMAP7XX_IO_CONF registers */


 /* FIXME address is now a platform device resource,
@@ -504,7 +504,7 @@ static int __init uwire_probe(struct platform_device *pdev)
 	}
 	clk_enable(uwire->ck);

-	if (cpu_is_omap730())
+	if (cpu_is_omap7xx())
 		uwire_idx_shift = 1;
 	else
 		uwire_idx_shift = 2;
@@ -573,8 +573,8 @@ static int __init omap_uwire_init(void)
 	}
 	if (machine_is_omap_perseus2()) {
 		/* configure pins: MPU_UW_nSCS1, MPU_UW_SDO, MPU_UW_SCLK */
-		int val = omap_readl(OMAP730_IO_CONF_9) & ~0x00EEE000;
-		omap_writel(val | 0x00AAA000, OMAP730_IO_CONF_9);
+		int val = omap_readl(OMAP7XX_IO_CONF_9) & ~0x00EEE000;
+		omap_writel(val | 0x00AAA000, OMAP7XX_IO_CONF_9);
 	}

 	return platform_driver_probe(&uwire_driver, uwire_probe);
-- 
1.6.5
