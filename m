From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 23 Jun 2014 11:25:04 +0900
Subject: [PATCH 8/8] ARM: shmobile: Move rcar-gen2.h, cleanup r8a7790 case
In-Reply-To: <cover.1403487267.git.horms+renesas@verge.net.au>
References: <cover.1403487267.git.horms+renesas@verge.net.au>
Message-ID: <62872989bdbf1245d7239b9f4c05a8ee7c775ed5.1403487267.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Change location of rcar-gen2.h so it can be used as #include "rcar-gen2.h"
instead of the old style #include <mach/rcar-gen2.h>. Also clean up
the r8a7790 case to follow the same style as r8a7791.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-koelsch-reference.c | 2 +-
 arch/arm/mach-shmobile/board-koelsch.c           | 2 +-
 arch/arm/mach-shmobile/board-lager-reference.c   | 2 +-
 arch/arm/mach-shmobile/board-lager.c             | 1 +
 arch/arm/mach-shmobile/clock-r8a7790.c           | 1 +
 arch/arm/mach-shmobile/clock-r8a7791.c           | 2 +-
 arch/arm/mach-shmobile/include/mach/r8a7790.h    | 2 --
 arch/arm/mach-shmobile/include/mach/rcar-gen2.h  | 8 --------
 arch/arm/mach-shmobile/rcar-gen2.h               | 8 ++++++++
 arch/arm/mach-shmobile/setup-r8a7790.c           | 1 +
 arch/arm/mach-shmobile/setup-r8a7791.c           | 2 +-
 arch/arm/mach-shmobile/setup-rcar-gen2.c         | 2 +-
 arch/arm/mach-shmobile/smp-r8a7791.c             | 2 +-
 13 files changed, 18 insertions(+), 17 deletions(-)
 delete mode 100644 arch/arm/mach-shmobile/include/mach/rcar-gen2.h
 create mode 100644 arch/arm/mach-shmobile/rcar-gen2.h

diff --git a/arch/arm/mach-shmobile/board-koelsch-reference.c b/arch/arm/mach-shmobile/board-koelsch-reference.c
index 10fd085..1d3f67d 100644
--- a/arch/arm/mach-shmobile/board-koelsch-reference.c
+++ b/arch/arm/mach-shmobile/board-koelsch-reference.c
@@ -23,12 +23,12 @@
 #include <linux/kernel.h>
 #include <linux/of_platform.h>
 #include <linux/platform_data/rcar-du.h>
-#include <mach/rcar-gen2.h>
 #include <mach/r8a7791.h>
 #include <asm/mach/arch.h>
 #include "clock.h"
 #include "common.h"
 #include "irqs.h"
