From: robherring2@gmail.com (Rob Herring)
Date: Thu,  3 Jan 2013 11:54:19 -0600
Subject: [PATCH v4 10/19] irqchip: Move ARM gic.h to
 include/linux/irqchip/arm-gic.h
In-Reply-To: <1357235668-9450-1-git-send-email-robherring2@gmail.com>
References: <1357235668-9450-1-git-send-email-robherring2@gmail.com>
Message-ID: <1357235668-9450-11-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Now that we have GIC moved to drivers/irqchip and all GIC DT init for
platforms using irqchip_init, move gic.h and update the remaining
includes.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Anton Vorontsov <avorontsov@mvista.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: David Brown <davidb@codeaurora.org>
Cc: Daniel Walker <dwalker@fifo99.com>
Cc: Bryan Huntsman <bryanh@codeaurora.org>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Paul Mundt <lethal@linux-sh.org>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: Viresh Kumar <viresh.linux@gmail.com>
Cc: Shiraz Hashim <shiraz.hashim@st.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Samuel Ortiz <sameo@linux.intel.com>
---
 arch/arm/mach-cns3xxx/core.c                                     |    2 +-
 arch/arm/mach-exynos/common.c                                    |    2 +-
 arch/arm/mach-exynos/include/mach/regs-irq.h                     |    2 +-
 arch/arm/mach-exynos/platsmp.c                                   |    2 +-
 arch/arm/mach-highbank/platsmp.c                                 |    2 +-
 arch/arm/mach-imx/gpc.c                                          |    2 +-
 arch/arm/mach-imx/platsmp.c                                      |    2 +-
 arch/arm/mach-msm/platsmp.c                                      |    2 +-
 arch/arm/mach-omap2/board-4430sdp.c                              |    2 +-
 arch/arm/mach-omap2/board-omap4panda.c                           |    2 +-
 arch/arm/mach-omap2/omap-smp.c                                   |    2 +-
 arch/arm/mach-omap2/omap-wakeupgen.c                             |    3 +--
 arch/arm/mach-omap2/omap4-common.c                               |    2 +-
 arch/arm/mach-realview/realview_eb.c                             |    2 +-
 arch/arm/mach-realview/realview_pb1176.c                         |    2 +-
 arch/arm/mach-realview/realview_pb11mp.c                         |    2 +-
 arch/arm/mach-realview/realview_pba8.c                           |    2 +-
 arch/arm/mach-realview/realview_pbx.c                            |    2 +-
 arch/arm/mach-shmobile/board-ag5evm.c                            |    2 +-
 arch/arm/mach-shmobile/board-kota2.c                             |    2 +-
 arch/arm/mach-shmobile/board-kzm9g.c                             |    2 +-
 arch/arm/mach-shmobile/intc-r8a7779.c                            |    2 +-
 arch/arm/mach-shmobile/intc-sh73a0.c                             |    2 +-
 arch/arm/mach-shmobile/setup-emev2.c                             |    2 +-
 arch/arm/mach-shmobile/smp-emev2.c                               |    2 +-
 arch/arm/mach-shmobile/smp-r8a7779.c                             |    2 +-
 arch/arm/mach-shmobile/smp-sh73a0.c                              |    2 +-
 arch/arm/mach-socfpga/platsmp.c                                  |    2 +-
 arch/arm/mach-spear13xx/platsmp.c                                |    2 +-
 arch/arm/mach-tegra/irq.c                                        |    3 +--
 arch/arm/mach-tegra/platsmp.c                                    |    2 +-
 arch/arm/mach-ux500/cpu.c                                        |    2 +-
 arch/arm/mach-ux500/platsmp.c                                    |    2 +-
 arch/arm/mach-vexpress/ct-ca9x4.c                                |    2 +-
 arch/arm/plat-versatile/platsmp.c                                |    2 +-
 drivers/irqchip/irq-gic.c                                        |    2 +-
 drivers/mfd/db8500-prcmu.c                                       |    2 +-
 .../asm/hardware/gic.h => include/linux/irqchip/arm-gic.h        |    6 +++---
 38 files changed, 40 insertions(+), 42 deletions(-)
 rename arch/arm/include/asm/hardware/gic.h => include/linux/irqchip/arm-gic.h (92%)

