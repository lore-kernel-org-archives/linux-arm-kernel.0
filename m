From: tony@atomide.com (Tony Lindgren)
Date: Thu, 1 Nov 2012 16:14:29 -0700
Subject: [PATCH 3/3] ARM: OMAP: Remove plat-omap/common.c
In-Reply-To: <20121101224828.2103.82950.stgit@muffinssi.local>
References: <20121101224703.2103.95474.stgit@muffinssi.local>
 <20121101224828.2103.82950.stgit@muffinssi.local>
Message-ID: <20121101231429.GO15766@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [121101 15:50]:
> This file has only omap_init_consistent_dma_size()
> left that can be moved to plat-omap/dma.c.

And this one needs the following compile fix for omap1
at least for Nokia 770. I'll fold it in.

Regards,

Tony


--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -35,6 +35,7 @@
 #include <linux/io.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
+#include <linux/dma-mapping.h>
 
 #include <plat-omap/dma-omap.h>
 
