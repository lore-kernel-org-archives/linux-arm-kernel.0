From: robherring2@gmail.com (Rob Herring)
Date: Thu,  3 Jan 2013 11:54:28 -0600
Subject: [PATCH v4 19/19] irqchip: Move ARM vic.h to
 include/linux/irqchip/arm-vic.h
In-Reply-To: <1357235668-9450-1-git-send-email-robherring2@gmail.com>
References: <1357235668-9450-1-git-send-email-robherring2@gmail.com>
Message-ID: <1357235668-9450-20-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Now that we have VIC moved to drivers/irqchip and all VIC DT init for
platforms using irqchip_init, move gic.h and update the remaining
includes.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Ryan Mallon <rmallon@gmail.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Alessandro Rubini <rubini@unipv.it>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: STEricsson <STEricsson_nomadik_linux@list.st.com>
Cc: Ben Dooks <ben-linux@fluff.org>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: linux-samsung-soc at vger.kernel.org
---
 arch/arm/mach-ep93xx/core.c                                         |    3 +--
 arch/arm/mach-netx/generic.c                                        |    2 +-
 arch/arm/mach-nomadik/cpu-8815.c                                    |    2 +-
 arch/arm/mach-s3c64xx/common.c                                      |    2 +-
 arch/arm/mach-s3c64xx/include/mach/regs-irq.h                       |    1 -
 arch/arm/mach-s3c64xx/include/mach/tick.h                           |    2 ++
 arch/arm/mach-s5p64x0/include/mach/regs-irq.h                       |    1 -
 arch/arm/mach-s5pc100/include/mach/regs-irq.h                       |    1 -
 arch/arm/mach-s5pc100/include/mach/tick.h                           |    2 ++
 arch/arm/mach-u300/core.c                                           |    2 +-
 arch/arm/mach-versatile/core.c                                      |    2 +-
 arch/arm/plat-samsung/s5p-irq-eint.c                                |    2 --
 arch/arm/plat-samsung/s5p-irq.c                                     |    3 +--
 drivers/irqchip/irq-vic.c                                           |    2 +-
 .../include/asm/hardware/vic.h => include/linux/irqchip/arm-vic.h   |    1 -
 15 files changed, 12 insertions(+), 16 deletions(-)
 rename arch/arm/include/asm/hardware/vic.h => include/linux/irqchip/arm-vic.h (94%)

diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
index e85bf17..c533f37 100644
--- a/arch/arm/mach-ep93xx/core.c
+++ b/arch/arm/mach-ep93xx/core.c
@@ -34,6 +34,7 @@
 #include <linux/i2c-gpio.h>
 #include <linux/spi/spi.h>
 #include <linux/export.h>
+#include <linux/irqchip/arm-vic.h>
 
 #include <mach/hardware.h>
 #include <linux/platform_data/video-ep93xx.h>
@@ -44,8 +45,6 @@
 #include <asm/mach/map.h>
 #include <asm/mach/time.h>
 
