From: robherring2@gmail.com (Rob Herring)
Date: Fri, 20 Jan 2012 14:33:06 -0600
Subject: [PATCH v2 08/13] ARM: mmp: remove NR_IRQS
In-Reply-To: <1327091591-27125-1-git-send-email-robherring2@gmail.com>
References: <1327091591-27125-1-git-send-email-robherring2@gmail.com>
Message-ID: <1327091591-27125-9-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Remove NR_IRQS and add a per machine .nr_irqs setting. Clean-up namespace
replacing usage of IRQ_BOARD_START with MMP_NR_IRQS.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/mach-mmp/aspenite.c          |    5 +++--
 arch/arm/mach-mmp/avengers_lite.c     |    1 +
 arch/arm/mach-mmp/brownstone.c        |    4 ++--
 arch/arm/mach-mmp/flint.c             |    3 ++-
 arch/arm/mach-mmp/gplugd.c            |    2 +-
 arch/arm/mach-mmp/include/mach/irqs.h |    3 +--
 arch/arm/mach-mmp/irq-mmp2.c          |    1 +
 arch/arm/mach-mmp/jasper.c            |    5 +++--
 arch/arm/mach-mmp/tavorevb.c          |    1 +
 arch/arm/mach-mmp/teton_bga.c         |    3 ++-
 arch/arm/mach-mmp/ttc_dkb.c           |    4 ++--
 11 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-mmp/aspenite.c b/arch/arm/mach-mmp/aspenite.c
index 17cb760..5483d6f 100644
--- a/arch/arm/mach-mmp/aspenite.c
+++ b/arch/arm/mach-mmp/aspenite.c
@@ -24,6 +24,7 @@
 #include <mach/addr-map.h>
 #include <mach/mfp-pxa168.h>
 #include <mach/pxa168.h>
+#include <mach/irqs.h>
 #include <video/pxa168fb.h>
 #include <linux/input.h>
 #include <plat/pxa27x_keypad.h>
@@ -240,7 +241,7 @@ static void __init common_init(void)
 
 MACHINE_START(ASPENITE, "PXA168-based Aspenite Development Platform")
 	.map_io		= mmp_map_io,
-	.nr_irqs	= IRQ_BOARD_START,
+	.nr_irqs	= MMP_NR_IRQS,
 	.init_irq       = pxa168_init_irq,
 	.timer          = &pxa168_timer,
 	.init_machine   = common_init,
@@ -249,7 +250,7 @@ MACHINE_END
 
 MACHINE_START(ZYLONITE2, "PXA168-based Zylonite2 Development Platform")
 	.map_io		= mmp_map_io,
-	.nr_irqs	= IRQ_BOARD_START,
+	.nr_irqs	= MMP_NR_IRQS,
 	.init_irq       = pxa168_init_irq,
 	.timer          = &pxa168_timer,
 	.init_machine   = common_init,
diff --git a/arch/arm/mach-mmp/avengers_lite.c b/arch/arm/mach-mmp/avengers_lite.c
index b148a9d..603542a 100644
--- a/arch/arm/mach-mmp/avengers_lite.c
+++ b/arch/arm/mach-mmp/avengers_lite.c
@@ -43,6 +43,7 @@ static void __init avengers_lite_init(void)
 
 MACHINE_START(AVENGERS_LITE, "PXA168 Avengers lite Development Platform")
 	.map_io		= mmp_map_io,
+	.nr_irqs	= MMP_NR_IRQS,
 	.init_irq       = pxa168_init_irq,
 	.timer          = &pxa168_timer,
 	.init_machine   = avengers_lite_init,
diff --git a/arch/arm/mach-mmp/brownstone.c b/arch/arm/mach-mmp/brownstone.c
index d839fe6..5cb769c 100644
--- a/arch/arm/mach-mmp/brownstone.c
+++ b/arch/arm/mach-mmp/brownstone.c
@@ -28,7 +28,7 @@
 
 #include "common.h"
 
-#define BROWNSTONE_NR_IRQS	(IRQ_BOARD_START + 40)
+#define BROWNSTONE_NR_IRQS	(MMP_NR_IRQS + 40)
 
 #define GPIO_5V_ENABLE		(89)
 
