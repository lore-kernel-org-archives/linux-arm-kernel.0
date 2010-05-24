From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 24 May 2010 14:35:46 +0800
Subject: [PATCH 3/6] [ARM] pxa/hx4700: encode IRQ number into .nr_irqs
In-Reply-To: <1274682949-25915-1-git-send-email-eric.y.miao@gmail.com>
References: <1274682949-25915-1-git-send-email-eric.y.miao@gmail.com>
Message-ID: <1274682949-25915-4-git-send-email-eric.y.miao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Philipp Zabel <philipp.zabel@gmail.com>
Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
---
 arch/arm/mach-pxa/Kconfig               |    1 -
 arch/arm/mach-pxa/hx4700.c              |    1 +
 arch/arm/mach-pxa/include/mach/hx4700.h |    4 ++++
 arch/arm/mach-pxa/include/mach/irqs.h   |    4 +---
 4 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
index bf49135..32b1fd2 100644
--- a/arch/arm/mach-pxa/Kconfig
+++ b/arch/arm/mach-pxa/Kconfig
@@ -259,7 +259,6 @@ config MACH_H4700
 	select PXA27x
 	select IWMMXT
 	select HAVE_PWM
-	select PXA_HAVE_BOARD_IRQS
 
 config MACH_H5000
 	bool "HP iPAQ h5000"
diff --git a/arch/arm/mach-pxa/hx4700.c b/arch/arm/mach-pxa/hx4700.c
index 848c861..10104f1 100644
--- a/arch/arm/mach-pxa/hx4700.c
+++ b/arch/arm/mach-pxa/hx4700.c
@@ -874,6 +874,7 @@ MACHINE_START(H4700, "HP iPAQ HX4700")
 	.io_pg_offst  = (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params  = 0xa0000100,
 	.map_io       = pxa_map_io,
+	.nr_irqs      = HX4700_NR_IRQS,
 	.init_irq     = pxa27x_init_irq,
 	.init_machine = hx4700_init,
 	.timer        = &pxa_timer,
diff --git a/arch/arm/mach-pxa/include/mach/hx4700.h b/arch/arm/mach-pxa/include/mach/hx4700.h
index 9eaeed1..862a190 100644
--- a/arch/arm/mach-pxa/include/mach/hx4700.h
+++ b/arch/arm/mach-pxa/include/mach/hx4700.h
@@ -128,4 +128,8 @@
 #define EGPIO7_VCC_3V3_WL_EN	(HX4700_EGPIO_BASE + 7)	/* WLAN 3.3V enable */
 #define EGPIO8_USB_3V3_ON	(HX4700_EGPIO_BASE + 8)	/* unused */
 
+/*
+ * IRQs
+ */
+#define HX4700_NR_IRQS		(IRQ_BOARD_START + 70)	/* ASIC3 */
 #endif /* _HX4700_H_ */
diff --git a/arch/arm/mach-pxa/include/mach/irqs.h b/arch/arm/mach-pxa/include/mach/irqs.h
index 3b3b245..169567c 100644
--- a/arch/arm/mach-pxa/include/mach/irqs.h
+++ b/arch/arm/mach-pxa/include/mach/irqs.h
@@ -125,9 +125,7 @@
  */
 #define IRQ_BOARD_START		(PXA_GPIO_IRQ_BASE + PXA_GPIO_IRQ_NUM)
 
-#if defined(CONFIG_MACH_H4700)
-#define IRQ_BOARD_END		(IRQ_BOARD_START + 70)
-#elif defined(CONFIG_PXA_EZX)
+#if defined(CONFIG_PXA_EZX)
 #define IRQ_BOARD_END		(IRQ_BOARD_START + 23)
 #else
 #define IRQ_BOARD_END		(IRQ_BOARD_START + 16)
-- 
1.7.0.4
