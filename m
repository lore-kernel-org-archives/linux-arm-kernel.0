From: robherring2@gmail.com (Rob Herring)
Date: Fri, 20 Jan 2012 14:33:03 -0600
Subject: [PATCH v2 05/13] ARM: it8152: explicitly include mach/irqs.h
In-Reply-To: <1327091591-27125-1-git-send-email-robherring2@gmail.com>
References: <1327091591-27125-1-git-send-email-robherring2@gmail.com>
Message-ID: <1327091591-27125-6-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

In preparation to make mach/irqs.h optional, directly include mach/irq.h
to get IRQ_BOARD_START.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/include/asm/hardware/it8152.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/hardware/it8152.h b/arch/arm/include/asm/hardware/it8152.h
index 43cab49..73f84fa 100644
--- a/arch/arm/include/asm/hardware/it8152.h
+++ b/arch/arm/include/asm/hardware/it8152.h
@@ -9,6 +9,9 @@
 
 #ifndef __ASM_HARDWARE_IT8152_H
 #define __ASM_HARDWARE_IT8152_H
+
+#include <mach/irqs.h>
+
 extern void __iomem *it8152_base_address;
 
 #define IT8152_IO_BASE			(it8152_base_address + 0x03e00000)
-- 
1.7.5.4
