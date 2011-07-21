From: khilman@ti.com (Kevin Hilman)
Date: Thu, 21 Jul 2011 14:03:51 -0700
Subject: [RFC/PATCH 3/7] OMAP: McBSP: use existing macros for converting
 between devices
Message-ID: <mailman.29.1311365969.20020.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For converting from struct device to platform_device, and from
platform_device to struct omap_device, there are existing macros.  Use
them instead of manual use of container_of().

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/plat-omap/mcbsp.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index 6c62af1..02199e8 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -260,9 +260,9 @@ EXPORT_SYMBOL(omap_mcbsp_dma_reg_params);
 #ifdef CONFIG_ARCH_OMAP3
 static struct omap_device *find_omap_device_by_dev(struct device *dev)
 {
-	struct platform_device *pdev = container_of(dev,
-					struct platform_device, dev);
-	return container_of(pdev, struct omap_device, pdev);
+	struct platform_device *pdev = to_platform_device(dev);
+
+	return to_omap_device(pdev);
 }
 
 static void omap_st_on(struct omap_mcbsp *mcbsp)
-- 
1.7.6
