From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Fri, 11 Jul 2014 13:00:37 +0200
Subject: [PATCH v4 2/4] ARM: pxa: Move UNCACHED_PHYS_0 mapping from generic.c
 to pxa2[57]x.c
In-Reply-To: <1405076439-22038-1-git-send-email-laurent.pinchart@ideasonboard.com>
References: <1405076439-22038-1-git-send-email-laurent.pinchart@ideasonboard.com>
Message-ID: <1405076439-22038-3-git-send-email-laurent.pinchart@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The UNCACHED_PHYS_0 mapping is only needed on PXA25x and PXA27x
platforms. Move it to pxa25x.c and pxa27x.c to avoid wasting vmalloc
space on PXA3xx.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Nicolas Pitre <nico@linaro.org>
---
 arch/arm/mach-pxa/generic.c | 5 -----
 arch/arm/mach-pxa/pxa25x.c  | 5 +++++
 arch/arm/mach-pxa/pxa27x.c  | 5 +++++
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-pxa/generic.c b/arch/arm/mach-pxa/generic.c
index 4bc0a2c..6bd7f36 100644
--- a/arch/arm/mach-pxa/generic.c
+++ b/arch/arm/mach-pxa/generic.c
@@ -83,11 +83,6 @@ static struct map_desc common_io_desc[] __initdata = {
 		.pfn		= __phys_to_pfn(PERIPH_PHYS),
 		.length		= PERIPH_SIZE,
 		.type		= MT_DEVICE
-	}, {	/* UNCACHED_PHYS_0 */
-		.virtual	= UNCACHED_PHYS_0,
-		.pfn		= __phys_to_pfn(0x00000000),
-		.length		= UNCACHED_PHYS_0_SIZE,
-		.type		= MT_DEVICE
 	}
 };
 
diff --git a/arch/arm/mach-pxa/pxa25x.c b/arch/arm/mach-pxa/pxa25x.c
index 926c506..66e4a2b 100644
--- a/arch/arm/mach-pxa/pxa25x.c
+++ b/arch/arm/mach-pxa/pxa25x.c
@@ -333,6 +333,11 @@ static struct map_desc pxa25x_io_desc[] __initdata = {
 		.pfn		= __phys_to_pfn(PXA2XX_SMEMC_BASE),
 		.length		= SMEMC_SIZE,
 		.type		= MT_DEVICE
+	}, {	/* UNCACHED_PHYS_0 */
+		.virtual	= UNCACHED_PHYS_0,
+		.pfn		= __phys_to_pfn(0x00000000),
+		.length		= UNCACHED_PHYS_0_SIZE,
+		.type		= MT_DEVICE
 	},
 };
 
diff --git a/arch/arm/mach-pxa/pxa27x.c b/arch/arm/mach-pxa/pxa27x.c
index 4405644..6cc0f46 100644
--- a/arch/arm/mach-pxa/pxa27x.c
+++ b/arch/arm/mach-pxa/pxa27x.c
@@ -409,6 +409,11 @@ static struct map_desc pxa27x_io_desc[] __initdata = {
 		.pfn		= __phys_to_pfn(IMEMC_PHYS),
 		.length		= IMEMC_SIZE,
 		.type		= MT_DEVICE
+	}, {	/* UNCACHED_PHYS_0 */
+		.virtual	= UNCACHED_PHYS_0,
+		.pfn		= __phys_to_pfn(0x00000000),
+		.length		= UNCACHED_PHYS_0_SIZE,
+		.type		= MT_DEVICE
 	},
 };
 
-- 
1.8.5.5
