From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Sun,  3 Jan 2010 17:04:49 +0530
Subject: [PATCH] ARM: include needed linux/cpu.h in asm/cpu.h
Message-ID: <1262518489-6867-1-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The file arch/arm/include/asm/cpu.h needs to include 'linux/cpu.h' to
meet its dependency. Otherwise when using "struct cpuinfo_arm" and including
just 'asm/cpu.h' throws below error -
	arch/arm/include/asm/cpu.h:16: error: field 'cpu' has incomplete type

To fix this  otherway, one can also include both linux/cpu.h and asm/cpu.h
ubut it shoudn't be that way. So this patch fixes this by including the
linux/cpu.h in asm/cpu.h,so that including alone asm/cpu.h is enough.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/include/asm/cpu.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/cpu.h b/arch/arm/include/asm/cpu.h
index 634b2d7..7939681 100644
--- a/arch/arm/include/asm/cpu.h
+++ b/arch/arm/include/asm/cpu.h
@@ -11,6 +11,7 @@
 #define __ASM_ARM_CPU_H
 
 #include <linux/percpu.h>
+#include <linux/cpu.h>
 
 struct cpuinfo_arm {
 	struct cpu	cpu;
-- 
1.6.0.4
