From: b.brezillon@overkiz.com (Boris BREZILLON)
Date: Thu,  8 Aug 2013 06:59:05 +0200
Subject: [PATCH v3 01/19] ARM: at91: move at91_pmc.h to
 include/linux/clk/at91_pmc.h
In-Reply-To: <1375937608-3773-1-git-send-email-b.brezillon@overkiz.com>
References: <1375937608-3773-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <1375937945-3851-1-git-send-email-b.brezillon@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch moves at91_pmc.h header from machine specific directory
(arch/arm/mach-at91/include/mach/at91_pmc.h) to clk include directory
(include/linux/clk/at91_pmc.h).
We need this to avoid reference to machine specific headers in clk
drivers.

Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
---
 arch/arm/mach-at91/at91rm9200.c                    |    2 +-
 arch/arm/mach-at91/at91sam9260.c                   |    2 +-
 arch/arm/mach-at91/at91sam9261.c                   |    2 +-
 arch/arm/mach-at91/at91sam9263.c                   |    2 +-
 arch/arm/mach-at91/at91sam9g45.c                   |    2 +-
 arch/arm/mach-at91/at91sam9n12.c                   |    2 +-
 arch/arm/mach-at91/at91sam9rl.c                    |    2 +-
 arch/arm/mach-at91/at91sam9x5.c                    |    2 +-
 arch/arm/mach-at91/clock.c                         |    2 +-
 arch/arm/mach-at91/pm.c                            |    2 +-
 arch/arm/mach-at91/pm_slowclock.S                  |    2 +-
 arch/arm/mach-at91/sama5d3.c                       |    2 +-
 arch/arm/mach-at91/setup.c                         |    2 +-
 drivers/usb/gadget/atmel_usba_udc.c                |    2 +-
 .../include/mach => include/linux/clk}/at91_pmc.h  |    2 +-
 15 files changed, 15 insertions(+), 15 deletions(-)
 rename {arch/arm/mach-at91/include/mach => include/linux/clk}/at91_pmc.h (99%)

diff --git a/arch/arm/mach-at91/at91rm9200.c b/arch/arm/mach-at91/at91rm9200.c
index 4aad93d..102dac6 100644
--- a/arch/arm/mach-at91/at91rm9200.c
+++ b/arch/arm/mach-at91/at91rm9200.c
@@ -12,13 +12,13 @@
 
 #include <linux/module.h>
 #include <linux/reboot.h>
+#include <linux/clk/at91_pmc.h>
 
 #include <asm/irq.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/system_misc.h>
 #include <mach/at91rm9200.h>
-#include <mach/at91_pmc.h>
 #include <mach/at91_st.h>
 #include <mach/cpu.h>
 
diff --git a/arch/arm/mach-at91/at91sam9260.c b/arch/arm/mach-at91/at91sam9260.c
index 5de6074..16d7817 100644
--- a/arch/arm/mach-at91/at91sam9260.c
+++ b/arch/arm/mach-at91/at91sam9260.c
@@ -11,6 +11,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/clk/at91_pmc.h>
 
 #include <asm/proc-fns.h>
 #include <asm/irq.h>
@@ -20,7 +21,6 @@
 #include <mach/cpu.h>
 #include <mach/at91_dbgu.h>
 #include <mach/at91sam9260.h>
-#include <mach/at91_pmc.h>
 
 #include "at91_aic.h"
 #include "at91_rstc.h"
diff --git a/arch/arm/mach-at91/at91sam9261.c b/arch/arm/mach-at91/at91sam9261.c
index 0e07932..c8f5958 100644
--- a/arch/arm/mach-at91/at91sam9261.c
+++ b/arch/arm/mach-at91/at91sam9261.c
@@ -11,6 +11,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/clk/at91_pmc.h>
 
 #include <asm/proc-fns.h>
 #include <asm/irq.h>
@@ -19,7 +20,6 @@
 #include <asm/system_misc.h>
 #include <mach/cpu.h>
 #include <mach/at91sam9261.h>
