From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 2 Jan 2013 19:37:51 +0000 (UTC)
Subject: [PATCH 3/3] ARM: OMAP: SRAM: resolve sparse warnings
In-Reply-To: <20130101181508.GB22106@atomide.com>
References: <20121224012304.13698.43551.stgit@dusk.lan>
 <20121224012500.13698.73653.stgit@dusk.lan>
 <20130101181508.GB22106@atomide.com>
Message-ID: <alpine.DEB.2.00.1301021937120.17366@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On Tue, 1 Jan 2013, Tony Lindgren wrote:

> Here too we should just include <plat/sram.h>, that's OK for the
> multiplatform builds. Just drivers will not have it available.
> Then eventually the issue disappears as this code becomes a regular
> device driver.

Sounds good; the updated patch follows.


- Paul

From: Paul Walmsley <paul@pwsan.com>
Date: Fri, 28 Dec 2012 02:09:15 -0700
Subject: [PATCH] ARM: OMAP: SRAM: resolve sparse warnings

Commit bb77209432873214a796a70a4539e4ebdf3feb54 ("ARM: OMAP: Move
omap2+ specific parts of sram.c to mach-omap2") adds some new sparse
warnings:

arch/arm/plat-omap/sram.c:43:6: warning: symbol 'omap_sram_push_address' was not declared. Should it be static?
arch/arm/plat-omap/sram.c:65:6: warning: symbol 'omap_sram_reset' was not declared. Should it be static?
arch/arm/plat-omap/sram.c:73:13: warning: symbol 'omap_map_sram' was not declared. Should it be static?

This second version fixes the warnings by including <plat/sram.h>, at
Tony's request.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/sram.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index 743fc28..a5bc92d 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -26,6 +26,8 @@
 
 #include <asm/mach/map.h>
 
+#include <plat/sram.h>
+
 #define ROUND_DOWN(value,boundary)	((value) & (~((boundary)-1)))
 
 static void __iomem *omap_sram_base;
-- 
1.7.10.4
