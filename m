From: robherring2@gmail.com (Rob Herring)
Date: Fri, 20 Jan 2012 14:33:08 -0600
Subject: [PATCH v2 10/13] ARM: shmobile: remove NR_IRQS
In-Reply-To: <1327091591-27125-1-git-send-email-robherring2@gmail.com>
References: <1327091591-27125-1-git-send-email-robherring2@gmail.com>
Message-ID: <1327091591-27125-11-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Remove NR_IRQS and explicitly include mach/irqs.h as needed. shmobile
properly allocates irq_descs for each irqchip, so setting .nr_irqs for
each machine is not needed.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/mach-shmobile/board-ag5evm.c      |    1 +
 arch/arm/mach-shmobile/board-bonito.c      |    1 +
 arch/arm/mach-shmobile/board-g3evm.c       |    1 +
 arch/arm/mach-shmobile/board-g4evm.c       |    1 +
 arch/arm/mach-shmobile/board-kota2.c       |    1 +
 arch/arm/mach-shmobile/board-mackerel.c    |    1 +
 arch/arm/mach-shmobile/board-marzen.c      |    1 +
 arch/arm/mach-shmobile/include/mach/irqs.h |    2 --
 arch/arm/mach-shmobile/intc-r8a7740.c      |    1 +
 arch/arm/mach-shmobile/intc-sh7367.c       |    1 +
 arch/arm/mach-shmobile/intc-sh7372.c       |    1 +
 arch/arm/mach-shmobile/intc-sh7377.c       |    1 +
 arch/arm/mach-shmobile/intc-sh73a0.c       |    1 +
 arch/arm/mach-shmobile/setup-r8a7740.c     |    1 +
 arch/arm/mach-shmobile/setup-r8a7779.c     |    1 +
 arch/arm/mach-shmobile/setup-sh7367.c      |    1 +
 arch/arm/mach-shmobile/setup-sh7372.c      |    1 +
 arch/arm/mach-shmobile/setup-sh7377.c      |    1 +
 arch/arm/mach-shmobile/setup-sh73a0.c      |    1 +
 19 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ag5evm.c b/arch/arm/mach-shmobile/board-ag5evm.c
index eff8a96..e922e92 100644
--- a/arch/arm/mach-shmobile/board-ag5evm.c
+++ b/arch/arm/mach-shmobile/board-ag5evm.c
@@ -42,6 +42,7 @@
 #include <video/sh_mipi_dsi.h>
 #include <sound/sh_fsi.h>
 #include <mach/hardware.h>
+#include <mach/irqs.h>
 #include <mach/sh73a0.h>
 #include <mach/common.h>
 #include <asm/mach-types.h>
diff --git a/arch/arm/mach-shmobile/board-bonito.c b/arch/arm/mach-shmobile/board-bonito.c
index 4d22016..df9a653 100644
--- a/arch/arm/mach-shmobile/board-bonito.c
+++ b/arch/arm/mach-shmobile/board-bonito.c
@@ -34,6 +34,7 @@
 #include <asm/mach/time.h>
 #include <asm/hardware/cache-l2x0.h>
 #include <mach/r8a7740.h>
