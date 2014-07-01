From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  1 Jul 2014 09:28:29 +0900
Subject: [PATCH] ARM: shmobile: Move r8a7779.h
In-Reply-To: <cover.1404173506.git.horms+renesas@verge.net.au>
References: <cover.1404173506.git.horms+renesas@verge.net.au>
Message-ID: <1b55353c9214788b0d0797a5fd4585af1557a12c.1404173506.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Change location of r8a7779.h so it can be included as "r8a7779.h"
instead of the old style <mach/r8a7779.h>

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-marzen-reference.c |  4 ++-
 arch/arm/mach-shmobile/board-marzen.c           |  4 ++-
 arch/arm/mach-shmobile/clock-r8a7779.c          |  3 ++-
 arch/arm/mach-shmobile/include/mach/r8a7779.h   | 36 -------------------------
 arch/arm/mach-shmobile/pm-r8a7779.c             |  4 ++-
 arch/arm/mach-shmobile/r8a7779.h                | 36 +++++++++++++++++++++++++
 arch/arm/mach-shmobile/setup-r8a7779.c          |  4 ++-
 arch/arm/mach-shmobile/smp-r8a7779.c            |  4 ++-
 8 files changed, 53 insertions(+), 42 deletions(-)
 delete mode 100644 arch/arm/mach-shmobile/include/mach/r8a7779.h
 create mode 100644 arch/arm/mach-shmobile/r8a7779.h

diff --git a/arch/arm/mach-shmobile/board-marzen-reference.c b/arch/arm/mach-shmobile/board-marzen-reference.c
index 0a000b7..21b3e1c 100644
--- a/arch/arm/mach-shmobile/board-marzen-reference.c
+++ b/arch/arm/mach-shmobile/board-marzen-reference.c
@@ -22,12 +22,14 @@
 #include <linux/clk/shmobile.h>
 #include <linux/clocksource.h>
 #include <linux/of_platform.h>
-#include <mach/r8a7779.h>
+
 #include <asm/irq.h>
 #include <asm/mach/arch.h>
+
 #include "clock.h"
 #include "common.h"
 #include "irqs.h"
