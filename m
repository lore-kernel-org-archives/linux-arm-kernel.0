From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 25 Mar 2013 23:22:50 +0800
Subject: [PATCH 2/3] ARM: mxs: call stmp_reset_block() in icoll
In-Reply-To: <1364224971-28431-1-git-send-email-shawn.guo@linaro.org>
References: <1364224971-28431-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1364224971-28431-3-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Call stmp_reset_block() rather than mxs_reset_block(), so that
<mach/common.h> inclusion can be removed from icoll driver.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-mxs/icoll.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mxs/icoll.c b/arch/arm/mach-mxs/icoll.c
index 1cf32af..b4d6207 100644
--- a/arch/arm/mach-mxs/icoll.c
+++ b/arch/arm/mach-mxs/icoll.c
@@ -24,8 +24,8 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
+#include <linux/stmp_device.h>
 #include <asm/exception.h>
-#include <mach/common.h>
 
 #define HW_ICOLL_VECTOR				0x0000
 #define HW_ICOLL_LEVELACK			0x0010
@@ -110,7 +110,7 @@ static void __init icoll_of_init(struct device_node *np,
 	 * Interrupt Collector reset, which initializes the priority
 	 * for each irq to level 0.
 	 */
-	mxs_reset_block(icoll_base + HW_ICOLL_CTRL);
+	stmp_reset_block(icoll_base + HW_ICOLL_CTRL);
 
 	icoll_domain = irq_domain_add_linear(np, ICOLL_NUM_IRQS,
 					     &icoll_irq_domain_ops, NULL);
-- 
1.7.9.5
