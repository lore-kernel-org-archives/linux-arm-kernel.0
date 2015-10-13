From: joel@porquet.org (Joel Porquet)
Date: Tue, 13 Oct 2015 14:56:15 +0200
Subject: [PATCH v2 3/3] arm:omap2: IRQCHIP_DECLARE macro is now accessible
In-Reply-To: <1444740975-31948-1-git-send-email-joel@porquet.org>
References: <1444740975-31948-1-git-send-email-joel@porquet.org>
Message-ID: <1444740975-31948-4-git-send-email-joel@porquet.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The IRQCHIP_DECLARE macro migrated to 'include/linux/irqchip.h', making it
globally accessible.

See commit 91e20b5040c67c51aad88cf87db4305c5bd7f79d ("irqchip: Move
IRQCHIP_DECLARE macro to include/linux/irqchip.h").

This patch adds the inclusion of 'include/linux/irqchip.h' and replaces the
use of OF_DECLARE_2 with IRQCHIP_DECLARE.

Signed-off-by: Joel Porquet <joel@porquet.org>
---
 arch/arm/mach-omap2/omap-wakeupgen.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-wakeupgen.c b/arch/arm/mach-omap2/omap-wakeupgen.c
index e1d2e99..a2dc324 100644
--- a/arch/arm/mach-omap2/omap-wakeupgen.c
+++ b/arch/arm/mach-omap2/omap-wakeupgen.c
@@ -20,6 +20,7 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/irq.h>
+#include <linux/irqchip.h>
 #include <linux/irqdomain.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
@@ -538,8 +539,4 @@ static int __init wakeupgen_init(struct device_node *node,
 	return 0;
 }
 
-/*
- * We cannot use the IRQCHIP_DECLARE macro that lives in
- * drivers/irqchip, so we're forced to roll our own. Not very nice.
- */
-OF_DECLARE_2(irqchip, ti_wakeupgen, "ti,omap4-wugen-mpu", wakeupgen_init);
+IRQCHIP_DECLARE(ti_wakeupgen, "ti,omap4-wugen-mpu", wakeupgen_init);
-- 
2.6.1