+#include "r8a7779.h"
 
 static void __init marzen_init_timer(void)
 {
diff --git a/arch/arm/mach-shmobile/board-marzen.c b/arch/arm/mach-shmobile/board-marzen.c
index fe445ef..25a1037 100644
--- a/arch/arm/mach-shmobile/board-marzen.c
+++ b/arch/arm/mach-shmobile/board-marzen.c
@@ -41,13 +41,15 @@
 #include <linux/mmc/host.h>
 #include <linux/mmc/sh_mobile_sdhi.h>
 #include <linux/mfd/tmio.h>
+
 #include <media/soc_camera.h>
-#include <mach/r8a7779.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/traps.h>
+
 #include "common.h"
 #include "irqs.h"
+#include "r8a7779.h"
 
 /* Fixed 3.3V regulator to be used by SDHI0 */
 static struct regulator_consumer_supply fixed3v3_power_consumers[] = {
diff --git a/arch/arm/mach-shmobile/clock-r8a7779.c b/arch/arm/mach-shmobile/clock-r8a7779.c
index e690927..c51f9db 100644
--- a/arch/arm/mach-shmobile/clock-r8a7779.c
+++ b/arch/arm/mach-shmobile/clock-r8a7779.c
@@ -24,9 +24,10 @@
 #include <linux/sh_clk.h>
 #include <linux/clkdev.h>
 #include <linux/sh_timer.h>
-#include <mach/r8a7779.h>
+
 #include "clock.h"
 #include "common.h"
+#include "r8a7779.h"
 
 /*
  *		MD1 = 1			MD1 = 0
diff --git a/arch/arm/mach-shmobile/include/mach/r8a7779.h b/arch/arm/mach-shmobile/include/mach/r8a7779.h
deleted file mode 100644
index 5415c71..0000000
--- a/arch/arm/mach-shmobile/include/mach/r8a7779.h
+++ /dev/null
@@ -1,36 +0,0 @@
-#ifndef __ASM_R8A7779_H__
-#define __ASM_R8A7779_H__
-
-#include <linux/sh_clk.h>
-
-/* HPB-DMA slave IDs */
-enum {
-	HPBDMA_SLAVE_DUMMY,
-	HPBDMA_SLAVE_SDHI0_TX,
-	HPBDMA_SLAVE_SDHI0_RX,
-};
-
-extern void r8a7779_init_irq_extpin(int irlm);
-extern void r8a7779_init_irq_extpin_dt(int irlm);
-extern void r8a7779_init_irq_dt(void);
-extern void r8a7779_map_io(void);
-extern void r8a7779_earlytimer_init(void);
-extern void r8a7779_add_early_devices(void);
-extern void r8a7779_add_standard_devices(void);
-extern void r8a7779_add_standard_devices_dt(void);
-extern void r8a7779_init_late(void);
-extern u32 r8a7779_read_mode_pins(void);
-extern void r8a7779_clock_init(void);
-extern void r8a7779_pinmux_init(void);
-extern void r8a7779_pm_init(void);
-extern void r8a7779_register_twd(void);
-
-#ifdef CONFIG_PM
-extern void __init r8a7779_init_pm_domains(void);
-#else
-static inline void r8a7779_init_pm_domains(void) {}
-#endif /* CONFIG_PM */
-
-extern struct smp_operations r8a7779_smp_ops;
-
-#endif /* __ASM_R8A7779_H__ */
diff --git a/arch/arm/mach-shmobile/pm-r8a7779.c b/arch/arm/mach-shmobile/pm-r8a7779.c
index f0f36cb..69f70b7 100644
--- a/arch/arm/mach-shmobile/pm-r8a7779.c
+++ b/arch/arm/mach-shmobile/pm-r8a7779.c
@@ -19,10 +19,12 @@
 #include <linux/irq.h>
 #include <linux/interrupt.h>
 #include <linux/console.h>
+
 #include <asm/io.h>
-#include <mach/r8a7779.h>
+
 #include "common.h"
 #include "pm-rcar.h"
+#include "r8a7779.h"
 
 /* SYSC */
 #define SYSCIER 0x0c
diff --git a/arch/arm/mach-shmobile/r8a7779.h b/arch/arm/mach-shmobile/r8a7779.h
new file mode 100644
index 0000000..5415c71
--- /dev/null
+++ b/arch/arm/mach-shmobile/r8a7779.h
@@ -0,0 +1,36 @@
+#ifndef __ASM_R8A7779_H__
+#define __ASM_R8A7779_H__
+
+#include <linux/sh_clk.h>
+
+/* HPB-DMA slave IDs */
+enum {
+	HPBDMA_SLAVE_DUMMY,
+	HPBDMA_SLAVE_SDHI0_TX,
+	HPBDMA_SLAVE_SDHI0_RX,
+};
+
+extern void r8a7779_init_irq_extpin(int irlm);
+extern void r8a7779_init_irq_extpin_dt(int irlm);
+extern void r8a7779_init_irq_dt(void);
+extern void r8a7779_map_io(void);
+extern void r8a7779_earlytimer_init(void);
+extern void r8a7779_add_early_devices(void);
+extern void r8a7779_add_standard_devices(void);
+extern void r8a7779_add_standard_devices_dt(void);
+extern void r8a7779_init_late(void);
+extern u32 r8a7779_read_mode_pins(void);
+extern void r8a7779_clock_init(void);
+extern void r8a7779_pinmux_init(void);
+extern void r8a7779_pm_init(void);
+extern void r8a7779_register_twd(void);
+
+#ifdef CONFIG_PM
+extern void __init r8a7779_init_pm_domains(void);
+#else
+static inline void r8a7779_init_pm_domains(void) {}
+#endif /* CONFIG_PM */
+
+extern struct smp_operations r8a7779_smp_ops;
+
+#endif /* __ASM_R8A7779_H__ */
diff --git a/arch/arm/mach-shmobile/setup-r8a7779.c b/arch/arm/mach-shmobile/setup-r8a7779.c
index 2f59b99..8dbc407 100644
--- a/arch/arm/mach-shmobile/setup-r8a7779.c
+++ b/arch/arm/mach-shmobile/setup-r8a7779.c
@@ -40,14 +40,16 @@
 #include <linux/usb/ehci_pdriver.h>
 #include <linux/usb/ohci_pdriver.h>
 #include <linux/pm_runtime.h>
-#include <mach/r8a7779.h>
+
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
 #include <asm/mach/map.h>
 #include <asm/hardware/cache-l2x0.h>
+
 #include "common.h"
 #include "irqs.h"
+#include "r8a7779.h"
 
 static struct map_desc r8a7779_io_desc[] __initdata = {
 	/* 2M entity map for 0xf0000000 (MPCORE) */
diff --git a/arch/arm/mach-shmobile/smp-r8a7779.c b/arch/arm/mach-shmobile/smp-r8a7779.c
index c230fc0..3100e35 100644
--- a/arch/arm/mach-shmobile/smp-r8a7779.c
+++ b/arch/arm/mach-shmobile/smp-r8a7779.c
@@ -23,13 +23,15 @@
 #include <linux/spinlock.h>
 #include <linux/io.h>
 #include <linux/delay.h>
-#include <mach/r8a7779.h>
+
 #include <asm/cacheflush.h>
 #include <asm/smp_plat.h>
 #include <asm/smp_scu.h>
 #include <asm/smp_twd.h>
+
 #include "common.h"
 #include "pm-rcar.h"
+#include "r8a7779.h"
 
 #define AVECR IOMEM(0xfe700040)
 #define R8A7779_SCU_BASE 0xf0000000
-- 
2.0.0.rc2
