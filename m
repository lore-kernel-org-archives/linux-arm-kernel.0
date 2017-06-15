From: david.daney@cavium.com (David Daney)
Date: Thu, 15 Jun 2017 15:35:41 -0700
Subject: [PATCH RFC 1/3] arm64: Gate inclusion of asm/sysreg.h by
 __EMITTING_BPF__
In-Reply-To: <20170615223543.22867-1-david.daney@cavium.com>
References: <20170615223543.22867-1-david.daney@cavium.com>
Message-ID: <20170615223543.22867-2-david.daney@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Compilation to eBPF chokes on the inline asm in asm/sysreg.h, so don't
include it when compiling to a BPF target.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/arm64/include/asm/sysreg.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 15c142ce991c..faa8f853e369 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -20,6 +20,8 @@
 #ifndef __ASM_SYSREG_H
 #define __ASM_SYSREG_H
 
+#ifndef __EMITTING_BPF__
+
 #include <linux/stringify.h>
 
 /*
@@ -502,5 +504,5 @@ static inline void config_sctlr_el1(u32 clear, u32 set)
 }
 
 #endif
-
+#endif  /* __EMITTING_BPF__ */
 #endif	/* __ASM_SYSREG_H */
-- 
2.11.0