diff --git a/arch/arm/mach-cns3xxx/core.c b/arch/arm/mach-cns3xxx/core.c
index 031805b..db3806c 100644
--- a/arch/arm/mach-cns3xxx/core.c
+++ b/arch/arm/mach-cns3xxx/core.c
@@ -12,10 +12,10 @@
 #include <linux/interrupt.h>
 #include <linux/clockchips.h>
 #include <linux/io.h>
+#include <linux/irqchip/arm-gic.h>
 #include <asm/mach/map.h>
 #include <asm/mach/time.h>
 #include <asm/mach/irq.h>
-#include <asm/hardware/gic.h>
 #include <asm/hardware/cache-l2x0.h>
 #include <mach/cns3xxx.h>
 #include "core.h"
diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
index 70de42e..d291811 100644
--- a/arch/arm/mach-exynos/common.c
+++ b/arch/arm/mach-exynos/common.c
@@ -24,11 +24,11 @@
 #include <linux/irqdomain.h>
 #include <linux/irqchip.h>
 #include <linux/of_address.h>
+#include <linux/irqchip/arm-gic.h>
 
 #include <asm/proc-fns.h>
 #include <asm/exception.h>
 #include <asm/hardware/cache-l2x0.h>
-#include <asm/hardware/gic.h>
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
 #include <asm/cacheflush.h>
diff --git a/arch/arm/mach-exynos/include/mach/regs-irq.h b/arch/arm/mach-exynos/include/mach/regs-irq.h
index 9c7b4bf..f2b5050 100644
--- a/arch/arm/mach-exynos/include/mach/regs-irq.h
+++ b/arch/arm/mach-exynos/include/mach/regs-irq.h
@@ -13,7 +13,7 @@
 #ifndef __ASM_ARCH_REGS_IRQ_H
 #define __ASM_ARCH_REGS_IRQ_H __FILE__
 
-#include <asm/hardware/gic.h>
+#include <linux/irqchip/arm-gic.h>
 #include <mach/map.h>
 
 #endif /* __ASM_ARCH_REGS_IRQ_H */
diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
index 5898f82..60f7c5b 100644
--- a/arch/arm/mach-exynos/platsmp.c
+++ b/arch/arm/mach-exynos/platsmp.c
@@ -20,9 +20,9 @@
 #include <linux/jiffies.h>
 #include <linux/smp.h>
 #include <linux/io.h>
+#include <linux/irqchip/arm-gic.h>
 
 #include <asm/cacheflush.h>
-#include <asm/hardware/gic.h>
 #include <asm/smp_plat.h>
 #include <asm/smp_scu.h>
 
diff --git a/arch/arm/mach-highbank/platsmp.c b/arch/arm/mach-highbank/platsmp.c
index f305c91..2024f95 100644
--- a/arch/arm/mach-highbank/platsmp.c
+++ b/arch/arm/mach-highbank/platsmp.c
@@ -17,9 +17,9 @@
 #include <linux/init.h>
 #include <linux/smp.h>
 #include <linux/io.h>
+#include <linux/irqchip/arm-gic.h>
 
 #include <asm/smp_scu.h>
-#include <asm/hardware/gic.h>
 
 #include "core.h"
 
diff --git a/arch/arm/mach-imx/gpc.c b/arch/arm/mach-imx/gpc.c
index e1537f9..ff24920 100644
--- a/arch/arm/mach-imx/gpc.c
+++ b/arch/arm/mach-imx/gpc.c
@@ -15,7 +15,7 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
-#include <asm/hardware/gic.h>
+#include <linux/irqchip/arm-gic.h>
 
 #define GPC_IMR1		0x008
 #define GPC_PGC_CPU_PDN		0x2a0
diff --git a/arch/arm/mach-imx/platsmp.c b/arch/arm/mach-imx/platsmp.c
index 8e72057..d356931 100644
--- a/arch/arm/mach-imx/platsmp.c
+++ b/arch/arm/mach-imx/platsmp.c
@@ -12,9 +12,9 @@
 
 #include <linux/init.h>
 #include <linux/smp.h>
+#include <linux/irqchip/arm-gic.h>
 #include <asm/page.h>
 #include <asm/smp_scu.h>
-#include <asm/hardware/gic.h>
 #include <asm/mach/map.h>
 
 #include "common.h"
