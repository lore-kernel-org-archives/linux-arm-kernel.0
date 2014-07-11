From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Fri, 11 Jul 2014 13:00:38 +0200
Subject: [PATCH v4 3/4] ARM: pxa: pxa27x: Don't map IMEMC region statically
In-Reply-To: <1405076439-22038-1-git-send-email-laurent.pinchart@ideasonboard.com>
References: <1405076439-22038-1-git-send-email-laurent.pinchart@ideasonboard.com>
Message-ID: <1405076439-22038-4-git-send-email-laurent.pinchart@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The IMEMC mapping not only has no user, but maps a reserved memory
space. It just wastes vmalloc space, remove it.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Nicolas Pitre <nico@linaro.org>
---
 arch/arm/mach-pxa/pxa27x.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/mach-pxa/pxa27x.c b/arch/arm/mach-pxa/pxa27x.c
index 6cc0f46..b040d7d 100644
--- a/arch/arm/mach-pxa/pxa27x.c
+++ b/arch/arm/mach-pxa/pxa27x.c
@@ -404,11 +404,6 @@ static struct map_desc pxa27x_io_desc[] __initdata = {
 		.pfn		= __phys_to_pfn(PXA2XX_SMEMC_BASE),
 		.length		= SMEMC_SIZE,
 		.type		= MT_DEVICE
-	}, {	/* IMem ctl */
-		.virtual	= (unsigned long)IMEMC_VIRT,
-		.pfn		= __phys_to_pfn(IMEMC_PHYS),
-		.length		= IMEMC_SIZE,
-		.type		= MT_DEVICE
 	}, {	/* UNCACHED_PHYS_0 */
 		.virtual	= UNCACHED_PHYS_0,
 		.pfn		= __phys_to_pfn(0x00000000),
-- 
1.8.5.5
