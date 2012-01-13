From: robherring2@gmail.com (Rob Herring)
Date: Fri, 13 Jan 2012 10:34:07 -0600
Subject: [RFC PATCH 06/10] ARM: mmp: remove NR_IRQS
In-Reply-To: <1326472451-9002-1-git-send-email-robherring2@gmail.com>
References: <1326472451-9002-1-git-send-email-robherring2@gmail.com>
Message-ID: <1326472451-9002-7-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Remove NR_IRQS and add a per machine .nr_irqs setting.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/mach-mmp/avengers_lite.c     |    1 +
 arch/arm/mach-mmp/include/mach/irqs.h |    2 --
 arch/arm/mach-mmp/irq-mmp2.c          |    1 +
 arch/arm/mach-mmp/jasper.c            |    1 +
 arch/arm/mach-mmp/tavorevb.c          |    1 +
 5 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mmp/avengers_lite.c b/arch/arm/mach-mmp/avengers_lite.c
index b148a9d..0fd60fb 100644
--- a/arch/arm/mach-mmp/avengers_lite.c
+++ b/arch/arm/mach-mmp/avengers_lite.c
@@ -43,6 +43,7 @@ static void __init avengers_lite_init(void)
 
 MACHINE_START(AVENGERS_LITE, "PXA168 Avengers lite Development Platform")
 	.map_io		= mmp_map_io,
+	.nr_irqs	= IRQ_BOARD_START,
 	.init_irq       = pxa168_init_irq,
 	.timer          = &pxa168_timer,
 	.init_machine   = avengers_lite_init,
diff --git a/arch/arm/mach-mmp/include/mach/irqs.h b/arch/arm/mach-mmp/include/mach/irqs.h
index 34635a0..25e6d60 100644
--- a/arch/arm/mach-mmp/include/mach/irqs.h
+++ b/arch/arm/mach-mmp/include/mach/irqs.h
@@ -224,6 +224,4 @@
 
 #define IRQ_BOARD_START			(IRQ_GPIO_START + MMP_NR_BUILTIN_GPIO)
 
-#define NR_IRQS				(IRQ_BOARD_START)
-
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
index 96cf5c8..8f80c31 100644
--- a/arch/arm/mach-mmp/jasper.c
+++ b/arch/arm/mach-mmp/jasper.c
@@ -19,6 +19,7 @@
 #include <linux/mfd/max8925.h>
 #include <linux/interrupt.h>
 
+#include <mach/irqs.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <mach/addr-map.h>
diff --git a/arch/arm/mach-mmp/tavorevb.c b/arch/arm/mach-mmp/tavorevb.c
index 8e3b5af0..d3ba655 100644
--- a/arch/arm/mach-mmp/tavorevb.c
+++ b/arch/arm/mach-mmp/tavorevb.c
@@ -102,6 +102,7 @@ static void __init tavorevb_init(void)
 
 MACHINE_START(TAVOREVB, "PXA910 Evaluation Board (aka TavorEVB)")
 	.map_io		= mmp_map_io,
+	.nr_irqs	= IRQ_BOARD_START,
 	.init_irq       = pxa910_init_irq,
 	.timer          = &pxa910_timer,
 	.init_machine   = tavorevb_init,
-- 
1.7.5.4
