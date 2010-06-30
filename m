From: siccegge@cs.fau.de (Christoph Egger)
Date: Wed, 30 Jun 2010 18:00:41 +0200
Subject: [PATCH 21/33] Removing dead OMAP2_VENC_OUT_TYPE_SVIDEO,
	OMAP2_VENC_OUT_TYPE_COMPOSITE
In-Reply-To: <cover.1277911345.git.siccegge@cs.fau.de>
References: <cover.1277911345.git.siccegge@cs.fau.de>
Message-ID: <2709d1406900af2436f6f8af00555507baf8dac9.1277911346.git.siccegge@cs.fau.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

OMAP2_VENC_OUT_TYPE_SVIDEO, OMAP2_VENC_OUT_TYPE_COMPOSITE doesn't
exist in Kconfig, therefore removing all references for it from the
source code.

Signed-off-by: Christoph Egger <siccegge@cs.fau.de>
---
 arch/arm/mach-omap2/board-omap3stalker.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3stalker.c b/arch/arm/mach-omap2/board-omap3stalker.c
index f848ba8..b38afd5 100644
--- a/arch/arm/mach-omap2/board-omap3stalker.c
+++ b/arch/arm/mach-omap2/board-omap3stalker.c
@@ -181,11 +181,6 @@ static struct omap_dss_device omap3_stalker_tv_device = {
 	.name			= "tv",
 	.driver_name		= "venc",
 	.type			= OMAP_DISPLAY_TYPE_VENC,
-#if defined(CONFIG_OMAP2_VENC_OUT_TYPE_SVIDEO)
-	.phy.venc.type		= OMAP_DSS_VENC_TYPE_SVIDEO,
-#elif defined(CONFIG_OMAP2_VENC_OUT_TYPE_COMPOSITE)
-	.u.venc.type		= OMAP_DSS_VENC_TYPE_COMPOSITE,
-#endif
 	.platform_enable	= omap3_stalker_enable_tv,
 	.platform_disable	= omap3_stalker_disable_tv,
 };
-- 
1.7.0.4
