From: tony@atomide.com (Tony Lindgren)
Date: Wed, 31 Oct 2012 14:11:38 -0700
Subject: [PATCH 11/11] ARM: OMAP1: Remove relative includes
In-Reply-To: <20121030235306.25936.38688.stgit@muffinssi.local>
References: <20121030234852.25936.12482.stgit@muffinssi.local>
 <20121030235306.25936.38688.stgit@muffinssi.local>
Message-ID: <20121031211137.GP12739@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [121030 16:55]:
> As discussed on linux-arm-kernel, we want to avoid
> relative includes for the arch/arm/*omap* code:
> 
> http://www.spinics.net/lists/linux-omap/msg80520.html
> 
> Note that eventually when the omap1 specific drivers
> are fixed to not use cpu_is_omap macros and not depend
> on mach/hardware.h, this patch can be reverted and these
> headers can be local. But since just fixing the drivers for
> omap2+ is already a big enough hassle, let's deal
> with that properly first.

Forgot to change plat/cpu.h in this patch, will fold it
into this patch as below.

Regards,

Tony

--- a/arch/arm/plat-omap/include/plat/cpu.h
+++ b/arch/arm/plat-omap/include/plat/cpu.h
@@ -29,7 +29,7 @@
 #define __ASM_ARCH_OMAP_CPU_H
 
 #ifdef CONFIG_ARCH_OMAP1
-#include "../../mach-omap1/soc.h"
+#include <mach/soc.h>
 #endif
 
 #ifdef CONFIG_ARCH_OMAP2PLUS
