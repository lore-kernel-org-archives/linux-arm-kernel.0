From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri, 23 Jul 2010 21:58:29 +0200
Subject: [PATCH 06/11] ARM: omap: move omapfb_reserve_sdram() to .init.text
In-Reply-To: <1279915120-4373-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1279915120-4373-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1279915120-4373-6-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

omapfb_reserve_sdram() is only called by omap1_map_common_io() and
_omap2_map_common_io() that both live in .init.text.  So this is save
for omapfb_reserve_sdram(), too.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/plat-omap/fb.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/fb.c b/arch/arm/plat-omap/fb.c
index e8a390d..4df210f 100644
--- a/arch/arm/plat-omap/fb.c
+++ b/arch/arm/plat-omap/fb.c
@@ -359,7 +359,7 @@ static int __init omap_init_fb(void)
 
 arch_initcall(omap_init_fb);
 
-void omapfb_reserve_sdram(void) {}
+void __init omapfb_reserve_sdram(void) {}
 unsigned long omapfb_reserve_sram(unsigned long sram_pstart,
 				  unsigned long sram_vstart,
 				  unsigned long sram_size,
@@ -375,7 +375,7 @@ void omapfb_set_platform_data(struct omapfb_platform_data *data)
 {
 }
 
-void omapfb_reserve_sdram(void) {}
+void __init omapfb_reserve_sdram(void) {}
 unsigned long omapfb_reserve_sram(unsigned long sram_pstart,
 				  unsigned long sram_vstart,
 				  unsigned long sram_size,
-- 
1.7.1
