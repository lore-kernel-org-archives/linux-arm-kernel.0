From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu,  5 Aug 2010 16:08:39 +0200
Subject: [PATCH 05/19] ARM: omap: move get_fbmem_region() to .init.text
In-Reply-To: <20100805140813.GA13859@pengutronix.de>
References: <20100805140813.GA13859@pengutronix.de>
Message-ID: <1281017333-5563-5-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

get_fbmem_region() is only called by omapfb_reserve_sdram_memblock() and
omapfb_reserve_sram() that both live in .init.text.  So get_fbmem_region
can go there, too.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/plat-omap/fb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/fb.c b/arch/arm/plat-omap/fb.c
index a727133..6522f27 100644
--- a/arch/arm/plat-omap/fb.c
+++ b/arch/arm/plat-omap/fb.c
@@ -94,7 +94,7 @@ static int fbmem_region_reserved(unsigned long start, size_t size)
  * Get the region_idx`th region from board config/ATAG and convert it to
  * our internal format.
  */
-static int get_fbmem_region(int region_idx, struct omapfb_mem_region *rg)
+static int __init get_fbmem_region(int region_idx, struct omapfb_mem_region *rg)
 {
 	const struct omap_fbmem_config	*conf;
 	u32				paddr;
-- 
1.7.1
