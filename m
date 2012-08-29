From: robherring2@gmail.com (Rob Herring)
Date: Wed, 29 Aug 2012 17:31:32 -0500
Subject: [PATCH 06/10] ARM: shmobile: explicitly include mach/gpio.h
In-Reply-To: <1346279496-26286-1-git-send-email-robherring2@gmail.com>
References: <1346279496-26286-1-git-send-email-robherring2@gmail.com>
Message-ID: <1346279496-26286-7-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

In preparation to remove implicit inclusion of mach/gpio.h, add explict
includes of necessary headers.

shmobile always uses gpiolib, so we can remove some of mach/gpio.h.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Paul Mundt <lethal@linux-sh.org>
Cc: Magnus Damm <magnus.damm@gmail.com>
---
 arch/arm/mach-shmobile/board-ap4evb.c          |    1 +
 arch/arm/mach-shmobile/board-armadillo800eva.c |    1 +
 arch/arm/mach-shmobile/board-g4evm.c           |    1 +
 arch/arm/mach-shmobile/board-mackerel.c        |    1 +
 arch/arm/mach-shmobile/include/mach/gpio.h     |   14 --------------
 arch/arm/mach-shmobile/pfc-r8a7740.c           |    2 +-
 arch/arm/mach-shmobile/pfc-r8a7779.c           |    2 +-
 arch/arm/mach-shmobile/pfc-sh7367.c            |    2 +-
 arch/arm/mach-shmobile/pfc-sh7372.c            |    2 +-
 arch/arm/mach-shmobile/pfc-sh7377.c            |    2 +-
 arch/arm/mach-shmobile/pfc-sh73a0.c            |    2 +-
 drivers/sh/pfc/gpio.c                          |    1 +
 12 files changed, 11 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index f172ca8..65a959a 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -61,6 +61,7 @@
 #include <mach/common.h>
 #include <mach/irqs.h>
 #include <mach/sh7372.h>
+#include <mach/gpio.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index cf10f92..2e647d8 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -38,6 +38,7 @@
 #include <linux/mmc/sh_mmcif.h>
 #include <linux/mmc/sh_mobile_sdhi.h>
 #include <mach/common.h>
+#include <mach/gpio.h>
 #include <mach/irqs.h>
 #include <mach/r8a7740.h>
 #include <media/mt9t112.h>
diff --git a/arch/arm/mach-shmobile/board-g4evm.c b/arch/arm/mach-shmobile/board-g4evm.c
index fa5dfc5..b8688c1 100644
--- a/arch/arm/mach-shmobile/board-g4evm.c
+++ b/arch/arm/mach-shmobile/board-g4evm.c
@@ -36,6 +36,7 @@
 #include <linux/mmc/sh_mobile_sdhi.h>
 #include <linux/gpio.h>
 #include <linux/dma-mapping.h>
+#include <mach/gpio.h>
 #include <mach/irqs.h>
 #include <mach/sh7377.h>
 #include <mach/common.h>
diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index 7ea2b31..86e72a0 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -60,6 +60,7 @@
 #include <mach/common.h>
 #include <mach/irqs.h>
 #include <mach/sh7372.h>
+#include <mach/gpio.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
diff --git a/arch/arm/mach-shmobile/include/mach/gpio.h b/arch/arm/mach-shmobile/include/mach/gpio.h
index 844507d..7ba1877 100644
--- a/arch/arm/mach-shmobile/include/mach/gpio.h
+++ b/arch/arm/mach-shmobile/include/mach/gpio.h
@@ -12,22 +12,8 @@
 
 #include <linux/kernel.h>
 #include <linux/errno.h>
-#include <linux/sh_pfc.h>
 #include <linux/io.h>
 
-#ifdef CONFIG_GPIOLIB
-
-static inline int irq_to_gpio(unsigned int irq)
-{
-	return -ENOSYS;
-}
-
-#else
-
-#define __ARM_GPIOLIB_COMPLEX
-
-#endif /* CONFIG_GPIOLIB */
-
 /*
  * FIXME !!
  *
diff --git a/arch/arm/mach-shmobile/pfc-r8a7740.c b/arch/arm/mach-shmobile/pfc-r8a7740.c
index ce9e7fa..134d1b9 100644
--- a/arch/arm/mach-shmobile/pfc-r8a7740.c
+++ b/arch/arm/mach-shmobile/pfc-r8a7740.c
@@ -20,7 +20,7 @@
  */
 #include <linux/init.h>
 #include <linux/kernel.h>