diff --git a/arch/arm/mach-msm/platsmp.c b/arch/arm/mach-msm/platsmp.c
index e27e57b..42932865 100644
--- a/arch/arm/mach-msm/platsmp.c
+++ b/arch/arm/mach-msm/platsmp.c
@@ -15,8 +15,8 @@
 #include <linux/jiffies.h>
 #include <linux/smp.h>
 #include <linux/io.h>
+#include <linux/irqchip/arm-gic.h>
 
-#include <asm/hardware/gic.h>
 #include <asm/cacheflush.h>
 #include <asm/cputype.h>
 #include <asm/mach-types.h>
diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 3de62a9..cb43253 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -26,10 +26,10 @@
 #include <linux/regulator/fixed.h>
 #include <linux/leds.h>
 #include <linux/leds_pwm.h>
+#include <linux/irqchip/arm-gic.h>
 #include <linux/platform_data/omap4-keypad.h>
 #include <linux/usb/musb.h>
 
-#include <asm/hardware/gic.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index 4df66c9..37495bc 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -31,9 +31,9 @@
 #include <linux/ti_wilink_st.h>
 #include <linux/usb/musb.h>
 #include <linux/wl12xx.h>
+#include <linux/irqchip/arm-gic.h>
 #include <linux/platform_data/omap-abe-twl6040.h>
 
-#include <asm/hardware/gic.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
diff --git a/arch/arm/mach-omap2/omap-smp.c b/arch/arm/mach-omap2/omap-smp.c
index 668172a..3616779 100644
--- a/arch/arm/mach-omap2/omap-smp.c
+++ b/arch/arm/mach-omap2/omap-smp.c
@@ -19,9 +19,9 @@
 #include <linux/device.h>
 #include <linux/smp.h>
 #include <linux/io.h>
+#include <linux/irqchip/arm-gic.h>
 
 #include <asm/cacheflush.h>
-#include <asm/hardware/gic.h>
 #include <asm/smp_scu.h>
 
 #include "omap-secure.h"
diff --git a/arch/arm/mach-omap2/omap-wakeupgen.c b/arch/arm/mach-omap2/omap-wakeupgen.c
index 5d3b4f4..8c5b5e3 100644
--- a/arch/arm/mach-omap2/omap-wakeupgen.c
+++ b/arch/arm/mach-omap2/omap-wakeupgen.c
@@ -24,8 +24,7 @@
 #include <linux/cpu.h>
 #include <linux/notifier.h>
 #include <linux/cpu_pm.h>
-
-#include <asm/hardware/gic.h>
+#include <linux/irqchip/arm-gic.h>
 
 #include "omap-wakeupgen.h"
 #include "omap-secure.h"
diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
index addd161..5470948 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -21,8 +21,8 @@
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/export.h>
+#include <linux/irqchip/arm-gic.h>
 
-#include <asm/hardware/gic.h>
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/mach/map.h>
 #include <asm/memblock.h>
diff --git a/arch/arm/mach-realview/realview_eb.c b/arch/arm/mach-realview/realview_eb.c
index 3a73758..728587c 100644
--- a/arch/arm/mach-realview/realview_eb.c
+++ b/arch/arm/mach-realview/realview_eb.c
@@ -27,13 +27,13 @@
 #include <linux/amba/mmci.h>
 #include <linux/amba/pl022.h>
 #include <linux/io.h>
+#include <linux/irqchip/arm-gic.h>
 #include <linux/platform_data/clk-realview.h>
 
 #include <mach/hardware.h>
 #include <asm/irq.h>
 #include <asm/mach-types.h>
 #include <asm/pgtable.h>
-#include <asm/hardware/gic.h>
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/smp_twd.h>
 
diff --git a/arch/arm/mach-realview/realview_pb1176.c b/arch/arm/mach-realview/realview_pb1176.c
index afa967b..3d116c4 100644
--- a/arch/arm/mach-realview/realview_pb1176.c
+++ b/arch/arm/mach-realview/realview_pb1176.c
@@ -29,13 +29,13 @@
 #include <linux/mtd/physmap.h>
 #include <linux/mtd/partitions.h>
 #include <linux/io.h>
+#include <linux/irqchip/arm-gic.h>
 #include <linux/platform_data/clk-realview.h>
 
 #include <mach/hardware.h>
 #include <asm/irq.h>
 #include <asm/mach-types.h>
 #include <asm/pgtable.h>
