From: julien.thierry@arm.com (Julien Thierry)
Date: Fri, 25 May 2018 10:49:12 +0100
Subject: [PATCH v4 06/26] irqchip/gic: Lower priority of GIC interrupts
In-Reply-To: <1527241772-48007-1-git-send-email-julien.thierry@arm.com>
References: <1527241772-48007-1-git-send-email-julien.thierry@arm.com>
Message-ID: <1527241772-48007-7-git-send-email-julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current value used for IRQ priorities is high among the
non-secure interrupt priority values.

Lower the default priority of interrupts so there is more flexibility
to define higher priority interrupts.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
---
 include/linux/irqchip/arm-gic-common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/irqchip/arm-gic-common.h b/include/linux/irqchip/arm-gic-common.h
index 9a1a479..2c9a4b3 100644
--- a/include/linux/irqchip/arm-gic-common.h
+++ b/include/linux/irqchip/arm-gic-common.h
@@ -13,7 +13,7 @@
 #include <linux/types.h>
 #include <linux/ioport.h>
 
-#define GICD_INT_DEF_PRI		0xa0
+#define GICD_INT_DEF_PRI		0xc0
 #define GICD_INT_DEF_PRI_X4		((GICD_INT_DEF_PRI << 24) |\
 					(GICD_INT_DEF_PRI << 16) |\
 					(GICD_INT_DEF_PRI << 8) |\
-- 
1.9.1
