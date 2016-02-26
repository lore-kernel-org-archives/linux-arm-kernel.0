From: d-gerlach@ti.com (Dave Gerlach)
Date: Fri, 26 Feb 2016 16:06:58 -0600
Subject: [PATCH] ARM: scu: Should include asm/errno.h
Message-ID: <1456524418-4006-1-git-send-email-d-gerlach@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The stub for scu_power_mode returns -EINVAL if a !CONFIG_SMP build is
being done, and because this file can be included in files that are
shared between SMP and non-SMP platforms, we must make sure to
explicitly include asm/errno.h otherwise the build may fail based on
include order.

Reported-by: Dan Murphy <dmurphy@ti.com>
Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 arch/arm/include/asm/smp_scu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/include/asm/smp_scu.h b/arch/arm/include/asm/smp_scu.h
index bfe163c40024..e7f39655333a 100644
--- a/arch/arm/include/asm/smp_scu.h
+++ b/arch/arm/include/asm/smp_scu.h
@@ -8,6 +8,7 @@
 #ifndef __ASSEMBLER__
 
 #include <asm/cputype.h>
+#include <asm/errno.h>
 
 static inline bool scu_a9_has_base(void)
 {
-- 
2.7.2