-#include <asm/hardware/vic.h>
-
 #include "soc.h"
 
 /*************************************************************************
diff --git a/arch/arm/mach-netx/generic.c b/arch/arm/mach-netx/generic.c
index aa62746..27c2cb7 100644
--- a/arch/arm/mach-netx/generic.c
+++ b/arch/arm/mach-netx/generic.c
@@ -23,9 +23,9 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
+#include <linux/irqchip/arm-vic.h>
 #include <mach/hardware.h>
 #include <asm/mach/map.h>
-#include <asm/hardware/vic.h>
 #include <mach/netx-regs.h>
 #include <asm/mach/irq.h>
 
diff --git a/arch/arm/mach-nomadik/cpu-8815.c b/arch/arm/mach-nomadik/cpu-8815.c
index 1273931..3514046 100644
--- a/arch/arm/mach-nomadik/cpu-8815.c
+++ b/arch/arm/mach-nomadik/cpu-8815.c
@@ -25,13 +25,13 @@
 #include <linux/slab.h>
 #include <linux/irq.h>
 #include <linux/dma-mapping.h>
+#include <linux/irqchip/arm-vic.h>
 #include <linux/platform_data/clk-nomadik.h>
 #include <linux/platform_data/pinctrl-nomadik.h>
 
 #include <mach/hardware.h>
 #include <mach/irqs.h>
 #include <asm/mach/map.h>
-#include <asm/hardware/vic.h>
 
 #include <asm/cacheflush.h>
 #include <asm/hardware/cache-l2x0.h>
diff --git a/arch/arm/mach-s3c64xx/common.c b/arch/arm/mach-s3c64xx/common.c
index aef303b..0b9c0ba 100644
--- a/arch/arm/mach-s3c64xx/common.c
+++ b/arch/arm/mach-s3c64xx/common.c
@@ -25,10 +25,10 @@
 #include <linux/dma-mapping.h>
 #include <linux/irq.h>
 #include <linux/gpio.h>
+#include <linux/irqchip/arm-vic.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
-#include <asm/hardware/vic.h>
 #include <asm/system_misc.h>
 
 #include <mach/map.h>
diff --git a/arch/arm/mach-s3c64xx/include/mach/regs-irq.h b/arch/arm/mach-s3c64xx/include/mach/regs-irq.h
index bcce68a..6a11278 100644
--- a/arch/arm/mach-s3c64xx/include/mach/regs-irq.h
+++ b/arch/arm/mach-s3c64xx/include/mach/regs-irq.h
@@ -15,6 +15,5 @@
 #ifndef __ASM_ARCH_REGS_IRQ_H
 #define __ASM_ARCH_REGS_IRQ_H __FILE__
 
-#include <asm/hardware/vic.h>
 
 #endif /* __ASM_ARCH_6400_REGS_IRQ_H */
diff --git a/arch/arm/mach-s3c64xx/include/mach/tick.h b/arch/arm/mach-s3c64xx/include/mach/tick.h
index ebe18a9..db9c1b1 100644
--- a/arch/arm/mach-s3c64xx/include/mach/tick.h
+++ b/arch/arm/mach-s3c64xx/include/mach/tick.h
@@ -15,6 +15,8 @@
 #ifndef __ASM_ARCH_TICK_H
 #define __ASM_ARCH_TICK_H __FILE__
 
+#include <linux/irqchip/arm-vic.h>
+
 /* note, the timer interrutps turn up in 2 places, the vic and then
  * the timer block. We take the VIC as the base at the moment.
  */
diff --git a/arch/arm/mach-s5p64x0/include/mach/regs-irq.h b/arch/arm/mach-s5p64x0/include/mach/regs-irq.h
index 4aaebda..d60397d 100644
--- a/arch/arm/mach-s5p64x0/include/mach/regs-irq.h
+++ b/arch/arm/mach-s5p64x0/include/mach/regs-irq.h
@@ -13,7 +13,6 @@
 #ifndef __ASM_ARCH_REGS_IRQ_H
 #define __ASM_ARCH_REGS_IRQ_H __FILE__
 
-#include <asm/hardware/vic.h>
 #include <mach/map.h>
 
 #endif /* __ASM_ARCH_REGS_IRQ_H */
diff --git a/arch/arm/mach-s5pc100/include/mach/regs-irq.h b/arch/arm/mach-s5pc100/include/mach/regs-irq.h
index 4d9036d..7616278 100644
--- a/arch/arm/mach-s5pc100/include/mach/regs-irq.h
+++ b/arch/arm/mach-s5pc100/include/mach/regs-irq.h
@@ -14,6 +14,5 @@
 #define __ASM_ARCH_REGS_IRQ_H __FILE__
 
 #include <mach/map.h>
-#include <asm/hardware/vic.h>
 
 #endif /* __ASM_ARCH_REGS_IRQ_H */
diff --git a/arch/arm/mach-s5pc100/include/mach/tick.h b/arch/arm/mach-s5pc100/include/mach/tick.h
index 20f6873..0af8e41 100644
--- a/arch/arm/mach-s5pc100/include/mach/tick.h
+++ b/arch/arm/mach-s5pc100/include/mach/tick.h
@@ -15,6 +15,8 @@
 #ifndef __ASM_ARCH_TICK_H
 #define __ASM_ARCH_TICK_H __FILE__
 
+#include <linux/irqchip/arm-vic.h>
+
 /* note, the timer interrutps turn up in 2 places, the vic and then
  * the timer block. We take the VIC as the base at the moment.
  */
