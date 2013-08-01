From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  1 Aug 2013 17:26:54 +0900
Subject: [PATCH 12/14] ARM: shmobile: No need to use INTC header on r8a7779
In-Reply-To: <cover.1375344714.git.horms+renesas@verge.net.au>
References: <cover.1375344714.git.horms+renesas@verge.net.au>
Message-ID: <d2ef0b9a5192e921490d2f66f4467f26235412bd.1375344714.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Now when the intc-irqpin driver is used for external
IRQ pins on r8a7779 it possible to get rid of unused
INTC headers mach/intc.h and linux/sh_intc.h.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/intc-r8a7779.c  | 1 -
 arch/arm/mach-shmobile/setup-r8a7779.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/intc-r8a7779.c b/arch/arm/mach-shmobile/intc-r8a7779.c
index b86dc89..5f9e5dc 100644
--- a/arch/arm/mach-shmobile/intc-r8a7779.c
+++ b/arch/arm/mach-shmobile/intc-r8a7779.c
@@ -27,7 +27,6 @@
 #include <linux/platform_data/irq-renesas-intc-irqpin.h>
 #include <linux/irqchip.h>
 #include <mach/common.h>
-#include <mach/intc.h>
 #include <mach/irqs.h>
 #include <mach/r8a7779.h>
 #include <asm/mach-types.h>
diff --git a/arch/arm/mach-shmobile/setup-r8a7779.c b/arch/arm/mach-shmobile/setup-r8a7779.c
index 6ab7405..bb8b967 100644
--- a/arch/arm/mach-shmobile/setup-r8a7779.c
+++ b/arch/arm/mach-shmobile/setup-r8a7779.c
@@ -29,7 +29,6 @@
 #include <linux/input.h>
 #include <linux/io.h>
 #include <linux/serial_sci.h>
-#include <linux/sh_intc.h>
 #include <linux/sh_timer.h>
 #include <linux/dma-mapping.h>
 #include <linux/usb/otg.h>
-- 
1.8.3.2
