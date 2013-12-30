From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Mon, 30 Dec 2013 10:34:57 +0530
Subject: [PATCH 1/1] arm: Trivial cleanup in sp810.h
Message-ID: <1388379897-30548-1-git-send-email-sachin.kamat@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit da660b4a3b15 ("arm: Move sp810.h to include/linux/amba/")
moved the file to the current location but forgot to remove the pointer
to its previous location. Clean it up. While at it also change the header
file protection macros appropriately.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
---
 include/linux/amba/sp810.h |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/include/linux/amba/sp810.h b/include/linux/amba/sp810.h
index 6636430dd0e6..c7df89f99115 100644
--- a/include/linux/amba/sp810.h
+++ b/include/linux/amba/sp810.h
@@ -1,6 +1,4 @@
 /*
- * arch/arm/include/asm/hardware/sp810.h
- *
  * ARM PrimeXsys System Controller SP810 header file
  *
  * Copyright (C) 2009 ST Microelectronics
@@ -11,8 +9,8 @@
  * warranty of any kind, whether express or implied.
  */
 
-#ifndef __ASM_ARM_SP810_H
-#define __ASM_ARM_SP810_H
+#ifndef __AMBA_SP810_H
+#define __AMBA_SP810_H
 
 #include <linux/io.h>
 
@@ -61,4 +59,4 @@ static inline void sysctl_soft_reset(void __iomem *base)
 	writel(0, base + SCSYSSTAT);
 }
 
-#endif	/* __ASM_ARM_SP810_H */
+#endif /* __AMBA_SP810_H */
-- 
1.7.9.5
