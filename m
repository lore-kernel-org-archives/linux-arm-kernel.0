From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 25 Jan 2013 23:35:44 +0000
Subject: [PATCH 01/13] ARM: spear13xx: make mach/dma.h local
In-Reply-To: <1359156956-32404-1-git-send-email-arnd@arndb.de>
References: <1359156956-32404-1-git-send-email-arnd@arndb.de>
Message-ID: <1359156956-32404-2-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no reason for this header file to be globally visible, so
let's just move it into the mach directory.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-spear13xx/spear1340.c                             | 3 ++-
 arch/arm/mach-spear13xx/{include/mach/dma.h => spear13xx-dma.h} | 0
 arch/arm/mach-spear13xx/spear13xx.c                             | 3 ++-
 3 files changed, 4 insertions(+), 2 deletions(-)
 rename arch/arm/mach-spear13xx/{include/mach/dma.h => spear13xx-dma.h} (100%)

diff --git a/arch/arm/mach-spear13xx/spear1340.c b/arch/arm/mach-spear13xx/spear1340.c
index 081014f..7a183c3 100644
--- a/arch/arm/mach-spear13xx/spear1340.c
+++ b/arch/arm/mach-spear13xx/spear1340.c
@@ -20,10 +20,11 @@
 #include <linux/of_platform.h>
 #include <asm/hardware/gic.h>
 #include <asm/mach/arch.h>
-#include <mach/dma.h>
 #include <mach/generic.h>
 #include <mach/spear.h>
 
+#include "spear13xx-dma.h"
+
 /* Base addresses */
 #define SPEAR1340_SATA_BASE			UL(0xB1000000)
 #define SPEAR1340_UART1_BASE			UL(0xB4100000)
diff --git a/arch/arm/mach-spear13xx/include/mach/dma.h b/arch/arm/mach-spear13xx/spear13xx-dma.h
similarity index 100%
rename from arch/arm/mach-spear13xx/include/mach/dma.h
rename to arch/arm/mach-spear13xx/spear13xx-dma.h
diff --git a/arch/arm/mach-spear13xx/spear13xx.c b/arch/arm/mach-spear13xx/spear13xx.c
index c4af775..fcf5cc2 100644
--- a/arch/arm/mach-spear13xx/spear13xx.c
+++ b/arch/arm/mach-spear13xx/spear13xx.c
@@ -22,10 +22,11 @@
 #include <asm/hardware/gic.h>
 #include <asm/mach/map.h>
 #include <asm/smp_twd.h>
-#include <mach/dma.h>
 #include <mach/generic.h>
 #include <mach/spear.h>
 
+#include "spear13xx-dma.h"
+
 /* common dw_dma filter routine to be used by peripherals */
 bool dw_dma_filter(struct dma_chan *chan, void *slave)
 {
-- 
1.8.0
