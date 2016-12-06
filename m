From: abelvesa@linux.com (Abel Vesa)
Date: Tue,  6 Dec 2016 17:06:05 +0000
Subject: [PATCH 5/7] arm: ftrace: Add ARCH_SUPPORTS_FTRACE_OPS for ftrace with
 regs
In-Reply-To: <1481043967-15602-1-git-send-email-abelvesa@linux.com>
References: <1481043967-15602-1-git-send-email-abelvesa@linux.com>
Message-ID: <1481043967-15602-6-git-send-email-abelvesa@linux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARCH_SUPPORTS_FTRACE_OPS is needed for livepatch if
CONFIG_DYNAMIC_FTRACE_WITH_REGS is defined.

Signed-off-by: Abel Vesa <abelvesa@linux.com>
---
 arch/arm/include/asm/ftrace.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/include/asm/ftrace.h b/arch/arm/include/asm/ftrace.h
index bfe2a2f..f434ce9 100644
--- a/arch/arm/include/asm/ftrace.h
+++ b/arch/arm/include/asm/ftrace.h
@@ -1,6 +1,10 @@
 #ifndef _ASM_ARM_FTRACE
 #define _ASM_ARM_FTRACE
 
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
+#define ARCH_SUPPORTS_FTRACE_OPS 1
+#endif
+
 #ifdef CONFIG_FUNCTION_TRACER
 #define MCOUNT_ADDR		((unsigned long)(__gnu_mcount_nc))
 #define MCOUNT_INSN_SIZE	4 /* sizeof mcount call */
-- 
2.7.4