-#include <mach/at91_pmc.h>
 
 #include "at91_aic.h"
 #include "at91_rstc.h"
diff --git a/arch/arm/mach-at91/at91sam9263.c b/arch/arm/mach-at91/at91sam9263.c
index 6ce7d18..cd8ad95 100644
--- a/arch/arm/mach-at91/at91sam9263.c
+++ b/arch/arm/mach-at91/at91sam9263.c
@@ -11,6 +11,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/clk/at91_pmc.h>
 
 #include <asm/proc-fns.h>
 #include <asm/irq.h>
@@ -18,7 +19,6 @@
 #include <asm/mach/map.h>
 #include <asm/system_misc.h>
 #include <mach/at91sam9263.h>
-#include <mach/at91_pmc.h>
 
 #include "at91_aic.h"
 #include "at91_rstc.h"
diff --git a/arch/arm/mach-at91/at91sam9g45.c b/arch/arm/mach-at91/at91sam9g45.c
index 474ee04..9794b20 100644
--- a/arch/arm/mach-at91/at91sam9g45.c
+++ b/arch/arm/mach-at91/at91sam9g45.c
@@ -12,13 +12,13 @@
 
 #include <linux/module.h>
 #include <linux/dma-mapping.h>
+#include <linux/clk/at91_pmc.h>
 
 #include <asm/irq.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/system_misc.h>
 #include <mach/at91sam9g45.h>
-#include <mach/at91_pmc.h>
 #include <mach/cpu.h>
 
 #include "at91_aic.h"
diff --git a/arch/arm/mach-at91/at91sam9n12.c b/arch/arm/mach-at91/at91sam9n12.c
index c7d670d..5b83c66 100644
--- a/arch/arm/mach-at91/at91sam9n12.c
+++ b/arch/arm/mach-at91/at91sam9n12.c
@@ -8,12 +8,12 @@
 
 #include <linux/module.h>
 #include <linux/dma-mapping.h>
+#include <linux/clk/at91_pmc.h>
 
 #include <asm/irq.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <mach/at91sam9n12.h>
-#include <mach/at91_pmc.h>
 #include <mach/cpu.h>
 
 #include "board.h"
diff --git a/arch/arm/mach-at91/at91sam9rl.c b/arch/arm/mach-at91/at91sam9rl.c
index d4ec0d9..947da95 100644
--- a/arch/arm/mach-at91/at91sam9rl.c
+++ b/arch/arm/mach-at91/at91sam9rl.c
@@ -10,6 +10,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/clk/at91_pmc.h>
 
 #include <asm/proc-fns.h>
 #include <asm/irq.h>
@@ -19,7 +20,6 @@
 #include <mach/cpu.h>
 #include <mach/at91_dbgu.h>
 #include <mach/at91sam9rl.h>
-#include <mach/at91_pmc.h>
 
 #include "at91_aic.h"
 #include "at91_rstc.h"
diff --git a/arch/arm/mach-at91/at91sam9x5.c b/arch/arm/mach-at91/at91sam9x5.c
index 2abee66..0c527da 100644
--- a/arch/arm/mach-at91/at91sam9x5.c
+++ b/arch/arm/mach-at91/at91sam9x5.c
@@ -8,12 +8,12 @@
 
 #include <linux/module.h>
 #include <linux/dma-mapping.h>
+#include <linux/clk/at91_pmc.h>
 
 #include <asm/irq.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <mach/at91sam9x5.h>
-#include <mach/at91_pmc.h>
 #include <mach/cpu.h>
 
 #include "board.h"
diff --git a/arch/arm/mach-at91/clock.c b/arch/arm/mach-at91/clock.c
index 6b2630a..5f02aea 100644
--- a/arch/arm/mach-at91/clock.c
+++ b/arch/arm/mach-at91/clock.c
@@ -24,9 +24,9 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/of_address.h>
+#include <linux/clk/at91_pmc.h>
 
 #include <mach/hardware.h>