-#include <asm/hardware/gic.h>
 #include <asm/hardware/cache-l2x0.h>
 
 #include <asm/mach/arch.h>
diff --git a/arch/arm/mach-realview/realview_pb11mp.c b/arch/arm/mach-realview/realview_pb11mp.c
index d8a25b4..e1b8efd 100644
--- a/arch/arm/mach-realview/realview_pb11mp.c
+++ b/arch/arm/mach-realview/realview_pb11mp.c
@@ -27,13 +27,13 @@
 #include <linux/amba/mmci.h>
 #include <linux/amba/pl022.h>
 #include <linux/io.h>
+#include <linux/irqchip/arm-gic.h>
 #include <linux/platform_data/clk-realview.h>
 
 #include <mach/hardware.h>
 #include <asm/irq.h>
 #include <asm/mach-types.h>
 #include <asm/pgtable.h>
-#include <asm/hardware/gic.h>
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/smp_twd.h>
 
diff --git a/arch/arm/mach-realview/realview_pba8.c b/arch/arm/mach-realview/realview_pba8.c
index 5391d0a..0b037f2 100644
--- a/arch/arm/mach-realview/realview_pba8.c
+++ b/arch/arm/mach-realview/realview_pba8.c
@@ -27,12 +27,12 @@
 #include <linux/amba/mmci.h>
 #include <linux/amba/pl022.h>
 #include <linux/io.h>
+#include <linux/irqchip/arm-gic.h>
 #include <linux/platform_data/clk-realview.h>
 
 #include <asm/irq.h>
 #include <asm/mach-types.h>
 #include <asm/pgtable.h>
-#include <asm/hardware/gic.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
diff --git a/arch/arm/mach-realview/realview_pbx.c b/arch/arm/mach-realview/realview_pbx.c
index bfb834b..a1f1ef5 100644
--- a/arch/arm/mach-realview/realview_pbx.c
+++ b/arch/arm/mach-realview/realview_pbx.c
@@ -26,13 +26,13 @@
 #include <linux/amba/mmci.h>
 #include <linux/amba/pl022.h>
 #include <linux/io.h>
+#include <linux/irqchip/arm-gic.h>
 #include <linux/platform_data/clk-realview.h>
 
 #include <asm/irq.h>
 #include <asm/mach-types.h>
 #include <asm/smp_twd.h>
 #include <asm/pgtable.h>
-#include <asm/hardware/gic.h>
 #include <asm/hardware/cache-l2x0.h>
 
 #include <asm/mach/arch.h>
diff --git a/arch/arm/mach-shmobile/board-ag5evm.c b/arch/arm/mach-shmobile/board-ag5evm.c
index 81b31f5..fd28358 100644
--- a/arch/arm/mach-shmobile/board-ag5evm.c
+++ b/arch/arm/mach-shmobile/board-ag5evm.c
@@ -40,6 +40,7 @@
 #include <linux/mmc/sh_mobile_sdhi.h>
 #include <linux/mfd/tmio.h>
 #include <linux/sh_clk.h>
+#include <linux/irqchip/arm-gic.h>
 #include <video/sh_mobile_lcdc.h>
 #include <video/sh_mipi_dsi.h>
 #include <sound/sh_fsi.h>
@@ -49,7 +50,6 @@
 #include <mach/common.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
-#include <asm/hardware/gic.h>
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/traps.h>
 
diff --git a/arch/arm/mach-shmobile/board-kota2.c b/arch/arm/mach-shmobile/board-kota2.c
index 2df8e60..a1d315f 100644
--- a/arch/arm/mach-shmobile/board-kota2.c
+++ b/arch/arm/mach-shmobile/board-kota2.c
@@ -35,6 +35,7 @@
 #include <linux/input/sh_keysc.h>
 #include <linux/gpio_keys.h>
 #include <linux/leds.h>
+#include <linux/irqchip/arm-gic.h>
 #include <linux/platform_data/leds-renesas-tpu.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/sh_mmcif.h>
@@ -47,7 +48,6 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
-#include <asm/hardware/gic.h>
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/traps.h>
 
