From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 9 Oct 2012 20:29:16 +0000 (UTC)
Subject: [PATCH] ARM: OMAP: resolve sparse warning concerning debug_card_init()
Message-ID: <alpine.DEB.2.00.1210092028080.5736@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Commit 801475ccb2b2c1928b22aec4b9e5285d9e347602 ("ARM: OMAP: move
debug_card_init() function") results in the following new sparse
warning:

arch/arm/plat-omap/debug-devices.c:71:12: warning: symbol 'debug_card_init' was not declared. Should it be static?

Fix by implementing Tony's suggestion to add a "sideways include" to the
new location of the debug-devices.h file in arch/arm/mach-omap2/.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Igor Grinberg <grinberg@compulab.co.il>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/debug-devices.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/plat-omap/debug-devices.c b/arch/arm/plat-omap/debug-devices.c
index c7a4c09..5a4678e 100644
--- a/arch/arm/plat-omap/debug-devices.c
+++ b/arch/arm/plat-omap/debug-devices.c
@@ -16,6 +16,7 @@
 #include <linux/smc91x.h>
 
 #include <mach/hardware.h>
+#include "../mach-omap2/debug-devices.h"
 
 /* Many OMAP development platforms reuse the same "debug board"; these
  * platforms include H2, H3, H4, and Perseus2.
-- 
1.7.10.4
