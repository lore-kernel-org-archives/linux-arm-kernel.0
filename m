From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  1 Jul 2014 09:28:32 +0900
Subject: [PATCH 1/7] ARM: shmobile: Move r7s72100.h
In-Reply-To: <cover.1404173049.git.horms+renesas@verge.net.au>
References: <cover.1404173049.git.horms+renesas@verge.net.au>
Message-ID: <96bd090066e2150f3970b32f35895de2ab631c95.1404173049.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Change location of r7s72100.h so it can be included using "r7s72100.h"
instead of the old style <mach/r7s72100.h>.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-genmai-reference.c | 4 +++-
 arch/arm/mach-shmobile/board-genmai.c           | 4 +++-
 arch/arm/mach-shmobile/clock-r7s72100.c         | 3 ++-
 arch/arm/mach-shmobile/include/mach/r7s72100.h  | 7 -------
 arch/arm/mach-shmobile/r7s72100.h               | 7 +++++++
 arch/arm/mach-shmobile/setup-r7s72100.c         | 4 +++-
 6 files changed, 18 insertions(+), 11 deletions(-)
 delete mode 100644 arch/arm/mach-shmobile/include/mach/r7s72100.h
 create mode 100644 arch/arm/mach-shmobile/r7s72100.h

diff --git a/arch/arm/mach-shmobile/board-genmai-reference.c b/arch/arm/mach-shmobile/board-genmai-reference.c
index c06dc5c..e5448f7 100644
--- a/arch/arm/mach-shmobile/board-genmai-reference.c
+++ b/arch/arm/mach-shmobile/board-genmai-reference.c
@@ -20,11 +20,13 @@
 
 #include <linux/kernel.h>
 #include <linux/of_platform.h>
-#include <mach/r7s72100.h>
+
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
+
 #include "clock.h"
 #include "common.h"
+#include "r7s72100.h"
 
 /*
  * This is a really crude hack to provide clkdev support to platform
diff --git a/arch/arm/mach-shmobile/board-genmai.c b/arch/arm/mach-shmobile/board-genmai.c
index a0994f3..e2a3ba4 100644
--- a/arch/arm/mach-shmobile/board-genmai.c
+++ b/arch/arm/mach-shmobile/board-genmai.c
@@ -25,11 +25,13 @@
 #include <linux/sh_eth.h>
 #include <linux/spi/rspi.h>
 #include <linux/spi/spi.h>
-#include <mach/r7s72100.h>
+
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
+
 #include "common.h"
 #include "irqs.h"
+#include "r7s72100.h"
 
 /* Ether */
 static const struct sh_eth_plat_data ether_pdata __initconst = {
diff --git a/arch/arm/mach-shmobile/clock-r7s72100.c b/arch/arm/mach-shmobile/clock-r7s72100.c
index 457dab0..3eb2ec4 100644
--- a/arch/arm/mach-shmobile/clock-r7s72100.c
+++ b/arch/arm/mach-shmobile/clock-r7s72100.c
@@ -19,8 +19,9 @@
 #include <linux/io.h>
 #include <linux/sh_clk.h>
 #include <linux/clkdev.h>
-#include <mach/r7s72100.h>
+
 #include "common.h"
+#include "r7s72100.h"
 
 /* Frequency Control Registers */
 #define FRQCR		0xfcfe0010
diff --git a/arch/arm/mach-shmobile/include/mach/r7s72100.h b/arch/arm/mach-shmobile/include/mach/r7s72100.h
deleted file mode 100644
index efb723c..0000000
--- a/arch/arm/mach-shmobile/include/mach/r7s72100.h
+++ /dev/null
@@ -1,7 +0,0 @@
-#ifndef __ASM_R7S72100_H__
-#define __ASM_R7S72100_H__
-
-void r7s72100_add_dt_devices(void);
-void r7s72100_clock_init(void);
-
-#endif /* __ASM_R7S72100_H__ */
diff --git a/arch/arm/mach-shmobile/r7s72100.h b/arch/arm/mach-shmobile/r7s72100.h
new file mode 100644
index 0000000..efb723c
--- /dev/null
+++ b/arch/arm/mach-shmobile/r7s72100.h
@@ -0,0 +1,7 @@
+#ifndef __ASM_R7S72100_H__
+#define __ASM_R7S72100_H__
+
+void r7s72100_add_dt_devices(void);
+void r7s72100_clock_init(void);
+
+#endif /* __ASM_R7S72100_H__ */
diff --git a/arch/arm/mach-shmobile/setup-r7s72100.c b/arch/arm/mach-shmobile/setup-r7s72100.c
index a55d68d..4a98b23 100644
--- a/arch/arm/mach-shmobile/setup-r7s72100.c
+++ b/arch/arm/mach-shmobile/setup-r7s72100.c
@@ -22,10 +22,12 @@
 #include <linux/kernel.h>
 #include <linux/of_platform.h>
 #include <linux/sh_timer.h>
-#include <mach/r7s72100.h>
+
 #include <asm/mach/arch.h>
+
 #include "common.h"
 #include "irqs.h"
+#include "r7s72100.h"
 
 static struct resource mtu2_resources[] __initdata = {
 	DEFINE_RES_MEM(0xfcff0000, 0x400),
-- 
2.0.0.rc2
