From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 8 Jul 2013 22:23:02 +0800
Subject: [PATCH 2/2] ARM: imx: use imx specific L2 init function on imx6sl
In-Reply-To: <1373293383-15128-1-git-send-email-shawn.guo@linaro.org>
References: <1373293383-15128-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1373293383-15128-3-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The optimized L2 prefect and power setting done in imx_init_l2cache()
can also benefit imx6sl, so let's call the function on imx6sl as well.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/mach-imx6sl.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/mach-imx6sl.c b/arch/arm/mach-imx/mach-imx6sl.c
index 132db260..0d75dc5 100644
--- a/arch/arm/mach-imx/mach-imx6sl.c
+++ b/arch/arm/mach-imx/mach-imx6sl.c
@@ -11,7 +11,6 @@
 #include <linux/irqchip.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
-#include <asm/hardware/cache-l2x0.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
@@ -26,7 +25,7 @@ static void __init imx6sl_init_machine(void)
 
 static void __init imx6sl_init_irq(void)
 {
-	l2x0_of_init(0, ~0UL);
+	imx_init_l2cache();
 	imx_src_init();
 	imx_gpc_init();
 	irqchip_init();
-- 
1.7.9.5