-#include <linux/gpio.h>
+#include <linux/sh_pfc.h>
 #include <mach/r8a7740.h>
 #include <mach/irqs.h>
 
diff --git a/arch/arm/mach-shmobile/pfc-r8a7779.c b/arch/arm/mach-shmobile/pfc-r8a7779.c
index d14c9b0..cbc26ba 100644
--- a/arch/arm/mach-shmobile/pfc-r8a7779.c
+++ b/arch/arm/mach-shmobile/pfc-r8a7779.c
@@ -19,7 +19,7 @@
  */
 #include <linux/init.h>
 #include <linux/kernel.h>
-#include <linux/gpio.h>
+#include <linux/sh_pfc.h>
 #include <linux/ioport.h>
 #include <mach/r8a7779.h>
 
diff --git a/arch/arm/mach-shmobile/pfc-sh7367.c b/arch/arm/mach-shmobile/pfc-sh7367.c
index e6e5246..c0c137f 100644
--- a/arch/arm/mach-shmobile/pfc-sh7367.c
+++ b/arch/arm/mach-shmobile/pfc-sh7367.c
@@ -18,7 +18,7 @@
  */
 #include <linux/init.h>
 #include <linux/kernel.h>
-#include <linux/gpio.h>
+#include <linux/sh_pfc.h>
 #include <mach/sh7367.h>
 
 #define CPU_ALL_PORT(fn, pfx, sfx)				\
diff --git a/arch/arm/mach-shmobile/pfc-sh7372.c b/arch/arm/mach-shmobile/pfc-sh7372.c
index 336093f9..7a1525f 100644
--- a/arch/arm/mach-shmobile/pfc-sh7372.c
+++ b/arch/arm/mach-shmobile/pfc-sh7372.c
@@ -22,7 +22,7 @@
  */
 #include <linux/init.h>
 #include <linux/kernel.h>
-#include <linux/gpio.h>
+#include <linux/sh_pfc.h>
 #include <mach/irqs.h>
 #include <mach/sh7372.h>
 
diff --git a/arch/arm/mach-shmobile/pfc-sh7377.c b/arch/arm/mach-shmobile/pfc-sh7377.c
index 2f10511..f3117f6 100644
--- a/arch/arm/mach-shmobile/pfc-sh7377.c
+++ b/arch/arm/mach-shmobile/pfc-sh7377.c
@@ -19,7 +19,7 @@
  */
 #include <linux/init.h>
 #include <linux/kernel.h>
-#include <linux/gpio.h>
+#include <linux/sh_pfc.h>
 #include <mach/sh7377.h>
 
 #define CPU_ALL_PORT(fn, pfx, sfx)				\
diff --git a/arch/arm/mach-shmobile/pfc-sh73a0.c b/arch/arm/mach-shmobile/pfc-sh73a0.c
index 4a547b8..b442f9d 100644
--- a/arch/arm/mach-shmobile/pfc-sh73a0.c
+++ b/arch/arm/mach-shmobile/pfc-sh73a0.c
@@ -20,7 +20,7 @@
  */
 #include <linux/init.h>
 #include <linux/kernel.h>
-#include <linux/gpio.h>
+#include <linux/sh_pfc.h>
 #include <mach/sh73a0.h>
 #include <mach/irqs.h>
 
diff --git a/drivers/sh/pfc/gpio.c b/drivers/sh/pfc/gpio.c
index 62bca98..038fa07 100644
--- a/drivers/sh/pfc/gpio.c
+++ b/drivers/sh/pfc/gpio.c
@@ -17,6 +17,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/pinctrl/consumer.h>
+#include <linux/sh_pfc.h>
 
 struct sh_pfc_chip {
 	struct sh_pfc		*pfc;
-- 
1.7.9.5
