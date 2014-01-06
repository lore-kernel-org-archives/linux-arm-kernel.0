From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Mon, 6 Jan 2014 17:17:40 -0500
Subject: [PATCH] arm: delete non-required instances of include <linux/init.h>
Message-ID: <1389046660-25326-1-git-send-email-paul.gortmaker@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Several arch/arm files aren't actually using any __init directives
and hence don't need to include <linux/init.h>.  Most are just a
left over from __devinit and __cpuinit removal, or simply due to
code getting copied from one driver to the next.

Note that there are several _additions_ of this include, as some
files were implicitly getting the init.h before via other headers.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---

[ build tested on v3.13-rc7 with all of arch/arm/configs/* ]

 arch/arm/common/dmabounce.c               | 1 -
 arch/arm/include/asm/arch_timer.h         | 1 -
 arch/arm/kernel/entry-armv.S              | 1 +
 arch/arm/kernel/entry-header.S            | 1 -
 arch/arm/kernel/head-common.S             | 2 ++
 arch/arm/kernel/hyp-stub.S                | 1 -
 arch/arm/kernel/suspend.c                 | 1 -
 arch/arm/kernel/unwind.c                  | 1 -
 arch/arm/mach-cns3xxx/pm.c                | 1 -
 arch/arm/mach-exynos/headsmp.S            | 1 -
 arch/arm/mach-footbridge/personal.c       | 1 -
 arch/arm/mach-imx/headsmp.S               | 1 -
 arch/arm/mach-imx/iomux-v3.c              | 1 -
 arch/arm/mach-iop33x/uart.c               | 1 -
 arch/arm/mach-msm/headsmp.S               | 1 -
 arch/arm/mach-msm/proc_comm.h             | 1 -
 arch/arm/mach-mvebu/headsmp.S             | 1 -
 arch/arm/mach-netx/fb.c                   | 1 -
 arch/arm/mach-netx/pfifo.c                | 1 -
 arch/arm/mach-netx/xc.c                   | 1 -
 arch/arm/mach-nspire/clcd.c               | 1 -
 arch/arm/mach-omap1/fpga.c                | 1 -
 arch/arm/mach-omap1/include/mach/serial.h | 1 -
 arch/arm/mach-omap2/omap-headsmp.S        | 1 -
 arch/arm/mach-omap2/omap3-restart.c       | 1 -
 arch/arm/mach-omap2/vc3xxx_data.c         | 1 -
 arch/arm/mach-omap2/vc44xx_data.c         | 1 -
 arch/arm/mach-omap2/vp3xxx_data.c         | 1 -
 arch/arm/mach-omap2/vp44xx_data.c         | 1 -
 arch/arm/mach-prima2/headsmp.S            | 1 -
 arch/arm/mach-pxa/clock-pxa2xx.c          | 1 -
 arch/arm/mach-pxa/clock-pxa3xx.c          | 1 -
 arch/arm/mach-pxa/corgi_pm.c              | 1 -
 arch/arm/mach-pxa/mfp-pxa3xx.c            | 1 -
 arch/arm/mach-pxa/spitz_pm.c              | 1 -
 arch/arm/mach-s3c24xx/clock-s3c244x.c     | 1 -
 arch/arm/mach-s3c24xx/iotiming-s3c2410.c  | 1 -
 arch/arm/mach-s3c24xx/iotiming-s3c2412.c  | 1 -
 arch/arm/mach-s3c24xx/irq-pm.c            | 1 -
 arch/arm/mach-s3c24xx/pm.c                | 1 -
 arch/arm/mach-s5p64x0/clock.c             | 1 -
 arch/arm/mach-sa1100/ssp.c                | 1 -
 arch/arm/mach-shmobile/headsmp-scu.S      | 1 -
 arch/arm/mach-shmobile/headsmp.S          | 1 -
 arch/arm/mach-shmobile/sleep-sh7372.S     | 1 -
 arch/arm/mach-socfpga/headsmp.S           | 1 -
 arch/arm/mach-sti/headsmp.S               | 1 -
 arch/arm/mach-tegra/flowctrl.c            | 1 -
 arch/arm/mach-tegra/headsmp.S             | 1 -
 arch/arm/mach-tegra/reset-handler.S       | 1 -
 arch/arm/mach-u300/dummyspichip.c         | 1 -
 arch/arm/mach-ux500/board-mop500-audio.c  | 1 -
 arch/arm/mach-versatile/versatile_ab.c    | 1 -
 arch/arm/mach-zynq/headsmp.S              | 1 -
 arch/arm/mm/hugetlbpage.c                 | 1 -
 arch/arm/plat-iop/i2c.c                   | 1 -
 arch/arm/plat-samsung/pm-check.c          | 1 -
 arch/arm/plat-samsung/pm-gpio.c           | 1 -
 arch/arm/plat-samsung/s5p-irq-pm.c        | 1 -
 arch/arm/plat-versatile/headsmp.S         | 1 -
 arch/arm/plat-versatile/platsmp.c         | 1 -
 arch/arm/vfp/entry.S                      | 1 +
 62 files changed, 4 insertions(+), 59 deletions(-)

diff --git a/arch/arm/common/dmabounce.c b/arch/arm/common/dmabounce.c
index 1143c4d..ee568605 100644
--- a/arch/arm/common/dmabounce.c
+++ b/arch/arm/common/dmabounce.c
@@ -23,7 +23,6 @@
  */
 
 #include <linux/module.h>
-#include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/page-flags.h>
 #include <linux/device.h>
diff --git a/arch/arm/include/asm/arch_timer.h b/arch/arm/include/asm/arch_timer.h
index 0704e0c..30cc2fb 100644
--- a/arch/arm/include/asm/arch_timer.h
+++ b/arch/arm/include/asm/arch_timer.h
@@ -4,7 +4,6 @@
 #include <asm/barrier.h>
 #include <asm/errno.h>
 #include <linux/clocksource.h>
-#include <linux/init.h>
 #include <linux/types.h>
 
 #include <clocksource/arm_arch_timer.h>
diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index b3fb8c9..202b1dd 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -15,6 +15,7 @@
  *  that causes it to save wrong values...  Be aware!
  */
 
+#include <linux/init.h>
 #include <asm/assembler.h>
 #include <asm/memory.h>
 #include <asm/glue-df.h>
diff --git a/arch/arm/kernel/entry-header.S b/arch/arm/kernel/entry-header.S
index 39f89fb..989ca33 100644
--- a/arch/arm/kernel/entry-header.S
+++ b/arch/arm/kernel/entry-header.S
@@ -1,4 +1,3 @@
-#include <linux/init.h>
 #include <linux/linkage.h>
 
 #include <asm/assembler.h>
diff --git a/arch/arm/kernel/head-common.S b/arch/arm/kernel/head-common.S
index 47cd974..e71cd7e 100644
--- a/arch/arm/kernel/head-common.S
+++ b/arch/arm/kernel/head-common.S
@@ -11,6 +11,8 @@
  *
  */
 
+#include <linux/init.h>
+
 #define ATAG_CORE 0x54410001
 #define ATAG_CORE_SIZE ((2*4 + 3*4) >> 2)
 #define ATAG_CORE_SIZE_EMPTY ((2*4) >> 2)
diff --git a/arch/arm/kernel/hyp-stub.S b/arch/arm/kernel/hyp-stub.S
index 797b1a6..54bbb51 100644
--- a/arch/arm/kernel/hyp-stub.S
+++ b/arch/arm/kernel/hyp-stub.S
@@ -16,7 +16,6 @@
  * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
-#include <linux/init.h>
 #include <linux/linkage.h>
 #include <asm/assembler.h>
 #include <asm/virt.h>
diff --git a/arch/arm/kernel/suspend.c b/arch/arm/kernel/suspend.c
index 2835d35..59afe38 100644
--- a/arch/arm/kernel/suspend.c
+++ b/arch/arm/kernel/suspend.c
@@ -1,4 +1,3 @@
-#include <linux/init.h>
 #include <linux/slab.h>
 
 #include <asm/cacheflush.h>
diff --git a/arch/arm/kernel/unwind.c b/arch/arm/kernel/unwind.c
index 00df012..eb05820 100644
--- a/arch/arm/kernel/unwind.c
+++ b/arch/arm/kernel/unwind.c
@@ -38,7 +38,6 @@
 #endif /* __CHECKER__ */
 
 #include <linux/kernel.h>
-#include <linux/init.h>
 #include <linux/export.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
diff --git a/arch/arm/mach-cns3xxx/pm.c b/arch/arm/mach-cns3xxx/pm.c
index fb38c72..e10635f 100644
--- a/arch/arm/mach-cns3xxx/pm.c
+++ b/arch/arm/mach-cns3xxx/pm.c
@@ -6,7 +6,6 @@
  * published by the Free Software Foundation.
  */
 
-#include <linux/init.h>
 #include <linux/module.h>
 #include <linux/io.h>
 #include <linux/delay.h>
diff --git a/arch/arm/mach-exynos/headsmp.S b/arch/arm/mach-exynos/headsmp.S
index cdd9d91..b6c8617 100644
--- a/arch/arm/mach-exynos/headsmp.S
+++ b/arch/arm/mach-exynos/headsmp.S
@@ -11,7 +11,6 @@
  * published by the Free Software Foundation.
  */
 #include <linux/linkage.h>
-#include <linux/init.h>
 
 /*
  * exynos4 specific entry point for secondary CPUs.  This provides
diff --git a/arch/arm/mach-footbridge/personal.c b/arch/arm/mach-footbridge/personal.c
index 7bdeabd..1964734 100644
--- a/arch/arm/mach-footbridge/personal.c
+++ b/arch/arm/mach-footbridge/personal.c
@@ -3,7 +3,6 @@
  *
  * Personal server (Skiff) machine fixup
  */
-#include <linux/init.h>
 #include <linux/spinlock.h>
 
 #include <asm/hardware/dec21285.h>
diff --git a/arch/arm/mach-imx/headsmp.S b/arch/arm/mach-imx/headsmp.S
index 627f16f..3b47e8f 100644
--- a/arch/arm/mach-imx/headsmp.S
+++ b/arch/arm/mach-imx/headsmp.S
@@ -11,7 +11,6 @@
  */
 
 #include <linux/linkage.h>
-#include <linux/init.h>
 #include <asm/asm-offsets.h>
 #include <asm/hardware/cache-l2x0.h>
 
diff --git a/arch/arm/mach-imx/iomux-v3.c b/arch/arm/mach-imx/iomux-v3.c
index 9dae74b..e1de1b2 100644
--- a/arch/arm/mach-imx/iomux-v3.c
+++ b/arch/arm/mach-imx/iomux-v3.c
@@ -19,7 +19,6 @@
  * MA 02110-1301, USA.
  */
 #include <linux/errno.h>
-#include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/string.h>
diff --git a/arch/arm/mach-iop33x/uart.c b/arch/arm/mach-iop33x/uart.c
index bbf54d7..2c8a35f 100644
--- a/arch/arm/mach-iop33x/uart.c
+++ b/arch/arm/mach-iop33x/uart.c
@@ -10,7 +10,6 @@
  */
 
 #include <linux/mm.h>
-#include <linux/init.h>
 #include <linux/major.h>
 #include <linux/fs.h>
 #include <linux/platform_device.h>
diff --git a/arch/arm/mach-msm/headsmp.S b/arch/arm/mach-msm/headsmp.S
index 6c62c3f..d41bbbf 100644
--- a/arch/arm/mach-msm/headsmp.S
+++ b/arch/arm/mach-msm/headsmp.S
@@ -9,7 +9,6 @@
  * published by the Free Software Foundation.
  */
 #include <linux/linkage.h>
-#include <linux/init.h>
 
 /*
  * MSM specific entry point for secondary CPUs.  This provides
diff --git a/arch/arm/mach-msm/proc_comm.h b/arch/arm/mach-msm/proc_comm.h
index e8d043a..63fd358 100644
--- a/arch/arm/mach-msm/proc_comm.h
+++ b/arch/arm/mach-msm/proc_comm.h
@@ -16,7 +16,6 @@
 #ifndef _ARCH_ARM_MACH_MSM_PROC_COMM_H_
 #define _ARCH_ARM_MACH_MSM_PROC_COMM_H_
 
-#include <linux/init.h>
 
 enum {
 	PCOM_CMD_IDLE = 0x0,
diff --git a/arch/arm/mach-mvebu/headsmp.S b/arch/arm/mach-mvebu/headsmp.S
index 3dd80df..7d77ef7 100644
--- a/arch/arm/mach-mvebu/headsmp.S
+++ b/arch/arm/mach-mvebu/headsmp.S
@@ -19,7 +19,6 @@
  */
 
 #include <linux/linkage.h>
-#include <linux/init.h>
 
 #include <asm/assembler.h>
 
diff --git a/arch/arm/mach-netx/fb.c b/arch/arm/mach-netx/fb.c
index d122ee6..40b3c12 100644
--- a/arch/arm/mach-netx/fb.c
+++ b/arch/arm/mach-netx/fb.c
@@ -18,7 +18,6 @@
  */
 
 #include <linux/device.h>
-#include <linux/init.h>
 #include <linux/dma-mapping.h>
 #include <linux/amba/bus.h>
 #include <linux/amba/clcd.h>
diff --git a/arch/arm/mach-netx/pfifo.c b/arch/arm/mach-netx/pfifo.c
index 0398494..8e1856d 100644
--- a/arch/arm/mach-netx/pfifo.c
+++ b/arch/arm/mach-netx/pfifo.c
@@ -17,7 +17,6 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
-#include <linux/init.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/io.h>
diff --git a/arch/arm/mach-netx/xc.c b/arch/arm/mach-netx/xc.c
index f1c972d..d9aea9c 100644
--- a/arch/arm/mach-netx/xc.c
+++ b/arch/arm/mach-netx/xc.c
@@ -17,7 +17,6 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
-#include <linux/init.h>
 #include <linux/device.h>
 #include <linux/firmware.h>
 #include <linux/mutex.h>
diff --git a/arch/arm/mach-nspire/clcd.c b/arch/arm/mach-nspire/clcd.c
index abea126..92c1557 100644
--- a/arch/arm/mach-nspire/clcd.c
+++ b/arch/arm/mach-nspire/clcd.c
@@ -9,7 +9,6 @@
  *
  */
 
-#include <linux/init.h>
 #include <linux/of.h>
 #include <linux/amba/bus.h>
 #include <linux/amba/clcd.h>
diff --git a/arch/arm/mach-omap1/fpga.c b/arch/arm/mach-omap1/fpga.c
index 3c0e422..a8a492a 100644
--- a/arch/arm/mach-omap1/fpga.c
+++ b/arch/arm/mach-omap1/fpga.c
@@ -18,7 +18,6 @@
 
 #include <linux/types.h>
 #include <linux/gpio.h>
-#include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/device.h>
 #include <linux/errno.h>
diff --git a/arch/arm/mach-omap1/include/mach/serial.h b/arch/arm/mach-omap1/include/mach/serial.h
index 2ce6a2d..0ad7fe9 100644
--- a/arch/arm/mach-omap1/include/mach/serial.h
+++ b/arch/arm/mach-omap1/include/mach/serial.h
@@ -11,7 +11,6 @@
 #ifndef __ASM_ARCH_SERIAL_H
 #define __ASM_ARCH_SERIAL_H
 
-#include <linux/init.h>
 
 /*
  * Memory entry used for the DEBUG_LL UART configuration, relative to
diff --git a/arch/arm/mach-omap2/omap-headsmp.S b/arch/arm/mach-omap2/omap-headsmp.S
index 75e9295..4259a17 100644
--- a/arch/arm/mach-omap2/omap-headsmp.S
+++ b/arch/arm/mach-omap2/omap-headsmp.S
@@ -16,7 +16,6 @@
  */
 
 #include <linux/linkage.h>
-#include <linux/init.h>
 
 #include "omap44xx.h"
 
diff --git a/arch/arm/mach-omap2/omap3-restart.c b/arch/arm/mach-omap2/omap3-restart.c
index 5de2a0c..5b457fb 100644
--- a/arch/arm/mach-omap2/omap3-restart.c
+++ b/arch/arm/mach-omap2/omap3-restart.c
@@ -11,7 +11,6 @@
  * published by the Free Software Foundation.
  */
 #include <linux/kernel.h>
-#include <linux/init.h>
 #include <linux/reboot.h>
 
 #include "iomap.h"
diff --git a/arch/arm/mach-omap2/vc3xxx_data.c b/arch/arm/mach-omap2/vc3xxx_data.c
index 75bc4aa..1cdd18a 100644
--- a/arch/arm/mach-omap2/vc3xxx_data.c
+++ b/arch/arm/mach-omap2/vc3xxx_data.c
@@ -16,7 +16,6 @@
  */
 #include <linux/io.h>
 #include <linux/err.h>
-#include <linux/init.h>
 
 #include "common.h"
 
diff --git a/arch/arm/mach-omap2/vc44xx_data.c b/arch/arm/mach-omap2/vc44xx_data.c
index 085e5d6..6134cfd 100644
--- a/arch/arm/mach-omap2/vc44xx_data.c
+++ b/arch/arm/mach-omap2/vc44xx_data.c
@@ -16,7 +16,6 @@
  */
 #include <linux/io.h>
 #include <linux/err.h>
-#include <linux/init.h>
 
 #include "common.h"
 
diff --git a/arch/arm/mach-omap2/vp3xxx_data.c b/arch/arm/mach-omap2/vp3xxx_data.c
index 1914e02..f99ca62 100644
--- a/arch/arm/mach-omap2/vp3xxx_data.c
+++ b/arch/arm/mach-omap2/vp3xxx_data.c
@@ -17,7 +17,6 @@
 
 #include <linux/io.h>
 #include <linux/err.h>
-#include <linux/init.h>
 
 #include "common.h"
 
diff --git a/arch/arm/mach-omap2/vp44xx_data.c b/arch/arm/mach-omap2/vp44xx_data.c
index e62f6b0..9036d26 100644
--- a/arch/arm/mach-omap2/vp44xx_data.c
+++ b/arch/arm/mach-omap2/vp44xx_data.c
@@ -17,7 +17,6 @@
 
 #include <linux/io.h>
 #include <linux/err.h>
-#include <linux/init.h>
 
 #include "common.h"
 
diff --git a/arch/arm/mach-prima2/headsmp.S b/arch/arm/mach-prima2/headsmp.S
index d86fe33..3567ea8 100644
--- a/arch/arm/mach-prima2/headsmp.S
+++ b/arch/arm/mach-prima2/headsmp.S
@@ -7,7 +7,6 @@
  */
 
 #include <linux/linkage.h>
-#include <linux/init.h>
 
 /*
  * SIRFSOC specific entry point for secondary CPUs.  This provides
diff --git a/arch/arm/mach-pxa/clock-pxa2xx.c b/arch/arm/mach-pxa/clock-pxa2xx.c
index 9ee2ad6..0d9a905 100644
--- a/arch/arm/mach-pxa/clock-pxa2xx.c
+++ b/arch/arm/mach-pxa/clock-pxa2xx.c
@@ -8,7 +8,6 @@
 
 #include <linux/module.h>
 #include <linux/kernel.h>
-#include <linux/init.h>
 #include <linux/io.h>
 #include <linux/syscore_ops.h>
 
diff --git a/arch/arm/mach-pxa/clock-pxa3xx.c b/arch/arm/mach-pxa/clock-pxa3xx.c
index d4e9499..1dab509 100644
--- a/arch/arm/mach-pxa/clock-pxa3xx.c
+++ b/arch/arm/mach-pxa/clock-pxa3xx.c
@@ -8,7 +8,6 @@
 
 #include <linux/module.h>
 #include <linux/kernel.h>
-#include <linux/init.h>
 #include <linux/io.h>
 #include <linux/syscore_ops.h>
 
diff --git a/arch/arm/mach-pxa/corgi_pm.c b/arch/arm/mach-pxa/corgi_pm.c
index 7a39efc..aa38aab 100644
--- a/arch/arm/mach-pxa/corgi_pm.c
+++ b/arch/arm/mach-pxa/corgi_pm.c
@@ -11,7 +11,6 @@
 
 #include <linux/module.h>
 #include <linux/stat.h>
-#include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/delay.h>
 #include <linux/gpio.h>
diff --git a/arch/arm/mach-pxa/mfp-pxa3xx.c b/arch/arm/mach-pxa/mfp-pxa3xx.c
index 89863a0..1c4de06 100644
--- a/arch/arm/mach-pxa/mfp-pxa3xx.c
+++ b/arch/arm/mach-pxa/mfp-pxa3xx.c
@@ -15,7 +15,6 @@
 
 #include <linux/module.h>
 #include <linux/kernel.h>
-#include <linux/init.h>
 #include <linux/io.h>
 #include <linux/syscore_ops.h>
 
diff --git a/arch/arm/mach-pxa/spitz_pm.c b/arch/arm/mach-pxa/spitz_pm.c
index e191f99..24318fe 100644
--- a/arch/arm/mach-pxa/spitz_pm.c
+++ b/arch/arm/mach-pxa/spitz_pm.c
@@ -11,7 +11,6 @@
 
 #include <linux/module.h>
 #include <linux/stat.h>
-#include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/delay.h>
 #include <linux/gpio.h>
diff --git a/arch/arm/mach-s3c24xx/clock-s3c244x.c b/arch/arm/mach-s3c24xx/clock-s3c244x.c
index 6d9b688..71f5852 100644
--- a/arch/arm/mach-s3c24xx/clock-s3c244x.c
+++ b/arch/arm/mach-s3c24xx/clock-s3c244x.c
@@ -21,7 +21,6 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */
 
-#include <linux/init.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
diff --git a/arch/arm/mach-s3c24xx/iotiming-s3c2410.c b/arch/arm/mach-s3c24xx/iotiming-s3c2410.c
index 4cd13ab..8e0228b 100644
--- a/arch/arm/mach-s3c24xx/iotiming-s3c2410.c
+++ b/arch/arm/mach-s3c24xx/iotiming-s3c2410.c
@@ -10,7 +10,6 @@
  * published by the Free Software Foundation.
 */
 
-#include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/cpufreq.h>
diff --git a/arch/arm/mach-s3c24xx/iotiming-s3c2412.c b/arch/arm/mach-s3c24xx/iotiming-s3c2412.c
index bd064c0..d695764 100644
--- a/arch/arm/mach-s3c24xx/iotiming-s3c2412.c
+++ b/arch/arm/mach-s3c24xx/iotiming-s3c2412.c
@@ -10,7 +10,6 @@
  * published by the Free Software Foundation.
 */
 
-#include <linux/init.h>
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/ioport.h>
diff --git a/arch/arm/mach-s3c24xx/irq-pm.c b/arch/arm/mach-s3c24xx/irq-pm.c
index b91341e..12ed85f 100644
--- a/arch/arm/mach-s3c24xx/irq-pm.c
+++ b/arch/arm/mach-s3c24xx/irq-pm.c
@@ -11,7 +11,6 @@
  * published by the Free Software Foundation.
  */
 
-#include <linux/init.h>
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
diff --git a/arch/arm/mach-s3c24xx/pm.c b/arch/arm/mach-s3c24xx/pm.c
index caa5b72..507ccd8 100644
--- a/arch/arm/mach-s3c24xx/pm.c
+++ b/arch/arm/mach-s3c24xx/pm.c
@@ -26,7 +26,6 @@
  * Thanks to Dimitry Andric for debugging
 */
 
-#include <linux/init.h>
 #include <linux/suspend.h>
 #include <linux/errno.h>
 #include <linux/time.h>
diff --git a/arch/arm/mach-s5p64x0/clock.c b/arch/arm/mach-s5p64x0/clock.c
index 57e7189..e0e802f6 100644
--- a/arch/arm/mach-s5p64x0/clock.c
+++ b/arch/arm/mach-s5p64x0/clock.c
@@ -10,7 +10,6 @@
  * published by the Free Software Foundation.
 */
 
-#include <linux/init.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
diff --git a/arch/arm/mach-sa1100/ssp.c b/arch/arm/mach-sa1100/ssp.c
index e22fca9..dd04880 100644
--- a/arch/arm/mach-sa1100/ssp.c
+++ b/arch/arm/mach-sa1100/ssp.c
@@ -16,7 +16,6 @@
 #include <linux/errno.h>
 #include <linux/interrupt.h>
 #include <linux/ioport.h>
-#include <linux/init.h>
 #include <linux/io.h>
 
 #include <mach/hardware.h>
diff --git a/arch/arm/mach-shmobile/headsmp-scu.S b/arch/arm/mach-shmobile/headsmp-scu.S
index f45dde7..df583ef 100644
--- a/arch/arm/mach-shmobile/headsmp-scu.S
+++ b/arch/arm/mach-shmobile/headsmp-scu.S
@@ -20,7 +20,6 @@
  */
 
 #include <linux/linkage.h>
-#include <linux/init.h>
 #include <asm/memory.h>
 
 /*
diff --git a/arch/arm/mach-shmobile/headsmp.S b/arch/arm/mach-shmobile/headsmp.S
index e5be5c8..8189e46 100644
--- a/arch/arm/mach-shmobile/headsmp.S
+++ b/arch/arm/mach-shmobile/headsmp.S
@@ -11,7 +11,6 @@
  * published by the Free Software Foundation.
  */
 #include <linux/linkage.h>
-#include <linux/init.h>
 #include <asm/memory.h>
 
 ENTRY(shmobile_invalidate_start)
diff --git a/arch/arm/mach-shmobile/sleep-sh7372.S b/arch/arm/mach-shmobile/sleep-sh7372.S
index 9782862..df35418 100644
--- a/arch/arm/mach-shmobile/sleep-sh7372.S
+++ b/arch/arm/mach-shmobile/sleep-sh7372.S
@@ -30,7 +30,6 @@
  */
 
 #include <linux/linkage.h>
-#include <linux/init.h>
 #include <asm/memory.h>
 #include <asm/assembler.h>
 
diff --git a/arch/arm/mach-socfpga/headsmp.S b/arch/arm/mach-socfpga/headsmp.S
index 95c115d..eb59d39 100644
--- a/arch/arm/mach-socfpga/headsmp.S
+++ b/arch/arm/mach-socfpga/headsmp.S
@@ -8,7 +8,6 @@
  * published by the Free Software Foundation.
  */
 #include <linux/linkage.h>
-#include <linux/init.h>
 
 	.arch	armv7-a
 
diff --git a/arch/arm/mach-sti/headsmp.S b/arch/arm/mach-sti/headsmp.S
index 4c09bae..66eb429 100644
--- a/arch/arm/mach-sti/headsmp.S
+++ b/arch/arm/mach-sti/headsmp.S
@@ -14,7 +14,6 @@
  * published by the Free Software Foundation.
  */
 #include <linux/linkage.h>
-#include <linux/init.h>
 
 /*
  * ST specific entry point for secondary CPUs.  This provides
diff --git a/arch/arm/mach-tegra/flowctrl.c b/arch/arm/mach-tegra/flowctrl.c
index ce8ab8a..43ae750 100644
--- a/arch/arm/mach-tegra/flowctrl.c
+++ b/arch/arm/mach-tegra/flowctrl.c
@@ -18,7 +18,6 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
-#include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/io.h>
 #include <linux/cpumask.h>
diff --git a/arch/arm/mach-tegra/headsmp.S b/arch/arm/mach-tegra/headsmp.S
index 2072e73..8239a04 100644
--- a/arch/arm/mach-tegra/headsmp.S
+++ b/arch/arm/mach-tegra/headsmp.S
@@ -1,5 +1,4 @@
 #include <linux/linkage.h>
-#include <linux/init.h>
 
 #include "sleep.h"
 
diff --git a/arch/arm/mach-tegra/reset-handler.S b/arch/arm/mach-tegra/reset-handler.S
index 8c1ba4f..9aa6cd3 100644
--- a/arch/arm/mach-tegra/reset-handler.S
+++ b/arch/arm/mach-tegra/reset-handler.S
@@ -15,7 +15,6 @@
  */
 
 #include <linux/linkage.h>
-#include <linux/init.h>
 
 #include <asm/cache.h>
 #include <asm/asm-offsets.h>
diff --git a/arch/arm/mach-u300/dummyspichip.c b/arch/arm/mach-u300/dummyspichip.c
index ec0283c..59043aa 100644
--- a/arch/arm/mach-u300/dummyspichip.c
+++ b/arch/arm/mach-u300/dummyspichip.c
@@ -6,7 +6,6 @@
  * This is a dummy loopback SPI "chip" used for testing SPI.
  * Author: Linus Walleij <linus.walleij@stericsson.com>
  */
-#include <linux/init.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/device.h>
diff --git a/arch/arm/mach-ux500/board-mop500-audio.c b/arch/arm/mach-ux500/board-mop500-audio.c
index 154e15f..7b718fc 100644
--- a/arch/arm/mach-ux500/board-mop500-audio.c
+++ b/arch/arm/mach-ux500/board-mop500-audio.c
@@ -5,7 +5,6 @@
  */
 
 #include <linux/platform_device.h>
-#include <linux/init.h>
 #include <linux/gpio.h>
 #include <linux/platform_data/pinctrl-nomadik.h>
 #include <linux/platform_data/dma-ste-dma40.h>
diff --git a/arch/arm/mach-versatile/versatile_ab.c b/arch/arm/mach-versatile/versatile_ab.c
index 1caef10..b629bd8 100644
--- a/arch/arm/mach-versatile/versatile_ab.c
+++ b/arch/arm/mach-versatile/versatile_ab.c
@@ -19,7 +19,6 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
-#include <linux/init.h>
 #include <linux/device.h>
 #include <linux/amba/bus.h>
 #include <linux/io.h>
diff --git a/arch/arm/mach-zynq/headsmp.S b/arch/arm/mach-zynq/headsmp.S
index d4cd5f3..f7423af 100644
--- a/arch/arm/mach-zynq/headsmp.S
+++ b/arch/arm/mach-zynq/headsmp.S
@@ -7,7 +7,6 @@
  * published by the Free Software Foundation.
  */
 #include <linux/linkage.h>
-#include <linux/init.h>
 
 ENTRY(zynq_secondary_trampoline)
 	ldr	r0, [pc]
diff --git a/arch/arm/mm/hugetlbpage.c b/arch/arm/mm/hugetlbpage.c
index 54ee616..e5ce0e14 100644
--- a/arch/arm/mm/hugetlbpage.c
+++ b/arch/arm/mm/hugetlbpage.c
@@ -19,7 +19,6 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
  */
 
-#include <linux/init.h>
 #include <linux/fs.h>
 #include <linux/mm.h>
 #include <linux/hugetlb.h>
diff --git a/arch/arm/plat-iop/i2c.c b/arch/arm/plat-iop/i2c.c
index 88215ad..9886bbc 100644
--- a/arch/arm/plat-iop/i2c.c
+++ b/arch/arm/plat-iop/i2c.c
@@ -11,7 +11,6 @@
  */
 
 #include <linux/mm.h>
-#include <linux/init.h>
 #include <linux/major.h>
 #include <linux/fs.h>
 #include <linux/platform_device.h>
diff --git a/arch/arm/plat-samsung/pm-check.c b/arch/arm/plat-samsung/pm-check.c
index 3cbd626..0ec4edb 100644
--- a/arch/arm/plat-samsung/pm-check.c
+++ b/arch/arm/plat-samsung/pm-check.c
@@ -14,7 +14,6 @@
 
 #include <linux/kernel.h>
 #include <linux/suspend.h>
-#include <linux/init.h>
 #include <linux/crc32.h>
 #include <linux/ioport.h>
 #include <linux/slab.h>
diff --git a/arch/arm/plat-samsung/pm-gpio.c b/arch/arm/plat-samsung/pm-gpio.c
index a8de3cf..59d278e 100644
--- a/arch/arm/plat-samsung/pm-gpio.c
+++ b/arch/arm/plat-samsung/pm-gpio.c
@@ -15,7 +15,6 @@
 
 #include <linux/kernel.h>
 #include <linux/device.h>
-#include <linux/init.h>
 #include <linux/io.h>
 #include <linux/gpio.h>
 
diff --git a/arch/arm/plat-samsung/s5p-irq-pm.c b/arch/arm/plat-samsung/s5p-irq-pm.c
index 7c1e3b7..49850ec 100644
--- a/arch/arm/plat-samsung/s5p-irq-pm.c
+++ b/arch/arm/plat-samsung/s5p-irq-pm.c
@@ -12,7 +12,6 @@
  * published by the Free Software Foundation.
 */
 
-#include <linux/init.h>
 #include <linux/module.h>
 #include <linux/interrupt.h>
 
diff --git a/arch/arm/plat-versatile/headsmp.S b/arch/arm/plat-versatile/headsmp.S
index 40f27e5..7e04098 100644
--- a/arch/arm/plat-versatile/headsmp.S
+++ b/arch/arm/plat-versatile/headsmp.S
@@ -9,7 +9,6 @@
  * published by the Free Software Foundation.
  */
 #include <linux/linkage.h>
-#include <linux/init.h>
 #include <asm/assembler.h>
 
 /*
diff --git a/arch/arm/plat-versatile/platsmp.c b/arch/arm/plat-versatile/platsmp.c
index 39895d8..a222650 100644
--- a/arch/arm/plat-versatile/platsmp.c
+++ b/arch/arm/plat-versatile/platsmp.c
@@ -8,7 +8,6 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-#include <linux/init.h>
 #include <linux/errno.h>
 #include <linux/delay.h>
 #include <linux/device.h>
diff --git a/arch/arm/vfp/entry.S b/arch/arm/vfp/entry.S
index 46e1749..dc7e1b5 100644
--- a/arch/arm/vfp/entry.S
+++ b/arch/arm/vfp/entry.S
@@ -8,6 +8,7 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
+#include <linux/init.h>
 #include <asm/thread_info.h>
 #include <asm/vfpmacros.h>
 #include "../kernel/entry-header.S"
-- 
1.8.4.1
