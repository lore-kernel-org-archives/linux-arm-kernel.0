From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  1 Jul 2014 09:28:33 +0900
Subject: [PATCH 2/7] ARM: shmobile: Move r8a73a4.h
In-Reply-To: <cover.1404173049.git.horms+renesas@verge.net.au>
References: <cover.1404173049.git.horms+renesas@verge.net.au>
Message-ID: <fac49568b0d19e039e216ca6d13bc534ebf12c34.1404173049.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Change location of r8a73a4.h so it can be included as "r8a73a4.h"
instead of the old style <mach/r8a73a4.h>

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-ape6evm-reference.c |  4 +++-
 arch/arm/mach-shmobile/board-ape6evm.c           |  4 +++-
 arch/arm/mach-shmobile/include/mach/r8a73a4.h    | 19 -------------------
 arch/arm/mach-shmobile/r8a73a4.h                 | 19 +++++++++++++++++++
 arch/arm/mach-shmobile/setup-r8a73a4.c           |  4 +++-
 5 files changed, 28 insertions(+), 22 deletions(-)
 delete mode 100644 arch/arm/mach-shmobile/include/mach/r8a73a4.h
 create mode 100644 arch/arm/mach-shmobile/r8a73a4.h

diff --git a/arch/arm/mach-shmobile/board-ape6evm-reference.c b/arch/arm/mach-shmobile/board-ape6evm-reference.c
index 76e4ff1..2f7723e 100644
--- a/arch/arm/mach-shmobile/board-ape6evm-reference.c
+++ b/arch/arm/mach-shmobile/board-ape6evm-reference.c
@@ -24,10 +24,12 @@
 #include <linux/pinctrl/machine.h>
 #include <linux/platform_device.h>
 #include <linux/sh_clk.h>
-#include <mach/r8a73a4.h>
+
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
+
 #include "common.h"
+#include "r8a73a4.h"
 
 static void __init ape6evm_add_standard_devices(void)
 {
diff --git a/arch/arm/mach-shmobile/board-ape6evm.c b/arch/arm/mach-shmobile/board-ape6evm.c
index 8f8da25..4855678 100644
--- a/arch/arm/mach-shmobile/board-ape6evm.c
+++ b/arch/arm/mach-shmobile/board-ape6evm.c
@@ -33,11 +33,13 @@
 #include <linux/regulator/machine.h>
 #include <linux/sh_clk.h>
 #include <linux/smsc911x.h>
-#include <mach/r8a73a4.h>
+
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
+
 #include "common.h"
 #include "irqs.h"
+#include "r8a73a4.h"
 
 /* LEDS */
 static struct gpio_led ape6evm_leds[] = {
diff --git a/arch/arm/mach-shmobile/include/mach/r8a73a4.h b/arch/arm/mach-shmobile/include/mach/r8a73a4.h
deleted file mode 100644
index ce8bdd1..0000000
--- a/arch/arm/mach-shmobile/include/mach/r8a73a4.h
+++ /dev/null
@@ -1,19 +0,0 @@
-#ifndef __ASM_R8A73A4_H__
-#define __ASM_R8A73A4_H__
-
-/* DMA slave IDs */
-enum {
-	SHDMA_SLAVE_INVALID,
-	SHDMA_SLAVE_MMCIF0_TX,
-	SHDMA_SLAVE_MMCIF0_RX,
-	SHDMA_SLAVE_MMCIF1_TX,
-	SHDMA_SLAVE_MMCIF1_RX,
-};
-
-void r8a73a4_add_standard_devices(void);
-void r8a73a4_add_dt_devices(void);
-void r8a73a4_clock_init(void);
-void r8a73a4_pinmux_init(void);
-void r8a73a4_init_early(void);
-
-#endif /* __ASM_R8A73A4_H__ */
diff --git a/arch/arm/mach-shmobile/r8a73a4.h b/arch/arm/mach-shmobile/r8a73a4.h
new file mode 100644
index 0000000..ce8bdd1
--- /dev/null
+++ b/arch/arm/mach-shmobile/r8a73a4.h
@@ -0,0 +1,19 @@
+#ifndef __ASM_R8A73A4_H__
+#define __ASM_R8A73A4_H__
+
+/* DMA slave IDs */
+enum {
+	SHDMA_SLAVE_INVALID,
+	SHDMA_SLAVE_MMCIF0_TX,
+	SHDMA_SLAVE_MMCIF0_RX,
+	SHDMA_SLAVE_MMCIF1_TX,
+	SHDMA_SLAVE_MMCIF1_RX,
+};
+
+void r8a73a4_add_standard_devices(void);
+void r8a73a4_add_dt_devices(void);
+void r8a73a4_clock_init(void);
+void r8a73a4_pinmux_init(void);
+void r8a73a4_init_early(void);
+
+#endif /* __ASM_R8A73A4_H__ */
diff --git a/arch/arm/mach-shmobile/setup-r8a73a4.c b/arch/arm/mach-shmobile/setup-r8a73a4.c
index da94d9b..f470b3c 100644
--- a/arch/arm/mach-shmobile/setup-r8a73a4.c
+++ b/arch/arm/mach-shmobile/setup-r8a73a4.c
@@ -24,11 +24,13 @@
 #include <linux/serial_sci.h>
 #include <linux/sh_dma.h>
 #include <linux/sh_timer.h>
-#include <mach/r8a73a4.h>
+
 #include <asm/mach/arch.h>
+
 #include "common.h"
 #include "dma-register.h"
 #include "irqs.h"
+#include "r8a73a4.h"
 
 static const struct resource pfc_resources[] = {
 	DEFINE_RES_MEM(0xe6050000, 0x9000),
-- 
2.0.0.rc2
