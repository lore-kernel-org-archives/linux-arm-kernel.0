From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  1 Jul 2014 09:28:36 +0900
Subject: [PATCH 5/7] ARM: shmobile: Move r8a7790.h
In-Reply-To: <cover.1404173049.git.horms+renesas@verge.net.au>
References: <cover.1404173049.git.horms+renesas@verge.net.au>
Message-ID: <fccae89318fda71012f96042dd971a6f9bf0904e.1404173049.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Change location of r8a7790.h so it can be included as "r8a7790.h"
instead of the old style <mach/r8a7790.h>

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-lager-reference.c |  4 ++-
 arch/arm/mach-shmobile/board-lager.c           | 14 +++++-----
 arch/arm/mach-shmobile/clock-r8a7790.c         |  3 ++-
 arch/arm/mach-shmobile/include/mach/r8a7790.h  | 36 --------------------------
 arch/arm/mach-shmobile/pm-r8a7790.c            |  4 ++-
 arch/arm/mach-shmobile/r8a7790.h               | 36 ++++++++++++++++++++++++++
 arch/arm/mach-shmobile/setup-r8a7790.c         |  4 ++-
 arch/arm/mach-shmobile/smp-r8a7790.c           |  4 ++-
 8 files changed, 58 insertions(+), 47 deletions(-)
 delete mode 100644 arch/arm/mach-shmobile/include/mach/r8a7790.h
 create mode 100644 arch/arm/mach-shmobile/r8a7790.h

diff --git a/arch/arm/mach-shmobile/board-lager-reference.c b/arch/arm/mach-shmobile/board-lager-reference.c
index e30017b..8dcff51 100644
--- a/arch/arm/mach-shmobile/board-lager-reference.c
+++ b/arch/arm/mach-shmobile/board-lager-reference.c
@@ -22,11 +22,13 @@
 #include <linux/init.h>
 #include <linux/of_platform.h>
 #include <linux/platform_data/rcar-du.h>
-#include <mach/r8a7790.h>
+
 #include <asm/mach/arch.h>
+
 #include "clock.h"
 #include "common.h"
 #include "irqs.h"
+#include "r8a7790.h"
 #include "rcar-gen2.h"
 
 /* DU */
diff --git a/arch/arm/mach-shmobile/board-lager.c b/arch/arm/mach-shmobile/board-lager.c
index 72785cc..bfd9e48 100644
--- a/arch/arm/mach-shmobile/board-lager.c
+++ b/arch/arm/mach-shmobile/board-lager.c
@@ -31,6 +31,8 @@
 #include <linux/mmc/host.h>
 #include <linux/mmc/sh_mmcif.h>
 #include <linux/mmc/sh_mobile_sdhi.h>
+#include <linux/mtd/partitions.h>
+#include <linux/mtd/mtd.h>
 #include <linux/pinctrl/machine.h>
 #include <linux/platform_data/camera-rcar.h>
 #include <linux/platform_data/gpio-rcar.h>
@@ -43,21 +45,21 @@
 #include <linux/regulator/gpio-regulator.h>
 #include <linux/regulator/machine.h>
 #include <linux/sh_eth.h>
+#include <linux/spi/flash.h>
+#include <linux/spi/rspi.h>
+#include <linux/spi/spi.h>
 #include <linux/usb/phy.h>
 #include <linux/usb/renesas_usbhs.h>
-#include <mach/r8a7790.h>
+
 #include <media/soc_camera.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
-#include <linux/mtd/partitions.h>
-#include <linux/mtd/mtd.h>
-#include <linux/spi/flash.h>
-#include <linux/spi/rspi.h>
-#include <linux/spi/spi.h>
 #include <sound/rcar_snd.h>
 #include <sound/simple_card.h>
+
 #include "common.h"
 #include "irqs.h"
+#include "r8a7790.h"
 #include "rcar-gen2.h"
 
 /*
diff --git a/arch/arm/mach-shmobile/clock-r8a7790.c b/arch/arm/mach-shmobile/clock-r8a7790.c
index ca98066..17435c1 100644
--- a/arch/arm/mach-shmobile/clock-r8a7790.c
+++ b/arch/arm/mach-shmobile/clock-r8a7790.c
@@ -22,9 +22,10 @@
 #include <linux/kernel.h>
 #include <linux/sh_clk.h>
 #include <linux/clkdev.h>
-#include <mach/r8a7790.h>
+
 #include "clock.h"
 #include "common.h"
+#include "r8a7790.h"
 #include "rcar-gen2.h"
 
 /*
diff --git a/arch/arm/mach-shmobile/include/mach/r8a7790.h b/arch/arm/mach-shmobile/include/mach/r8a7790.h
deleted file mode 100644
index 459827f..0000000
--- a/arch/arm/mach-shmobile/include/mach/r8a7790.h
+++ /dev/null
@@ -1,36 +0,0 @@
-#ifndef __ASM_R8A7790_H__
-#define __ASM_R8A7790_H__
-
-/* DMA slave IDs */
-enum {
-	RCAR_DMA_SLAVE_INVALID,
-	AUDIO_DMAC_SLAVE_SSI0_TX,
-	AUDIO_DMAC_SLAVE_SSI0_RX,
-	AUDIO_DMAC_SLAVE_SSI1_TX,
-	AUDIO_DMAC_SLAVE_SSI1_RX,
-	AUDIO_DMAC_SLAVE_SSI2_TX,
-	AUDIO_DMAC_SLAVE_SSI2_RX,
-	AUDIO_DMAC_SLAVE_SSI3_TX,
-	AUDIO_DMAC_SLAVE_SSI3_RX,
-	AUDIO_DMAC_SLAVE_SSI4_TX,
-	AUDIO_DMAC_SLAVE_SSI4_RX,
-	AUDIO_DMAC_SLAVE_SSI5_TX,
-	AUDIO_DMAC_SLAVE_SSI5_RX,
-	AUDIO_DMAC_SLAVE_SSI6_TX,
-	AUDIO_DMAC_SLAVE_SSI6_RX,
-	AUDIO_DMAC_SLAVE_SSI7_TX,
-	AUDIO_DMAC_SLAVE_SSI7_RX,
-	AUDIO_DMAC_SLAVE_SSI8_TX,
-	AUDIO_DMAC_SLAVE_SSI8_RX,
-	AUDIO_DMAC_SLAVE_SSI9_TX,
-	AUDIO_DMAC_SLAVE_SSI9_RX,
-};
-
-void r8a7790_add_standard_devices(void);
-void r8a7790_add_dt_devices(void);
-void r8a7790_clock_init(void);
-void r8a7790_pinmux_init(void);
-void r8a7790_pm_init(void);
-extern struct smp_operations r8a7790_smp_ops;
-
-#endif /* __ASM_R8A7790_H__ */
diff --git a/arch/arm/mach-shmobile/pm-r8a7790.c b/arch/arm/mach-shmobile/pm-r8a7790.c
index 0f1090d8..8845433 100644
--- a/arch/arm/mach-shmobile/pm-r8a7790.c
+++ b/arch/arm/mach-shmobile/pm-r8a7790.c
@@ -11,9 +11,11 @@
  */
 
 #include <linux/kernel.h>
