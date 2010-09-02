From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu,  2 Sep 2010 10:03:39 +0200
Subject: [PATCH 2/5] ARM: omap/fb: move omapfb_reserve_sram to .init.text
In-Reply-To: <1283408230-22652-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1283408230-22652-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1283414622-2663-2-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This function is only called by omap_detect_sram which lives in .init.text,
too.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/plat-omap/fb.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-omap/fb.c b/arch/arm/plat-omap/fb.c
index a727133..72a36ca 100644
--- a/arch/arm/plat-omap/fb.c
+++ b/arch/arm/plat-omap/fb.c
@@ -262,7 +262,7 @@ void __init omapfb_reserve_sdram_memblock(void)
  * this point, since the driver built as a module would have problem with
  * freeing / reallocating the regions.
  */
-unsigned long omapfb_reserve_sram(unsigned long sram_pstart,
+unsigned long __init omapfb_reserve_sram(unsigned long sram_pstart,
 				  unsigned long sram_vstart,
 				  unsigned long sram_size,
 				  unsigned long pstart_avail,
@@ -392,7 +392,7 @@ void omapfb_reserve_sdram_memblock(void)
 {
 }
 
-unsigned long omapfb_reserve_sram(unsigned long sram_pstart,
+unsigned long __init omapfb_reserve_sram(unsigned long sram_pstart,
 				  unsigned long sram_vstart,
 				  unsigned long sram_size,
 				  unsigned long start_avail,
@@ -411,7 +411,7 @@ void omapfb_reserve_sdram_memblock(void)
 {
 }
 
-unsigned long omapfb_reserve_sram(unsigned long sram_pstart,
+unsigned long __init omapfb_reserve_sram(unsigned long sram_pstart,
 				  unsigned long sram_vstart,
 				  unsigned long sram_size,
 				  unsigned long start_avail,
-- 
1.7.1
