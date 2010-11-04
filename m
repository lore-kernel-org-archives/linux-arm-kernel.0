From: zonque@gmail.com (Daniel Mack)
Date: Thu,  4 Nov 2010 14:44:01 -0400
Subject: [PATCH 2/2] ARM: pxa/raumfeld: enable PXA3XX_GCU driver
In-Reply-To: <1288896241-8318-1-git-send-email-zonque@gmail.com>
References: <1288896241-8318-1-git-send-email-zonque@gmail.com>
Message-ID: <1288896241-8318-3-git-send-email-zonque@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Daniel Mack <daniel@caiaq.de>

---
 arch/arm/mach-pxa/raumfeld.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-pxa/raumfeld.c b/arch/arm/mach-pxa/raumfeld.c
index 67e04f4..bbf0b61 100644
--- a/arch/arm/mach-pxa/raumfeld.c
+++ b/arch/arm/mach-pxa/raumfeld.c
@@ -588,6 +588,9 @@ static struct pxafb_mach_info raumfeld_sharp_lcd_info = {
 	.num_modes	= 1,
 	.video_mem_size = 0x400000,
 	.lcd_conn	= LCD_COLOR_TFT_16BPP | LCD_PCLK_EDGE_FALL,
+#ifdef CONFIG_PXA3XX_GCU
+	.acceleration_enabled = 1,
+#endif
 };
 
 static void __init raumfeld_lcd_init(void)
@@ -616,6 +619,8 @@ static void __init raumfeld_lcd_init(void)
 		pr_warning("Unable to request GPIO_DISPLAY_ENABLE\n");
 	else
 		gpio_direction_output(GPIO_DISPLAY_ENABLE, 1);
+
+	platform_device_register(&pxa3xx_device_gcu);
 }
 
 /**
-- 
1.7.1
