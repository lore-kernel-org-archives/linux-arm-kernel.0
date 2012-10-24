From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 24 Oct 2012 15:45:23 +0100
Subject: [PATCH 3/6] ARM: ux500: Fix build error relating to
 IRQCHIP_SKIP_SET_WAKE
In-Reply-To: <1351089926-32161-1-git-send-email-lee.jones@linaro.org>
References: <1351089926-32161-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1351089926-32161-4-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the build error below:

arch/arm/mach-ux500/cpu.c: In function ?ux500_init_irq?:
arch/arm/mach-ux500/cpu.c:55:2: error: invalid use of undefined type ?struct irq_chip?
arch/arm/mach-ux500/cpu.c:55:24: error: ?IRQCHIP_SKIP_SET_WAKE? undeclared (first use in this function)
arch/arm/mach-ux500/cpu.c:55:24: note: each undeclared identifier is reported only once for each function it appears in
arch/arm/mach-ux500/cpu.c:55:48: error: ?IRQCHIP_MASK_ON_SUSPEND? undeclared (first use in this function)

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/cpu.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-ux500/cpu.c b/arch/arm/mach-ux500/cpu.c
index fb25f4e..721e7b4 100644
--- a/arch/arm/mach-ux500/cpu.c
+++ b/arch/arm/mach-ux500/cpu.c
@@ -16,6 +16,7 @@
 #include <linux/stat.h>
 #include <linux/of.h>
 #include <linux/of_irq.h>
+#include <linux/irq.h>
 #include <linux/platform_data/clk-ux500.h>
 
 #include <asm/hardware/gic.h>
-- 
1.7.9.5
