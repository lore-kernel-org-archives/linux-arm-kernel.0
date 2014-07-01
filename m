From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  1 Jul 2014 09:28:41 +0900
Subject: [PATCH 1/8] ARM: shmobile: Move r8a7791.h
In-Reply-To: <cover.1404174157.git.horms+renesas@verge.net.au>
References: <cover.1404174157.git.horms+renesas@verge.net.au>
Message-ID: <5201b5a792e95e3ecebe74cd3553413a67da09db.1404174157.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Change location of r8a7791.h so it can be included as "r8a7791.h"
instead of the old style <mach/r8a7791.h>

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-koelsch-reference.c |  4 +++-
 arch/arm/mach-shmobile/board-koelsch.c           |  4 +++-
 arch/arm/mach-shmobile/include/mach/r8a7791.h    | 11 -----------
 arch/arm/mach-shmobile/pm-r8a7791.c              |  6 ++++--
 arch/arm/mach-shmobile/r8a7791.h                 | 11 +++++++++++
 arch/arm/mach-shmobile/setup-r8a7791.c           |  4 +++-
 arch/arm/mach-shmobile/smp-r8a7791.c             |  4 +++-
 7 files changed, 27 insertions(+), 17 deletions(-)
 delete mode 100644 arch/arm/mach-shmobile/include/mach/r8a7791.h
 create mode 100644 arch/arm/mach-shmobile/r8a7791.h

diff --git a/arch/arm/mach-shmobile/board-koelsch-reference.c b/arch/arm/mach-shmobile/board-koelsch-reference.c
index 1d3f67d..0b1fb23 100644
--- a/arch/arm/mach-shmobile/board-koelsch-reference.c
+++ b/arch/arm/mach-shmobile/board-koelsch-reference.c
@@ -23,11 +23,13 @@
 #include <linux/kernel.h>
 #include <linux/of_platform.h>
 #include <linux/platform_data/rcar-du.h>
-#include <mach/r8a7791.h>
+
 #include <asm/mach/arch.h>
+
 #include "clock.h"
 #include "common.h"
 #include "irqs.h"
+#include "r8a7791.h"
 #include "rcar-gen2.h"
 
 /* DU */
diff --git a/arch/arm/mach-shmobile/board-koelsch.c b/arch/arm/mach-shmobile/board-koelsch.c
index 0d44e7eb..e698b90 100644
--- a/arch/arm/mach-shmobile/board-koelsch.c
+++ b/arch/arm/mach-shmobile/board-koelsch.c
@@ -45,11 +45,13 @@
 #include <linux/spi/flash.h>
 #include <linux/spi/rspi.h>
 #include <linux/spi/spi.h>
-#include <mach/r8a7791.h>
+
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
+
 #include "common.h"
 #include "irqs.h"
+#include "r8a7791.h"
 #include "rcar-gen2.h"
 
 /* DU */
diff --git a/arch/arm/mach-shmobile/include/mach/r8a7791.h b/arch/arm/mach-shmobile/include/mach/r8a7791.h
deleted file mode 100644
index 86eae7b..0000000
--- a/arch/arm/mach-shmobile/include/mach/r8a7791.h
+++ /dev/null
@@ -1,11 +0,0 @@
-#ifndef __ASM_R8A7791_H__
-#define __ASM_R8A7791_H__
-
-void r8a7791_add_standard_devices(void);
-void r8a7791_add_dt_devices(void);
-void r8a7791_clock_init(void);
-void r8a7791_pinmux_init(void);
-void r8a7791_pm_init(void);
-extern struct smp_operations r8a7791_smp_ops;
-
-#endif /* __ASM_R8A7791_H__ */
diff --git a/arch/arm/mach-shmobile/pm-r8a7791.c b/arch/arm/mach-shmobile/pm-r8a7791.c
index 1519087..b7e6513 100644
--- a/arch/arm/mach-shmobile/pm-r8a7791.c
+++ b/arch/arm/mach-shmobile/pm-r8a7791.c
@@ -10,10 +10,12 @@
  * for more details.
  */
 
-#include <asm/io.h>
 #include <linux/kernel.h>
-#include <mach/r8a7791.h>
+
+#include <asm/io.h>
+
 #include "pm-rcar.h"
+#include "r8a7791.h"
 
 /* SYSC */
 #define SYSCIER 0x0c
diff --git a/arch/arm/mach-shmobile/r8a7791.h b/arch/arm/mach-shmobile/r8a7791.h
new file mode 100644
index 0000000..86eae7b
--- /dev/null
+++ b/arch/arm/mach-shmobile/r8a7791.h
@@ -0,0 +1,11 @@
+#ifndef __ASM_R8A7791_H__
+#define __ASM_R8A7791_H__
+
+void r8a7791_add_standard_devices(void);
+void r8a7791_add_dt_devices(void);
+void r8a7791_clock_init(void);
+void r8a7791_pinmux_init(void);
+void r8a7791_pm_init(void);
+extern struct smp_operations r8a7791_smp_ops;
+
+#endif /* __ASM_R8A7791_H__ */
diff --git a/arch/arm/mach-shmobile/setup-r8a7791.c b/arch/arm/mach-shmobile/setup-r8a7791.c
index 7e970d0..8823324 100644
--- a/arch/arm/mach-shmobile/setup-r8a7791.c
+++ b/arch/arm/mach-shmobile/setup-r8a7791.c
@@ -26,10 +26,12 @@
 #include <linux/platform_data/irq-renesas-irqc.h>
 #include <linux/serial_sci.h>
 #include <linux/sh_timer.h>
-#include <mach/r8a7791.h>
+
 #include <asm/mach/arch.h>
+
 #include "common.h"
 #include "irqs.h"
+#include "r8a7791.h"
 #include "rcar-gen2.h"
 
 static const struct resource pfc_resources[] __initconst = {
diff --git a/arch/arm/mach-shmobile/smp-r8a7791.c b/arch/arm/mach-shmobile/smp-r8a7791.c
index c6543b6..2482555 100644
--- a/arch/arm/mach-shmobile/smp-r8a7791.c
+++ b/arch/arm/mach-shmobile/smp-r8a7791.c
@@ -17,9 +17,11 @@
 #include <linux/init.h>
 #include <linux/smp.h>
 #include <linux/io.h>
+
 #include <asm/smp_plat.h>
-#include <mach/r8a7791.h>
+
 #include "common.h"
+#include "r8a7791.h"
 #include "rcar-gen2.h"
 
 #define RST		0xe6160000
-- 
2.0.0.rc2
