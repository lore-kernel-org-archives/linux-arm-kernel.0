From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri,  8 Jan 2010 15:23:27 +0000
Subject: [PATCH] SMDK6410: Set up interrupt range for WM835x on 1190-EV1 PMIC
	board
Message-ID: <1262964207-18832-1-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The WM835x driver won't actually use this yet but it will in the
future when the changes converting it to genirq are merged.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/mach-s3c6410/mach-smdk6410.c     |    1 +
 arch/arm/plat-s3c64xx/include/plat/irqs.h |    4 ++++
 2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c6410/mach-smdk6410.c b/arch/arm/mach-s3c6410/mach-smdk6410.c
index 3e9f8c9..d79b0aa 100644
--- a/arch/arm/mach-s3c6410/mach-smdk6410.c
+++ b/arch/arm/mach-s3c6410/mach-smdk6410.c
@@ -388,6 +388,7 @@ static int __init smdk6410_wm8350_init(struct wm8350 *wm8350)
 static struct wm8350_platform_data __initdata smdk6410_wm8350_pdata = {
 	.init = smdk6410_wm8350_init,
 	.irq_high = 1,
+	.irq_base = IRQ_BOARD_START,
 };
 #endif
 
diff --git a/arch/arm/plat-s3c64xx/include/plat/irqs.h b/arch/arm/plat-s3c64xx/include/plat/irqs.h
index 176fe15..a227581 100644
--- a/arch/arm/plat-s3c64xx/include/plat/irqs.h
+++ b/arch/arm/plat-s3c64xx/include/plat/irqs.h
@@ -198,7 +198,11 @@
  * interrupt controllers). */
 #define IRQ_BOARD_START (IRQ_EINT_GROUP9_BASE + IRQ_EINT_GROUP9_NR + 1)
 
+#ifdef CONFIG_SMDK6410_WM1190_EV1
+#define IRQ_BOARD_NR 64
+#else
 #define IRQ_BOARD_NR 16
+#endif
 
 #define IRQ_BOARD_END (IRQ_BOARD_START + IRQ_BOARD_NR)
 
-- 
1.6.6