@@ -158,7 +158,7 @@ static struct platform_device brownstone_v_5vp_device = {
 };
 
 static struct max8925_platform_data brownstone_max8925_info = {
-	.irq_base		= IRQ_BOARD_START,
+	.irq_base		= MMP_NR_IRQS,
 };
 
 static struct i2c_board_info brownstone_twsi1_info[] = {
diff --git a/arch/arm/mach-mmp/flint.c b/arch/arm/mach-mmp/flint.c
index 2ee8cd7..8059cc0 100644
--- a/arch/arm/mach-mmp/flint.c
+++ b/arch/arm/mach-mmp/flint.c
@@ -23,10 +23,11 @@
 #include <mach/addr-map.h>
 #include <mach/mfp-mmp2.h>
 #include <mach/mmp2.h>
+#include <mach/irqs.h>
 
 #include "common.h"
 
-#define FLINT_NR_IRQS	(IRQ_BOARD_START + 48)
+#define FLINT_NR_IRQS	(MMP_NR_IRQS + 48)
 
 static unsigned long flint_pin_config[] __initdata = {
 	/* UART1 */
diff --git a/arch/arm/mach-mmp/gplugd.c b/arch/arm/mach-mmp/gplugd.c
index 8776546..f516e74 100644
--- a/arch/arm/mach-mmp/gplugd.c
+++ b/arch/arm/mach-mmp/gplugd.c
@@ -191,7 +191,7 @@ static void __init gplugd_init(void)
 
 MACHINE_START(GPLUGD, "PXA168-based GuruPlug Display (gplugD) Platform")
 	.map_io		= mmp_map_io,
-	.nr_irqs	= IRQ_BOARD_START,
+	.nr_irqs	= MMP_NR_IRQS,
 	.init_irq       = pxa168_init_irq,
 	.timer          = &pxa168_timer,
 	.init_machine   = gplugd_init,
diff --git a/arch/arm/mach-mmp/include/mach/irqs.h b/arch/arm/mach-mmp/include/mach/irqs.h
index 34635a0..d0e7466 100644
--- a/arch/arm/mach-mmp/include/mach/irqs.h
+++ b/arch/arm/mach-mmp/include/mach/irqs.h
@@ -223,7 +223,6 @@
 #define MMP_GPIO_TO_IRQ(gpio)		(IRQ_GPIO_START + (gpio))
 
 #define IRQ_BOARD_START			(IRQ_GPIO_START + MMP_NR_BUILTIN_GPIO)
-
-#define NR_IRQS				(IRQ_BOARD_START)
+#define MMP_NR_IRQS			IRQ_BOARD_START
 
 #endif /* __ASM_MACH_IRQS_H */
diff --git a/arch/arm/mach-mmp/irq-mmp2.c b/arch/arm/mach-mmp/irq-mmp2.c
index d21c544..7895d27 100644
--- a/arch/arm/mach-mmp/irq-mmp2.c
+++ b/arch/arm/mach-mmp/irq-mmp2.c
@@ -15,6 +15,7 @@
 #include <linux/irq.h>
 #include <linux/io.h>
 
+#include <mach/irqs.h>
 #include <mach/regs-icu.h>
 #include <mach/mmp2.h>
 
diff --git a/arch/arm/mach-mmp/jasper.c b/arch/arm/mach-mmp/jasper.c
index 96cf5c8..ff73249 100644
--- a/arch/arm/mach-mmp/jasper.c
+++ b/arch/arm/mach-mmp/jasper.c
@@ -19,6 +19,7 @@
 #include <linux/mfd/max8925.h>
 #include <linux/interrupt.h>
 
+#include <mach/irqs.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <mach/addr-map.h>
@@ -27,7 +28,7 @@
 
 #include "common.h"
 
-#define JASPER_NR_IRQS		(IRQ_BOARD_START + 48)
+#define JASPER_NR_IRQS		(MMP_NR_IRQS + 48)
 
 static unsigned long jasper_pin_config[] __initdata = {
 	/* UART1 */
@@ -135,7 +136,7 @@ static struct max8925_power_pdata jasper_power_data = {
 static struct max8925_platform_data jasper_max8925_info = {
 	.backlight		= &jasper_backlight_data,
 	.power			= &jasper_power_data,
-	.irq_base		= IRQ_BOARD_START,
+	.irq_base		= MMP_NR_IRQS,
 };
 
 static struct i2c_board_info jasper_twsi1_info[] = {
diff --git a/arch/arm/mach-mmp/tavorevb.c b/arch/arm/mach-mmp/tavorevb.c
index 8e3b5af0..507e6c0 100644
--- a/arch/arm/mach-mmp/tavorevb.c
+++ b/arch/arm/mach-mmp/tavorevb.c
@@ -102,6 +102,7 @@ static void __init tavorevb_init(void)
 
 MACHINE_START(TAVOREVB, "PXA910 Evaluation Board (aka TavorEVB)")
 	.map_io		= mmp_map_io,
+	.nr_irqs	= MMP_NR_IRQS,
 	.init_irq       = pxa910_init_irq,
 	.timer          = &pxa910_timer,
 	.init_machine   = tavorevb_init,
diff --git a/arch/arm/mach-mmp/teton_bga.c b/arch/arm/mach-mmp/teton_bga.c
index 0523e42..42bef66 100644
--- a/arch/arm/mach-mmp/teton_bga.c
+++ b/arch/arm/mach-mmp/teton_bga.c
@@ -26,6 +26,7 @@
 #include <mach/mfp-pxa168.h>
 #include <mach/pxa168.h>
 #include <mach/teton_bga.h>
+#include <mach/irqs.h>
 
 #include "common.h"
 
@@ -83,7 +84,7 @@ static void __init teton_bga_init(void)
 
 MACHINE_START(TETON_BGA, "PXA168-based Teton BGA Development Platform")
 	.map_io		= mmp_map_io,
-	.nr_irqs	= IRQ_BOARD_START,
+	.nr_irqs	= MMP_NR_IRQS,
 	.init_irq       = pxa168_init_irq,
 	.timer          = &pxa168_timer,
 	.init_machine   = teton_bga_init,
diff --git a/arch/arm/mach-mmp/ttc_dkb.c b/arch/arm/mach-mmp/ttc_dkb.c
index 5ac5d58..4c5fd5b 100644
--- a/arch/arm/mach-mmp/ttc_dkb.c
+++ b/arch/arm/mach-mmp/ttc_dkb.c
@@ -38,7 +38,7 @@
  * 16 board interrupts -- PCA9575 GPIO expander
  * 24 board interrupts -- 88PM860x PMIC
  */
-#define TTCDKB_NR_IRQS		(IRQ_BOARD_START + 16 + 16 + 24)
+#define TTCDKB_NR_IRQS		(MMP_NR_IRQS + 16 + 16 + 24)
 
 static unsigned long ttc_dkb_pin_config[] __initdata = {
 	/* UART2 */
@@ -130,7 +130,7 @@ static struct platform_device *ttc_dkb_devices[] = {
 static struct pca953x_platform_data max7312_data[] = {
 	{
 		.gpio_base	= TTCDKB_GPIO_EXT0(0),
-		.irq_base	= IRQ_BOARD_START,
+		.irq_base	= MMP_NR_IRQS,
 	},
 };
 
-- 
1.7.5.4
