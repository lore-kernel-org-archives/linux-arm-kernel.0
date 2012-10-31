From: tony@atomide.com (Tony Lindgren)
Date: Wed, 31 Oct 2012 15:40:44 -0700
Subject: [PATCH 04/11] ARM: OMAP: Move omap2+ specific parts of sram.c
 to mach-omap2
In-Reply-To: <20121030235249.25936.15471.stgit@muffinssi.local>
References: <20121030234852.25936.12482.stgit@muffinssi.local>
 <20121030235249.25936.15471.stgit@muffinssi.local>
Message-ID: <20121031224044.GE15766@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [121030 16:54]:
> Let's make the omap2+ specific parts private to mach-omap2.
> 
> This leaves just a minimal shared code into plat-omap like
> it should be.

Found an error with make randconfig if we have
CONFIG_OMAP4_ERRATA_I688 enabled, I'll fold in the
following fix to this patch.

Regards,

Tony


--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -32,6 +32,7 @@
 #include "hsmmc.h"
 #include "omap4-sar-layout.h"
 #include "omap-secure.h"
+#include "sram.h"
 
 #ifdef CONFIG_CACHE_L2X0
 static void __iomem *l2cache_base;
