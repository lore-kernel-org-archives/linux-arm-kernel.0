From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon,  7 Dec 2015 10:11:12 +0000
Subject: [PATCH 2/2] irqchip/gic-v3: Add missing include for barrier.h
In-Reply-To: <1449483072-17694-1-git-send-email-marc.zyngier@arm.com>
References: <1449483072-17694-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1449483072-17694-3-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Both the 32bit and 64bit versions of the GICv3 header file are using
barriers, but neglect to include barrier.h, leading to an interesting
splat in some circumstances.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/arch_gicv3.h   | 1 +
 arch/arm64/include/asm/arch_gicv3.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/include/asm/arch_gicv3.h b/arch/arm/include/asm/arch_gicv3.h
index 6607d97..7da5503 100644
--- a/arch/arm/include/asm/arch_gicv3.h
+++ b/arch/arm/include/asm/arch_gicv3.h
@@ -21,6 +21,7 @@
 #ifndef __ASSEMBLY__
 
 #include <linux/io.h>
+#include <asm/barrier.h>
 
 #define __ACCESS_CP15(CRn, Op1, CRm, Op2)	p15, Op1, %0, CRn, CRm, Op2
 #define __ACCESS_CP15_64(Op1, CRm)		p15, Op1, %Q0, %R0, CRm
diff --git a/arch/arm64/include/asm/arch_gicv3.h b/arch/arm64/include/asm/arch_gicv3.h
index 030cdcb..2731d3b 100644
--- a/arch/arm64/include/asm/arch_gicv3.h
+++ b/arch/arm64/include/asm/arch_gicv3.h
@@ -77,6 +77,7 @@
 #ifndef __ASSEMBLY__
 
 #include <linux/stringify.h>
+#include <asm/barrier.h>
 
 /*
  * Low-level accessors
-- 
2.1.4