+#include <mach/irqs.h>
 #include <video/sh_mobile_lcdc.h>
 
 /*
diff --git a/arch/arm/mach-shmobile/board-g3evm.c b/arch/arm/mach-shmobile/board-g3evm.c
index 72d5572..6dbdc42 100644
--- a/arch/arm/mach-shmobile/board-g3evm.c
+++ b/arch/arm/mach-shmobile/board-g3evm.c
@@ -33,6 +33,7 @@
 #include <linux/input.h>
 #include <linux/input/sh_keysc.h>
 #include <linux/dma-mapping.h>
+#include <mach/irqs.h>
 #include <mach/sh7367.h>
 #include <mach/common.h>
 #include <asm/mach-types.h>
diff --git a/arch/arm/mach-shmobile/board-g4evm.c b/arch/arm/mach-shmobile/board-g4evm.c
index 2220b88..2936ccc 100644
--- a/arch/arm/mach-shmobile/board-g4evm.c
+++ b/arch/arm/mach-shmobile/board-g4evm.c
@@ -34,6 +34,7 @@
 #include <linux/mmc/sh_mobile_sdhi.h>
 #include <linux/gpio.h>
 #include <linux/dma-mapping.h>
+#include <mach/irqs.h>
 #include <mach/sh7377.h>
 #include <mach/common.h>
 #include <asm/mach-types.h>
diff --git a/arch/arm/mach-shmobile/board-kota2.c b/arch/arm/mach-shmobile/board-kota2.c
index 857ceee..c71780b 100644
--- a/arch/arm/mach-shmobile/board-kota2.c
+++ b/arch/arm/mach-shmobile/board-kota2.c
@@ -39,6 +39,7 @@
 #include <linux/mfd/tmio.h>
 #include <linux/mmc/sh_mobile_sdhi.h>
 #include <mach/hardware.h>
+#include <mach/irqs.h>
 #include <mach/sh73a0.h>
 #include <mach/common.h>
 #include <asm/mach-types.h>
diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index 9b42fbd..73f0097 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -55,6 +55,7 @@
 #include <sound/sh_fsi.h>
 
 #include <mach/common.h>
+#include <mach/irqs.h>
 #include <mach/sh7372.h>
 
 #include <asm/mach/arch.h>
diff --git a/arch/arm/mach-shmobile/board-marzen.c b/arch/arm/mach-shmobile/board-marzen.c
index f0e02c0..3b2e88a 100644
--- a/arch/arm/mach-shmobile/board-marzen.c
+++ b/arch/arm/mach-shmobile/board-marzen.c
@@ -31,6 +31,7 @@
 #include <mach/hardware.h>
 #include <mach/r8a7779.h>
 #include <mach/common.h>
+#include <mach/irqs.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
diff --git a/arch/arm/mach-shmobile/include/mach/irqs.h b/arch/arm/mach-shmobile/include/mach/irqs.h
index 828807d..4e686cc2 100644
--- a/arch/arm/mach-shmobile/include/mach/irqs.h
+++ b/arch/arm/mach-shmobile/include/mach/irqs.h
@@ -3,8 +3,6 @@
 
 #include <linux/sh_intc.h>
 
-#define NR_IRQS         1024
-
 /* GIC */
 #define gic_spi(nr)		((nr) + 32)
 
diff --git a/arch/arm/mach-shmobile/intc-r8a7740.c b/arch/arm/mach-shmobile/intc-r8a7740.c
index 272c84c..09c42af 100644
--- a/arch/arm/mach-shmobile/intc-r8a7740.c
+++ b/arch/arm/mach-shmobile/intc-r8a7740.c
@@ -25,6 +25,7 @@
 #include <linux/io.h>
 #include <linux/sh_intc.h>
 #include <mach/intc.h>
+#include <mach/irqs.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
diff --git a/arch/arm/mach-shmobile/intc-sh7367.c b/arch/arm/mach-shmobile/intc-sh7367.c
index cfde9bf..5bf7764 100644
--- a/arch/arm/mach-shmobile/intc-sh7367.c
+++ b/arch/arm/mach-shmobile/intc-sh7367.c
@@ -23,6 +23,7 @@
 #include <linux/io.h>
 #include <linux/sh_intc.h>
 #include <mach/intc.h>
+#include <mach/irqs.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
diff --git a/arch/arm/mach-shmobile/intc-sh7372.c b/arch/arm/mach-shmobile/intc-sh7372.c
index 89afcab..6447e0a 100644
--- a/arch/arm/mach-shmobile/intc-sh7372.c
+++ b/arch/arm/mach-shmobile/intc-sh7372.c
@@ -23,6 +23,7 @@
 #include <linux/io.h>
 #include <linux/sh_intc.h>
 #include <mach/intc.h>
+#include <mach/irqs.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
diff --git a/arch/arm/mach-shmobile/intc-sh7377.c b/arch/arm/mach-shmobile/intc-sh7377.c
index 2af4e6e..b84a460 100644
--- a/arch/arm/mach-shmobile/intc-sh7377.c
+++ b/arch/arm/mach-shmobile/intc-sh7377.c
@@ -23,6 +23,7 @@
 #include <linux/io.h>
 #include <linux/sh_intc.h>
 #include <mach/intc.h>
