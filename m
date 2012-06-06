From: tony@atomide.com (Tony Lindgren)
Date: Wed, 06 Jun 2012 01:22:45 -0700
Subject: [PATCH 1/3] ARM: OMAP: Fix MMC_OMAP build when only MMC_OMAP_HS is
 selected
In-Reply-To: <20120606082156.727.42730.stgit@muffinssi.local>
References: <20120606082156.727.42730.stgit@muffinssi.local>
Message-ID: <20120606082245.727.1830.stgit@muffinssi.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If CONFIG_MMC_OMAP is not set and CONFIG_MMC_OMAP_HS is set,
we can get error: redefinition of `omap242x_init_mmc' error.

Fix it by removing MMC_OMAP_HS from MMC_OMAP ifdefs as they do
not depend on each other.

While at it, also prettify the formatting a bit.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/include/plat/mmc.h |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/mmc.h b/arch/arm/plat-omap/include/plat/mmc.h
index a7754a8..5493bd9 100644
--- a/arch/arm/plat-omap/include/plat/mmc.h
+++ b/arch/arm/plat-omap/include/plat/mmc.h
@@ -172,8 +172,7 @@ struct omap_mmc_platform_data {
 extern void omap_mmc_notify_cover_event(struct device *dev, int slot,
 					int is_closed);
 
-#if	defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE) || \
-	defined(CONFIG_MMC_OMAP_HS) || defined(CONFIG_MMC_OMAP_HS_MODULE)
+#if defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE)
 void omap1_init_mmc(struct omap_mmc_platform_data **mmc_data,
 				int nr_controllers);
 void omap242x_init_mmc(struct omap_mmc_platform_data **mmc_data);
@@ -185,7 +184,6 @@ static inline void omap1_init_mmc(struct omap_mmc_platform_data **mmc_data,
 static inline void omap242x_init_mmc(struct omap_mmc_platform_data **mmc_data)
 {
 }
-
 #endif
 
 extern int omap_msdi_reset(struct omap_hwmod *oh);
