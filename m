From: khilman@ti.com (Kevin Hilman)
Date: Thu,  4 Aug 2011 08:45:10 -0700
Subject: [PATCH 6/6] OMAP: McBSP: use existing macros for converting between
	devices
In-Reply-To: <1312472710-31758-1-git-send-email-khilman@ti.com>
References: <1312472710-31758-1-git-send-email-khilman@ti.com>
Message-ID: <1312472710-31758-7-git-send-email-khilman@ti.com>
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
index 3c1fbdc..47016f7 100644
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
