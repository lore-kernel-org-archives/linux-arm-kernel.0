From: joel@porquet.org (Joel Porquet)
Date: Tue, 13 Oct 2015 14:56:14 +0200
Subject: [PATCH v2 2/3] arm:imx: IRQCHIP_DECLARE macro is now accessible
In-Reply-To: <1444740975-31948-1-git-send-email-joel@porquet.org>
References: <1444740975-31948-1-git-send-email-joel@porquet.org>
Message-ID: <1444740975-31948-3-git-send-email-joel@porquet.org>
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
 arch/arm/mach-imx/gpc.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-imx/gpc.c b/arch/arm/mach-imx/gpc.c
index 8c4467f..c7de608 100644
--- a/arch/arm/mach-imx/gpc.c
+++ b/arch/arm/mach-imx/gpc.c
@@ -14,6 +14,7 @@
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/irq.h>
+#include <linux/irqchip.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
@@ -269,11 +270,7 @@ static int __init imx_gpc_init(struct device_node *node,
 	return 0;
 }
 
-/*
- * We cannot use the IRQCHIP_DECLARE macro that lives in
- * drivers/irqchip, so we're forced to roll our own. Not very nice.
- */
-OF_DECLARE_2(irqchip, imx_gpc, "fsl,imx6q-gpc", imx_gpc_init);
+IRQCHIP_DECLARE(imx_gpc, "fsl,imx6q-gpc", imx_gpc_init);
 
 void __init imx_gpc_check_dt(void)
 {
-- 
2.6.1
