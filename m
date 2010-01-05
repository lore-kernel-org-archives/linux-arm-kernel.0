From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue,  5 Jan 2010 16:05:16 +0000
Subject: [PATCH 2/2] mx31ads: Provide an IRQ range to the WM835x on the
	1133-EV1 module
In-Reply-To: <1262707516-20938-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1262707516-20938-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <1262707516-20938-2-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The WM8350 core won't actually use the range yet, but it will in
future and the platform data to configure it is there now.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/mach-mx3/mx31ads.c           |    1 +
 arch/arm/plat-mxc/include/mach/irqs.h |    5 +++++
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx3/mx31ads.c b/arch/arm/mach-mx3/mx31ads.c
index c486c2f..ed8498a 100644
--- a/arch/arm/mach-mx3/mx31ads.c
+++ b/arch/arm/mach-mx3/mx31ads.c
@@ -452,6 +452,7 @@ static int mx31_wm8350_init(struct wm8350 *wm8350)
 
 static struct wm8350_platform_data __initdata mx31_wm8350_pdata = {
 	.init = mx31_wm8350_init,
+	.irq_base = MXC_BOARD_IRQ_START + MXC_MAX_EXP_IO_LINES,
 };
 #endif
 
diff --git a/arch/arm/plat-mxc/include/mach/irqs.h b/arch/arm/plat-mxc/include/mach/irqs.h
index ead9d59..0cb3476 100644
--- a/arch/arm/plat-mxc/include/mach/irqs.h
+++ b/arch/arm/plat-mxc/include/mach/irqs.h
@@ -37,7 +37,12 @@
  * within sensible limits.
  */
 #define MXC_BOARD_IRQ_START	(MXC_INTERNAL_IRQS + MXC_GPIO_IRQS)
+
+#ifdef CONFIG_MACH_MX31ADS_WM1133_EV1
+#define MXC_BOARD_IRQS  80
+#else
 #define MXC_BOARD_IRQS	16
+#endif
 
 #define MXC_IPU_IRQ_START	(MXC_BOARD_IRQ_START + MXC_BOARD_IRQS)
 
-- 
1.6.5.7
