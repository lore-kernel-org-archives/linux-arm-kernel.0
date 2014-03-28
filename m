From: elder@linaro.org (Alex Elder)
Date: Fri, 28 Mar 2014 16:12:54 -0500
Subject: [RFC PATCH 1/7] ARM: allow <asm/cputype.h> inclusion from assembly
In-Reply-To: <1396041180-29897-1-git-send-email-elder@linaro.org>
References: <1396041180-29897-1-git-send-email-elder@linaro.org>
Message-ID: <1396041180-29897-2-git-send-email-elder@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Conditionally exclude some portions of ARM <asm/cputype.h>
to allow that file to be included from assembly source.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 arch/arm/include/asm/cputype.h |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/include/asm/cputype.h b/arch/arm/include/asm/cputype.h
index acdde76..a74c671 100644
--- a/arch/arm/include/asm/cputype.h
+++ b/arch/arm/include/asm/cputype.h
@@ -2,7 +2,9 @@
 #define __ASM_ARM_CPUTYPE_H
 
 #include <linux/stringify.h>
+#ifndef __ASSEMBLY__
 #include <linux/kernel.h>
+#endif
 
 #define CPUID_ID	0
 #define CPUID_CACHETYPE	1
@@ -77,6 +79,7 @@
 #define ARM_CPU_XSCALE_ARCH_V2		0x4000
 #define ARM_CPU_XSCALE_ARCH_V3		0x6000
 
+#ifndef __ASSEMBLY__
 extern unsigned int processor_id;
 
 #ifdef CONFIG_CPU_CP15
@@ -219,5 +222,6 @@ static inline int cpu_is_xsc3(void)
 #else
 #define	cpu_is_xscale()	1
 #endif
+#endif /* !__ASSEMBLY__ */
 
 #endif
-- 
1.7.9.5