-#include <mach/at91_pmc.h>
 #include <mach/cpu.h>
 
 #include <asm/proc-fns.h>
diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 15afb5d..692cacd 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -19,13 +19,13 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
+#include <linux/clk/at91_pmc.h>
 
 #include <asm/irq.h>
 #include <linux/atomic.h>
 #include <asm/mach/time.h>
 #include <asm/mach/irq.h>
 
-#include <mach/at91_pmc.h>
 #include <mach/cpu.h>
 
 #include "at91_aic.h"
diff --git a/arch/arm/mach-at91/pm_slowclock.S b/arch/arm/mach-at91/pm_slowclock.S
index 098c28d..2001877 100644
--- a/arch/arm/mach-at91/pm_slowclock.S
+++ b/arch/arm/mach-at91/pm_slowclock.S
@@ -13,8 +13,8 @@
  */
 
 #include <linux/linkage.h>
+#include <linux/clk/at91_pmc.h>
 #include <mach/hardware.h>
-#include <mach/at91_pmc.h>
 #include <mach/at91_ramc.h>
 
 
diff --git a/arch/arm/mach-at91/sama5d3.c b/arch/arm/mach-at91/sama5d3.c
index 4012797..0003949 100644
--- a/arch/arm/mach-at91/sama5d3.c
+++ b/arch/arm/mach-at91/sama5d3.c
@@ -9,12 +9,12 @@
 
 #include <linux/module.h>
 #include <linux/dma-mapping.h>
+#include <linux/clk/at91_pmc.h>
 
 #include <asm/irq.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <mach/sama5d3.h>
-#include <mach/at91_pmc.h>
 #include <mach/cpu.h>
 
 #include "soc.h"
diff --git a/arch/arm/mach-at91/setup.c b/arch/arm/mach-at91/setup.c
index b17fbcf..41aa68b 100644
--- a/arch/arm/mach-at91/setup.c
+++ b/arch/arm/mach-at91/setup.c
@@ -11,6 +11,7 @@
 #include <linux/pm.h>
 #include <linux/of_address.h>
 #include <linux/pinctrl/machine.h>
+#include <linux/clk/at91_pmc.h>
 
 #include <asm/system_misc.h>
 #include <asm/mach/map.h>
@@ -18,7 +19,6 @@
 #include <mach/hardware.h>
 #include <mach/cpu.h>
 #include <mach/at91_dbgu.h>
-#include <mach/at91_pmc.h>
 
 #include "at91_shdwc.h"
 #include "soc.h"
diff --git a/drivers/usb/gadget/atmel_usba_udc.c b/drivers/usb/gadget/atmel_usba_udc.c
index f018017..3615ef5 100644
--- a/drivers/usb/gadget/atmel_usba_udc.c
+++ b/drivers/usb/gadget/atmel_usba_udc.c
@@ -326,7 +326,7 @@ static int vbus_is_present(struct usba_udc *udc)
 
 #if defined(CONFIG_ARCH_AT91SAM9RL)
 
-#include <mach/at91_pmc.h>
+#include <linux/clk/at91_pmc.h>
 
 static void toggle_bias(int is_on)
 {
diff --git a/arch/arm/mach-at91/include/mach/at91_pmc.h b/include/linux/clk/at91_pmc.h
similarity index 99%
rename from arch/arm/mach-at91/include/mach/at91_pmc.h
rename to include/linux/clk/at91_pmc.h
index c604cc6..00c45b3 100644
--- a/arch/arm/mach-at91/include/mach/at91_pmc.h
+++ b/include/linux/clk/at91_pmc.h
@@ -1,5 +1,5 @@
 /*
- * arch/arm/mach-at91/include/mach/at91_pmc.h
+ * include/linux/clk/at91_pmc.h
  *
  * Copyright (C) 2005 Ivan Kokshaysky
  * Copyright (C) SAN People
-- 
1.7.9.5
