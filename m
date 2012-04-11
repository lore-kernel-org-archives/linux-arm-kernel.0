From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 10 Apr 2012 18:35:55 -0600
Subject: [PATCH v4 09/12] ARM: OMAP: USB: remove unnecessary sideways include
In-Reply-To: <20120411003454.27059.37500.stgit@dusk>
References: <20120411003454.27059.37500.stgit@dusk>
Message-ID: <20120411003552.27059.63661.stgit@dusk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the include of mach-omap2/common.h from plat-omap/usb.c.  It
appears to be unneeded.  Removing it also resolves the sparse warning:

arch/arm/plat-omap/../mach-omap2/common.h:183:12: warning: symbol 'omap_intc_of_init' was not declared. Should it be static?

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/plat-omap/usb.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/plat-omap/usb.c b/arch/arm/plat-omap/usb.c
index d2bbfd1..ab62388 100644
--- a/arch/arm/plat-omap/usb.c
+++ b/arch/arm/plat-omap/usb.c
@@ -31,8 +31,6 @@
 
 #include <mach/hardware.h>
 
-#include "../mach-omap2/common.h"
-
 #ifdef	CONFIG_ARCH_OMAP_OTG
 
 void __init