diff --git a/arch/arm/mach-shmobile/board-kzm9g.c b/arch/arm/mach-shmobile/board-kzm9g.c
index d160758..278c8f2 100644
--- a/arch/arm/mach-shmobile/board-kzm9g.c
+++ b/arch/arm/mach-shmobile/board-kzm9g.c
@@ -25,6 +25,7 @@
 #include <linux/i2c.h>
 #include <linux/i2c/pcf857x.h>
 #include <linux/input.h>
+#include <linux/irqchip/arm-gic.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/sh_mmcif.h>
 #include <linux/mmc/sh_mobile_sdhi.h>
@@ -42,7 +43,6 @@
 #include <mach/sh73a0.h>
 #include <mach/common.h>
 #include <asm/hardware/cache-l2x0.h>
-#include <asm/hardware/gic.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <video/sh_mobile_lcdc.h>
diff --git a/arch/arm/mach-shmobile/intc-r8a7779.c b/arch/arm/mach-shmobile/intc-r8a7779.c
index ef66f1a..8807c27 100644
--- a/arch/arm/mach-shmobile/intc-r8a7779.c
+++ b/arch/arm/mach-shmobile/intc-r8a7779.c
@@ -22,10 +22,10 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/io.h>
+#include <linux/irqchip/arm-gic.h>
 #include <mach/common.h>
 #include <mach/intc.h>
 #include <mach/r8a7779.h>
-#include <asm/hardware/gic.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
diff --git a/arch/arm/mach-shmobile/intc-sh73a0.c b/arch/arm/mach-shmobile/intc-sh73a0.c
index f0c5e51..9783699 100644
--- a/arch/arm/mach-shmobile/intc-sh73a0.c
+++ b/arch/arm/mach-shmobile/intc-sh73a0.c
@@ -23,10 +23,10 @@
 #include <linux/irq.h>
 #include <linux/io.h>
 #include <linux/sh_intc.h>
+#include <linux/irqchip/arm-gic.h>
 #include <mach/intc.h>
 #include <mach/irqs.h>
 #include <mach/sh73a0.h>
-#include <asm/hardware/gic.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
diff --git a/arch/arm/mach-shmobile/setup-emev2.c b/arch/arm/mach-shmobile/setup-emev2.c
index 5004034..646d61b 100644
--- a/arch/arm/mach-shmobile/setup-emev2.c
+++ b/arch/arm/mach-shmobile/setup-emev2.c
@@ -27,6 +27,7 @@
 #include <linux/delay.h>
 #include <linux/input.h>
 #include <linux/io.h>
+#include <linux/irqchip/arm-gic.h>
 #include <mach/hardware.h>
 #include <mach/common.h>
 #include <mach/emev2.h>