+
 #include <asm/io.h>
-#include <mach/r8a7790.h>
+
 #include "pm-rcar.h"
+#include "r8a7790.h"
 
 /* SYSC */
 #define SYSCIER 0x0c
diff --git a/arch/arm/mach-shmobile/r8a7790.h b/arch/arm/mach-shmobile/r8a7790.h
new file mode 100644
index 0000000..459827f
--- /dev/null
+++ b/arch/arm/mach-shmobile/r8a7790.h
@@ -0,0 +1,36 @@
+#ifndef __ASM_R8A7790_H__
+#define __ASM_R8A7790_H__
+
+/* DMA slave IDs */
+enum {
+	RCAR_DMA_SLAVE_INVALID,
+	AUDIO_DMAC_SLAVE_SSI0_TX,
+	AUDIO_DMAC_SLAVE_SSI0_RX,
+	AUDIO_DMAC_SLAVE_SSI1_TX,
+	AUDIO_DMAC_SLAVE_SSI1_RX,
+	AUDIO_DMAC_SLAVE_SSI2_TX,
+	AUDIO_DMAC_SLAVE_SSI2_RX,
+	AUDIO_DMAC_SLAVE_SSI3_TX,
+	AUDIO_DMAC_SLAVE_SSI3_RX,
+	AUDIO_DMAC_SLAVE_SSI4_TX,
+	AUDIO_DMAC_SLAVE_SSI4_RX,
+	AUDIO_DMAC_SLAVE_SSI5_TX,
+	AUDIO_DMAC_SLAVE_SSI5_RX,
+	AUDIO_DMAC_SLAVE_SSI6_TX,
+	AUDIO_DMAC_SLAVE_SSI6_RX,
+	AUDIO_DMAC_SLAVE_SSI7_TX,
+	AUDIO_DMAC_SLAVE_SSI7_RX,
+	AUDIO_DMAC_SLAVE_SSI8_TX,
+	AUDIO_DMAC_SLAVE_SSI8_RX,
+	AUDIO_DMAC_SLAVE_SSI9_TX,
+	AUDIO_DMAC_SLAVE_SSI9_RX,
+};
+
+void r8a7790_add_standard_devices(void);
+void r8a7790_add_dt_devices(void);
+void r8a7790_clock_init(void);
+void r8a7790_pinmux_init(void);
+void r8a7790_pm_init(void);
+extern struct smp_operations r8a7790_smp_ops;
+
+#endif /* __ASM_R8A7790_H__ */
diff --git a/arch/arm/mach-shmobile/setup-r8a7790.c b/arch/arm/mach-shmobile/setup-r8a7790.c
index ee5daccf3..6bf84ec 100644
--- a/arch/arm/mach-shmobile/setup-r8a7790.c
+++ b/arch/arm/mach-shmobile/setup-r8a7790.c
@@ -26,11 +26,13 @@
 #include <linux/serial_sci.h>
 #include <linux/sh_dma.h>
 #include <linux/sh_timer.h>
-#include <mach/r8a7790.h>
+
 #include <asm/mach/arch.h>
+
 #include "common.h"
 #include "dma-register.h"
 #include "irqs.h"
+#include "r8a7790.h"
 #include "rcar-gen2.h"
 
 /* Audio-DMAC */
diff --git a/arch/arm/mach-shmobile/smp-r8a7790.c b/arch/arm/mach-shmobile/smp-r8a7790.c
index a8ace58..c256fdf 100644
--- a/arch/arm/mach-shmobile/smp-r8a7790.c
+++ b/arch/arm/mach-shmobile/smp-r8a7790.c
@@ -17,10 +17,12 @@
 #include <linux/init.h>
 #include <linux/smp.h>
 #include <linux/io.h>
+
 #include <asm/smp_plat.h>
-#include <mach/r8a7790.h>
+
 #include "common.h"
 #include "pm-rcar.h"
+#include "r8a7790.h"
 
 #define RST		0xe6160000
 #define CA15BAR		0x0020
-- 
2.0.0.rc2