+#include "rcar-gen2.h"
 
 /* DU */
 static struct rcar_du_encoder_data koelsch_du_encoders[] = {
diff --git a/arch/arm/mach-shmobile/board-koelsch.c b/arch/arm/mach-shmobile/board-koelsch.c
index 1d8b6e6..0d44e7eb 100644
--- a/arch/arm/mach-shmobile/board-koelsch.c
+++ b/arch/arm/mach-shmobile/board-koelsch.c
@@ -46,11 +46,11 @@
 #include <linux/spi/rspi.h>
 #include <linux/spi/spi.h>
 #include <mach/r8a7791.h>
-#include <mach/rcar-gen2.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include "common.h"
 #include "irqs.h"
+#include "rcar-gen2.h"
 
 /* DU */
 static struct rcar_du_encoder_data koelsch_du_encoders[] = {
diff --git a/arch/arm/mach-shmobile/board-lager-reference.c b/arch/arm/mach-shmobile/board-lager-reference.c
index 6e1a261..4f0af91 100644
--- a/arch/arm/mach-shmobile/board-lager-reference.c
+++ b/arch/arm/mach-shmobile/board-lager-reference.c
@@ -22,12 +22,12 @@
 #include <linux/init.h>
 #include <linux/of_platform.h>
 #include <linux/platform_data/rcar-du.h>
-#include <mach/rcar-gen2.h>
 #include <mach/r8a7790.h>
 #include <asm/mach/arch.h>
 #include "clock.h"
 #include "common.h"
 #include "irqs.h"
+#include "rcar-gen2.h"
 
 /* DU */
 static struct rcar_du_encoder_data lager_du_encoders[] = {
diff --git a/arch/arm/mach-shmobile/board-lager.c b/arch/arm/mach-shmobile/board-lager.c
index f0249ca..83bbb5c 100644
--- a/arch/arm/mach-shmobile/board-lager.c
+++ b/arch/arm/mach-shmobile/board-lager.c
@@ -58,6 +58,7 @@
 #include <sound/simple_card.h>
 #include "common.h"
 #include "irqs.h"
+#include "rcar-gen2.h"
 
 /*
  * SSI-AK4643
diff --git a/arch/arm/mach-shmobile/clock-r8a7790.c b/arch/arm/mach-shmobile/clock-r8a7790.c
index b6781a0..ca98066 100644
--- a/arch/arm/mach-shmobile/clock-r8a7790.c
+++ b/arch/arm/mach-shmobile/clock-r8a7790.c
@@ -25,6 +25,7 @@
 #include <mach/r8a7790.h>
 #include "clock.h"
 #include "common.h"
+#include "rcar-gen2.h"
 
 /*
  *   MD		EXTAL		PLL0	PLL1	PLL3
diff --git a/arch/arm/mach-shmobile/clock-r8a7791.c b/arch/arm/mach-shmobile/clock-r8a7791.c
index 494aaf6..10e193d 100644
--- a/arch/arm/mach-shmobile/clock-r8a7791.c
+++ b/arch/arm/mach-shmobile/clock-r8a7791.c
@@ -23,9 +23,9 @@
 #include <linux/kernel.h>
 #include <linux/sh_clk.h>
 #include <linux/clkdev.h>
-#include <mach/rcar-gen2.h>
 #include "clock.h"
 #include "common.h"
+#include "rcar-gen2.h"
 
 /*
  *   MD		EXTAL		PLL0	PLL1	PLL3
diff --git a/arch/arm/mach-shmobile/include/mach/r8a7790.h b/arch/arm/mach-shmobile/include/mach/r8a7790.h
index 0b95bab..d755544 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7790.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7790.h
@@ -1,8 +1,6 @@
 #ifndef __ASM_R8A7790_H__
 #define __ASM_R8A7790_H__
 
-#include <mach/rcar-gen2.h>
-
 /* DMA slave IDs */
 enum {
 	RCAR_DMA_SLAVE_INVALID,
diff --git a/arch/arm/mach-shmobile/include/mach/rcar-gen2.h b/arch/arm/mach-shmobile/include/mach/rcar-gen2.h
deleted file mode 100644
index 43f606e..0000000
--- a/arch/arm/mach-shmobile/include/mach/rcar-gen2.h
+++ /dev/null
@@ -1,8 +0,0 @@
-#ifndef __ASM_RCAR_GEN2_H__
-#define __ASM_RCAR_GEN2_H__
-
-void rcar_gen2_timer_init(void);
-#define MD(nr) BIT(nr)
-u32 rcar_gen2_read_mode_pins(void);
-
-#endif /* __ASM_RCAR_GEN2_H__ */
diff --git a/arch/arm/mach-shmobile/rcar-gen2.h b/arch/arm/mach-shmobile/rcar-gen2.h
new file mode 100644
index 0000000..43f606e
--- /dev/null
+++ b/arch/arm/mach-shmobile/rcar-gen2.h
@@ -0,0 +1,8 @@
+#ifndef __ASM_RCAR_GEN2_H__
+#define __ASM_RCAR_GEN2_H__
+
+void rcar_gen2_timer_init(void);
+#define MD(nr) BIT(nr)
+u32 rcar_gen2_read_mode_pins(void);
+
+#endif /* __ASM_RCAR_GEN2_H__ */
diff --git a/arch/arm/mach-shmobile/setup-r8a7790.c b/arch/arm/mach-shmobile/setup-r8a7790.c
index 7bbe5c0..4212c8d 100644
--- a/arch/arm/mach-shmobile/setup-r8a7790.c
+++ b/arch/arm/mach-shmobile/setup-r8a7790.c
@@ -31,6 +31,7 @@
 #include "common.h"
 #include "dma-register.h"
 #include "irqs.h"
+#include "rcar-gen2.h"
 
 /* Audio-DMAC */
 #define AUDIO_DMAC_SLAVE(_id, _addr, t, r)			\
diff --git a/arch/arm/mach-shmobile/setup-r8a7791.c b/arch/arm/mach-shmobile/setup-r8a7791.c
index 6d8c61f..f554cda 100644
--- a/arch/arm/mach-shmobile/setup-r8a7791.c
+++ b/arch/arm/mach-shmobile/setup-r8a7791.c
@@ -27,10 +27,10 @@
 #include <linux/serial_sci.h>
 #include <linux/sh_timer.h>
 #include <mach/r8a7791.h>
-#include <mach/rcar-gen2.h>
 #include <asm/mach/arch.h>
 #include "common.h"
 #include "irqs.h"
+#include "rcar-gen2.h"
 
 static const struct resource pfc_resources[] __initconst = {
 	DEFINE_RES_MEM(0xe6060000, 0x250),
diff --git a/arch/arm/mach-shmobile/setup-rcar-gen2.c b/arch/arm/mach-shmobile/setup-rcar-gen2.c
index 1c41227..fdc714e 100644
--- a/arch/arm/mach-shmobile/setup-rcar-gen2.c
+++ b/arch/arm/mach-shmobile/setup-rcar-gen2.c
@@ -22,9 +22,9 @@
 #include <linux/clocksource.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
-#include <mach/rcar-gen2.h>
 #include <asm/mach/arch.h>
 #include "common.h"
+#include "rcar-gen2.h"
 
 #define MODEMR 0xe6160060
 
diff --git a/arch/arm/mach-shmobile/smp-r8a7791.c b/arch/arm/mach-shmobile/smp-r8a7791.c
index bf88c66..2648d68 100644
--- a/arch/arm/mach-shmobile/smp-r8a7791.c
+++ b/arch/arm/mach-shmobile/smp-r8a7791.c
@@ -19,8 +19,8 @@
 #include <linux/io.h>
 #include <asm/smp_plat.h>
 #include <mach/r8a7791.h>
-#include <mach/rcar-gen2.h>
 #include "common.h"
+#include "rcar-gen2.h"
 
 #define RST		0xe6160000
 #define CA15BAR		0x0020
-- 
2.0.0.rc2
