From: robherring2@gmail.com (Rob Herring)
Date: Tue, 20 May 2014 16:09:30 -0500
Subject: [PATCH 04/10] irqchip: versatile-fpga: add DT init
In-Reply-To: <1400620176-7239-1-git-send-email-robherring2@gmail.com>
References: <1400620176-7239-1-git-send-email-robherring2@gmail.com>
Message-ID: <1400620176-7239-5-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <robh@kernel.org>

Add IRQCHIP_DECLARE call for the versatile-fpga interrupt controller so
that initialization from DT will work.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
---
 drivers/irqchip/irq-versatile-fpga.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/irqchip/irq-versatile-fpga.c b/drivers/irqchip/irq-versatile-fpga.c
index 328440b..11ab10d 100644
--- a/drivers/irqchip/irq-versatile-fpga.c
+++ b/drivers/irqchip/irq-versatile-fpga.c
@@ -14,6 +14,8 @@
 #include <asm/exception.h>
 #include <asm/mach/irq.h>
 
+#include "irqchip.h"
+
 #define IRQ_STATUS		0x00
 #define IRQ_RAW_STATUS		0x04
 #define IRQ_ENABLE_SET		0x08
@@ -217,4 +219,5 @@ int __init fpga_irq_of_init(struct device_node *node,
 
 	return 0;
 }
+IRQCHIP_DECLARE(arm_fpga, "arm,versatile-sic", fpga_irq_of_init);
 #endif
-- 
1.9.1
