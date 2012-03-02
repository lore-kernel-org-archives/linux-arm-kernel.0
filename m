From: robherring2@gmail.com (Rob Herring)
Date: Thu,  1 Mar 2012 21:13:20 -0600
Subject: [PATCH v3 08/30] ARM: OMAP: Remove remaining includes for mach/io.h
In-Reply-To: <1330658022-14559-1-git-send-email-robherring2@gmail.com>
References: <1330658022-14559-1-git-send-email-robherring2@gmail.com>
Message-ID: <1330658022-14559-9-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tony Lindgren <tony@atomide.com>

These are no longer needed with the recent iomap.h
changes.

Reported-by: Rob Herring <robherring2@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
---
 arch/arm/mach-omap1/include/mach/entry-macro.S |    1 -
 arch/arm/mach-omap1/sram.S                     |    1 -
 arch/arm/plat-omap/include/plat/sdrc.h         |    1 -
 drivers/video/omap2/vrfb.c                     |    1 -
 4 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap1/include/mach/entry-macro.S b/arch/arm/mach-omap1/include/mach/entry-macro.S
index 68d2679..d0b18b5 100644
--- a/arch/arm/mach-omap1/include/mach/entry-macro.S
+++ b/arch/arm/mach-omap1/include/mach/entry-macro.S
@@ -11,7 +11,6 @@
  */
 
 #include <mach/hardware.h>
-#include <mach/io.h>
 #include <mach/irqs.h>
 
 #include "../../iomap.h"
diff --git a/arch/arm/mach-omap1/sram.S b/arch/arm/mach-omap1/sram.S
index 2ce0b9a..00e9d9e 100644
--- a/arch/arm/mach-omap1/sram.S
+++ b/arch/arm/mach-omap1/sram.S
@@ -12,7 +12,6 @@
 
 #include <asm/assembler.h>
 
-#include <mach/io.h>
 #include <mach/hardware.h>
 
 #include "iomap.h"
diff --git a/arch/arm/plat-omap/include/plat/sdrc.h b/arch/arm/plat-omap/include/plat/sdrc.h
index 925b12b..9bb978e 100644
--- a/arch/arm/plat-omap/include/plat/sdrc.h
+++ b/arch/arm/plat-omap/include/plat/sdrc.h
@@ -16,7 +16,6 @@
  * published by the Free Software Foundation.
  */
 
-#include <mach/io.h>
 
 /* SDRC register offsets - read/write with sdrc_{read,write}_reg() */
 
diff --git a/drivers/video/omap2/vrfb.c b/drivers/video/omap2/vrfb.c
index fd22716..4e5b960 100644
--- a/drivers/video/omap2/vrfb.c
+++ b/drivers/video/omap2/vrfb.c
@@ -27,7 +27,6 @@
 #include <linux/bitops.h>
 #include <linux/mutex.h>
 
-#include <mach/io.h>
 #include <plat/vrfb.h>
 #include <plat/sdrc.h>
 
-- 
1.7.5.4