diff --git a/arch/arm/mach-u300/core.c b/arch/arm/mach-u300/core.c
index a9d3bcf..26b48fa 100644
--- a/arch/arm/mach-u300/core.c
+++ b/arch/arm/mach-u300/core.c
@@ -31,11 +31,11 @@
 #include <linux/dma-mapping.h>
 #include <linux/platform_data/clk-u300.h>
 #include <linux/platform_data/pinctrl-coh901.h>
+#include <linux/irqchip/arm-vic.h>
 
 #include <asm/types.h>
 #include <asm/setup.h>
 #include <asm/memory.h>
-#include <asm/hardware/vic.h>
 #include <asm/mach/map.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
diff --git a/arch/arm/mach-versatile/core.c b/arch/arm/mach-versatile/core.c
index 5d59294..49ac384 100644
--- a/arch/arm/mach-versatile/core.c
+++ b/arch/arm/mach-versatile/core.c
@@ -32,6 +32,7 @@
 #include <linux/amba/mmci.h>
 #include <linux/amba/pl022.h>
 #include <linux/io.h>
+#include <linux/irqchip/arm-vic.h>
 #include <linux/irqchip/versatile-fpga.h>
 #include <linux/gfp.h>
 #include <linux/clkdev.h>
@@ -40,7 +41,6 @@
 #include <asm/irq.h>
 #include <asm/hardware/arm_timer.h>
 #include <asm/hardware/icst.h>
-#include <asm/hardware/vic.h>
 #include <asm/mach-types.h>
 
 #include <asm/mach/arch.h>
diff --git a/arch/arm/plat-samsung/s5p-irq-eint.c b/arch/arm/plat-samsung/s5p-irq-eint.c
index 974bf98..faa6516 100644
--- a/arch/arm/plat-samsung/s5p-irq-eint.c
+++ b/arch/arm/plat-samsung/s5p-irq-eint.c
@@ -17,8 +17,6 @@
 #include <linux/gpio.h>
 #include <linux/irqchip/arm-vic.h>
 
-#include <asm/hardware/vic.h>
-
 #include <plat/regs-irqtype.h>
 
 #include <mach/map.h>
diff --git a/arch/arm/plat-samsung/s5p-irq.c b/arch/arm/plat-samsung/s5p-irq.c
index dfb47d6..103e371 100644
--- a/arch/arm/plat-samsung/s5p-irq.c
+++ b/arch/arm/plat-samsung/s5p-irq.c
@@ -13,8 +13,7 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/io.h>
-
-#include <asm/hardware/vic.h>
+#include <linux/irqchip/arm-vic.h>
 
 #include <mach/map.h>
 #include <plat/regs-timer.h>
diff --git a/drivers/irqchip/irq-vic.c b/drivers/irqchip/irq-vic.c
index 554deaf..1fc2578 100644
--- a/drivers/irqchip/irq-vic.c
+++ b/drivers/irqchip/irq-vic.c
@@ -30,10 +30,10 @@
 #include <linux/syscore_ops.h>
 #include <linux/device.h>
 #include <linux/amba/bus.h>
+#include <linux/irqchip/arm-vic.h>
 
 #include <asm/exception.h>
 #include <asm/mach/irq.h>
-#include <asm/hardware/vic.h>
 
 #include "irqchip.h"
 
diff --git a/arch/arm/include/asm/hardware/vic.h b/include/linux/irqchip/arm-vic.h
similarity index 94%
rename from arch/arm/include/asm/hardware/vic.h
rename to include/linux/irqchip/arm-vic.h
index de7aad1..e3c82dc 100644
--- a/arch/arm/include/asm/hardware/vic.h
+++ b/include/linux/irqchip/arm-vic.h
@@ -32,6 +32,5 @@ struct pt_regs;
 void __vic_init(void __iomem *base, int irq_start, u32 vic_sources,
 		u32 resume_sources, struct device_node *node);
 void vic_init(void __iomem *base, unsigned int irq_start, u32 vic_sources, u32 resume_sources);
-int vic_of_init(struct device_node *node, struct device_node *parent);
 
 #endif
-- 
1.7.10.4
