From: robherring2@gmail.com (Rob Herring)
Date: Fri, 13 Jan 2012 10:34:09 -0600
Subject: [RFC PATCH 08/10] ARM: shmobile: remove NR_IRQS
In-Reply-To: <1326472451-9002-1-git-send-email-robherring2@gmail.com>
References: <1326472451-9002-1-git-send-email-robherring2@gmail.com>
Message-ID: <1326472451-9002-9-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Remove NR_IRQS and explicitly include mach/irqs.h as needed. shmobile
properly allocates irq_descs for each irqchip, so setting .nr_irqs for
each machine is not needed.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/mach-shmobile/board-g3evm.c       |    1 +
 arch/arm/mach-shmobile/board-g4evm.c       |    1 +
 arch/arm/mach-shmobile/board-kota2.c       |    1 +
 arch/arm/mach-shmobile/board-mackerel.c    |    1 +
 arch/arm/mach-shmobile/include/mach/irqs.h |    2 --
 arch/arm/mach-shmobile/intc-sh7367.c       |    1 +
 arch/arm/mach-shmobile/intc-sh7372.c       |    1 +
 arch/arm/mach-shmobile/intc-sh7377.c       |    1 +
 arch/arm/mach-shmobile/intc-sh73a0.c       |    1 +
 arch/arm/mach-shmobile/setup-sh7367.c      |    1 +
 arch/arm/mach-shmobile/setup-sh7372.c      |    1 +
 arch/arm/mach-shmobile/setup-sh7377.c      |    1 +
 arch/arm/mach-shmobile/setup-sh73a0.c      |    1 +
 13 files changed, 12 insertions(+), 2 deletions(-)

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
index ed52566..a5d09f5 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -55,6 +55,7 @@
 #include <sound/sh_fsi.h>
 
 #include <mach/common.h>
+#include <mach/irqs.h>
 #include <mach/sh7372.h>
 
 #include <asm/mach/arch.h>
diff --git a/arch/arm/mach-shmobile/include/mach/irqs.h b/arch/arm/mach-shmobile/include/mach/irqs.h
index dcb714f..4ccb562 100644
--- a/arch/arm/mach-shmobile/include/mach/irqs.h
+++ b/arch/arm/mach-shmobile/include/mach/irqs.h
@@ -1,8 +1,6 @@
 #ifndef __ASM_MACH_IRQS_H
 #define __ASM_MACH_IRQS_H
 
-#define NR_IRQS         1024
-
 /* GIC */
 #define gic_spi(nr)		((nr) + 32)
 
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
index c197f9d..6045b79 100644
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
index e46821c..dcf00ef 100644
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