+#include <mach/irqs.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
diff --git a/arch/arm/mach-shmobile/intc-sh73a0.c b/arch/arm/mach-shmobile/intc-sh73a0.c
index 1eda6b0..9a8207c 100644
--- a/arch/arm/mach-shmobile/intc-sh73a0.c
+++ b/arch/arm/mach-shmobile/intc-sh73a0.c
@@ -23,6 +23,7 @@
 #include <linux/io.h>
 #include <linux/sh_intc.h>
 #include <mach/intc.h>
+#include <mach/irqs.h>
 #include <mach/sh73a0.h>
 #include <asm/hardware/gic.h>
 #include <asm/mach-types.h>
diff --git a/arch/arm/mach-shmobile/setup-r8a7740.c b/arch/arm/mach-shmobile/setup-r8a7740.c
index 986dca6..fa15d81 100644
--- a/arch/arm/mach-shmobile/setup-r8a7740.c
+++ b/arch/arm/mach-shmobile/setup-r8a7740.c
@@ -25,6 +25,7 @@
 #include <linux/serial_sci.h>
 #include <linux/sh_timer.h>
 #include <mach/r8a7740.h>
+#include <mach/irqs.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
diff --git a/arch/arm/mach-shmobile/setup-r8a7779.c b/arch/arm/mach-shmobile/setup-r8a7779.c
index 4725663..55df21a 100644
--- a/arch/arm/mach-shmobile/setup-r8a7779.c
+++ b/arch/arm/mach-shmobile/setup-r8a7779.c
@@ -29,6 +29,7 @@
 #include <linux/sh_intc.h>
 #include <linux/sh_timer.h>
 #include <mach/hardware.h>
+#include <mach/irqs.h>
 #include <mach/r8a7779.h>
 #include <mach/common.h>
 #include <asm/mach-types.h>
diff --git a/arch/arm/mach-shmobile/setup-sh7367.c b/arch/arm/mach-shmobile/setup-sh7367.c
index e546017..8e848198 100644
--- a/arch/arm/mach-shmobile/setup-sh7367.c
+++ b/arch/arm/mach-shmobile/setup-sh7367.c
@@ -29,6 +29,7 @@
 #include <linux/serial_sci.h>
 #include <linux/sh_timer.h>
 #include <mach/hardware.h>
+#include <mach/irqs.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
diff --git a/arch/arm/mach-shmobile/setup-sh7372.c b/arch/arm/mach-shmobile/setup-sh7372.c
index 6fcf304..420d25c 100644
--- a/arch/arm/mach-shmobile/setup-sh7372.c
+++ b/arch/arm/mach-shmobile/setup-sh7372.c
@@ -32,6 +32,7 @@
 #include <linux/sh_timer.h>
 #include <linux/pm_domain.h>
 #include <mach/hardware.h>
+#include <mach/irqs.h>
 #include <mach/sh7372.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
diff --git a/arch/arm/mach-shmobile/setup-sh7377.c b/arch/arm/mach-shmobile/setup-sh7377.c
index bb405b8..747ed8e 100644
--- a/arch/arm/mach-shmobile/setup-sh7377.c
+++ b/arch/arm/mach-shmobile/setup-sh7377.c
@@ -30,6 +30,7 @@
 #include <linux/sh_intc.h>
 #include <linux/sh_timer.h>
 #include <mach/hardware.h>
+#include <mach/irqs.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
diff --git a/arch/arm/mach-shmobile/setup-sh73a0.c b/arch/arm/mach-shmobile/setup-sh73a0.c
index 20e71e5..7bf740e 100644
--- a/arch/arm/mach-shmobile/setup-sh73a0.c
+++ b/arch/arm/mach-shmobile/setup-sh73a0.c
@@ -31,6 +31,7 @@
 #include <linux/sh_intc.h>
 #include <linux/sh_timer.h>
 #include <mach/hardware.h>
+#include <mach/irqs.h>
 #include <mach/sh73a0.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
-- 
1.7.5.4