@@ -35,7 +36,6 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/mach/time.h>
-#include <asm/hardware/gic.h>
 
 static struct map_desc emev2_io_desc[] __initdata = {
 #ifdef CONFIG_SMP
diff --git a/arch/arm/mach-shmobile/smp-emev2.c b/arch/arm/mach-shmobile/smp-emev2.c
index 6262d67..953eb1f 100644
--- a/arch/arm/mach-shmobile/smp-emev2.c
+++ b/arch/arm/mach-shmobile/smp-emev2.c
@@ -23,11 +23,11 @@
 #include <linux/spinlock.h>
 #include <linux/io.h>
 #include <linux/delay.h>
+#include <linux/irqchip/arm-gic.h>
 #include <mach/common.h>
 #include <mach/emev2.h>
 #include <asm/smp_plat.h>
 #include <asm/smp_scu.h>
-#include <asm/hardware/gic.h>
 #include <asm/cacheflush.h>
 
 #define EMEV2_SCU_BASE 0x1e000000
diff --git a/arch/arm/mach-shmobile/smp-r8a7779.c b/arch/arm/mach-shmobile/smp-r8a7779.c
index 2ce6af9..3a4acf2 100644
--- a/arch/arm/mach-shmobile/smp-r8a7779.c
+++ b/arch/arm/mach-shmobile/smp-r8a7779.c
@@ -23,12 +23,12 @@
 #include <linux/spinlock.h>
 #include <linux/io.h>
 #include <linux/delay.h>
+#include <linux/irqchip/arm-gic.h>
 #include <mach/common.h>
 #include <mach/r8a7779.h>
 #include <asm/smp_plat.h>
 #include <asm/smp_scu.h>
 #include <asm/smp_twd.h>
-#include <asm/hardware/gic.h>
 
 #define AVECR IOMEM(0xfe700040)
 
diff --git a/arch/arm/mach-shmobile/smp-sh73a0.c b/arch/arm/mach-shmobile/smp-sh73a0.c
index 624f00f..5c5bcb5 100644
--- a/arch/arm/mach-shmobile/smp-sh73a0.c
+++ b/arch/arm/mach-shmobile/smp-sh73a0.c
@@ -23,12 +23,12 @@
 #include <linux/spinlock.h>
 #include <linux/io.h>
 #include <linux/delay.h>
+#include <linux/irqchip/arm-gic.h>
 #include <mach/common.h>
 #include <asm/smp_plat.h>
 #include <mach/sh73a0.h>
 #include <asm/smp_scu.h>
 #include <asm/smp_twd.h>
-#include <asm/hardware/gic.h>
 
 #define WUPCR		IOMEM(0xe6151010)
 #define SRESCR		IOMEM(0xe6151018)
diff --git a/arch/arm/mach-socfpga/platsmp.c b/arch/arm/mach-socfpga/platsmp.c
index 98a2220..4e9e69d 100644
--- a/arch/arm/mach-socfpga/platsmp.c
+++ b/arch/arm/mach-socfpga/platsmp.c
@@ -22,9 +22,9 @@
 #include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/irqchip/arm-gic.h>
 
 #include <asm/cacheflush.h>
-#include <asm/hardware/gic.h>
 #include <asm/smp_scu.h>
 #include <asm/smp_plat.h>
 
diff --git a/arch/arm/mach-spear13xx/platsmp.c b/arch/arm/mach-spear13xx/platsmp.c
index 27e3f69..af4ade6 100644
--- a/arch/arm/mach-spear13xx/platsmp.c
+++ b/arch/arm/mach-spear13xx/platsmp.c
@@ -15,8 +15,8 @@
 #include <linux/jiffies.h>
 #include <linux/io.h>
 #include <linux/smp.h>
+#include <linux/irqchip/arm-gic.h>
 #include <asm/cacheflush.h>
-#include <asm/hardware/gic.h>
 #include <asm/smp_scu.h>
 #include <mach/spear.h>
 #include <mach/generic.h>
diff --git a/arch/arm/mach-tegra/irq.c b/arch/arm/mach-tegra/irq.c
index b7886f1..2ff2128 100644
--- a/arch/arm/mach-tegra/irq.c
+++ b/arch/arm/mach-tegra/irq.c
@@ -22,8 +22,7 @@
 #include <linux/irq.h>
 #include <linux/io.h>
 #include <linux/of.h>
-
-#include <asm/hardware/gic.h>
+#include <linux/irqchip/arm-gic.h>
 
 #include "board.h"
 #include "iomap.h"
diff --git a/arch/arm/mach-tegra/platsmp.c b/arch/arm/mach-tegra/platsmp.c
index d8e6754..18d7290 100644
--- a/arch/arm/mach-tegra/platsmp.c
+++ b/arch/arm/mach-tegra/platsmp.c
@@ -18,9 +18,9 @@
 #include <linux/jiffies.h>
 #include <linux/smp.h>
 #include <linux/io.h>
+#include <linux/irqchip/arm-gic.h>
 
 #include <asm/cacheflush.h>
-#include <asm/hardware/gic.h>
 #include <asm/mach-types.h>
 #include <asm/smp_scu.h>
 
diff --git a/arch/arm/mach-ux500/cpu.c b/arch/arm/mach-ux500/cpu.c
index a5931f7..5dd90d3 100644
--- a/arch/arm/mach-ux500/cpu.c
+++ b/arch/arm/mach-ux500/cpu.c
@@ -18,9 +18,9 @@
 #include <linux/of_irq.h>
 #include <linux/irq.h>
 #include <linux/irqchip.h>
+#include <linux/irqchip/arm-gic.h>
 #include <linux/platform_data/clk-ux500.h>
 
-#include <asm/hardware/gic.h>
 #include <asm/mach/map.h>
 
 #include <mach/hardware.h>
diff --git a/arch/arm/mach-ux500/platsmp.c b/arch/arm/mach-ux500/platsmp.c
index fa07d4d..b8adac9 100644
--- a/arch/arm/mach-ux500/platsmp.c
+++ b/arch/arm/mach-ux500/platsmp.c
@@ -16,9 +16,9 @@
 #include <linux/device.h>
 #include <linux/smp.h>
 #include <linux/io.h>
+#include <linux/irqchip/arm-gic.h>
 
 #include <asm/cacheflush.h>
-#include <asm/hardware/gic.h>
 #include <asm/smp_plat.h>
 #include <asm/smp_scu.h>
 #include <mach/hardware.h>
diff --git a/arch/arm/mach-vexpress/ct-ca9x4.c b/arch/arm/mach-vexpress/ct-ca9x4.c
index 0ad050f..6f34497 100644
--- a/arch/arm/mach-vexpress/ct-ca9x4.c
+++ b/arch/arm/mach-vexpress/ct-ca9x4.c
@@ -10,10 +10,10 @@
 #include <linux/amba/clcd.h>
 #include <linux/clkdev.h>
 #include <linux/vexpress.h>
+#include <linux/irqchip/arm-gic.h>
 
 #include <asm/hardware/arm_timer.h>
 #include <asm/hardware/cache-l2x0.h>
-#include <asm/hardware/gic.h>
 #include <asm/smp_scu.h>
 #include <asm/smp_twd.h>
 
diff --git a/arch/arm/plat-versatile/platsmp.c b/arch/arm/plat-versatile/platsmp.c
index 2336024..f2ac155 100644
--- a/arch/arm/plat-versatile/platsmp.c
+++ b/arch/arm/plat-versatile/platsmp.c
@@ -14,10 +14,10 @@
 #include <linux/device.h>
 #include <linux/jiffies.h>
 #include <linux/smp.h>
+#include <linux/irqchip/arm-gic.h>
 
 #include <asm/cacheflush.h>
 #include <asm/smp_plat.h>
-#include <asm/hardware/gic.h>
 
 /*
  * Write pen_release in a way that is guaranteed to be visible to all
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index dc511a4..69d9a39 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -38,12 +38,12 @@
 #include <linux/interrupt.h>
 #include <linux/percpu.h>
 #include <linux/slab.h>
+#include <linux/irqchip/arm-gic.h>
 
 #include <asm/irq.h>
 #include <asm/exception.h>
 #include <asm/smp_plat.h>
 #include <asm/mach/irq.h>
-#include <asm/hardware/gic.h>
 
 #include "irqchip.h"
 
diff --git a/drivers/mfd/db8500-prcmu.c b/drivers/mfd/db8500-prcmu.c
index dc8826d..13f4ccf 100644
--- a/drivers/mfd/db8500-prcmu.c
+++ b/drivers/mfd/db8500-prcmu.c
@@ -26,13 +26,13 @@
 #include <linux/fs.h>
 #include <linux/platform_device.h>
 #include <linux/uaccess.h>
+#include <linux/irqchip/arm-gic.h>
 #include <linux/mfd/core.h>
 #include <linux/mfd/dbx500-prcmu.h>
 #include <linux/mfd/abx500/ab8500.h>
 #include <linux/regulator/db8500-prcmu.h>
 #include <linux/regulator/machine.h>
 #include <linux/cpufreq.h>
-#include <asm/hardware/gic.h>
 #include <mach/hardware.h>
 #include <mach/irqs.h>
 #include <mach/db8500-regs.h>
diff --git a/arch/arm/include/asm/hardware/gic.h b/include/linux/irqchip/arm-gic.h
similarity index 92%
rename from arch/arm/include/asm/hardware/gic.h
rename to include/linux/irqchip/arm-gic.h
index 5c14398..a67ca55 100644
--- a/arch/arm/include/asm/hardware/gic.h
+++ b/include/linux/irqchip/arm-gic.h
@@ -1,5 +1,5 @@
 /*
- *  arch/arm/include/asm/hardware/gic.h
+ *  include/linux/irqchip/arm-gic.h
  *
  *  Copyright (C) 2002 ARM Limited, All Rights Reserved.
  *
@@ -7,8 +7,8 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-#ifndef __ASM_ARM_HARDWARE_GIC_H
-#define __ASM_ARM_HARDWARE_GIC_H
+#ifndef __LINUX_IRQCHIP_ARM_GIC_H
+#define __LINUX_IRQCHIP_ARM_GIC_H
 
 #define GIC_CPU_CTRL			0x00
 #define GIC_CPU_PRIMASK			0x04
-- 
1.7.10.4
