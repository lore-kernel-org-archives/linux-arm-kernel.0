From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 17 Sep 2009 10:12:37 +0100
Subject: [PATCH] Fix "W" macro in arch/arm/include/asm/unified.h
Message-ID: <20090917091237.8258.29171.stgit@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alexey Dobriyan <adobriyan@gmail.com>

Please, fold into 0becb088501886f37ade38762c8eaaf4263572cc
aka "Thumb-2: Add macros for the unified assembler syntax"

otherwise:

	crypto/cast6.c:372:39: error: macro "W" passed 2 arguments, but takes just 1

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/include/asm/unified.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/unified.h b/arch/arm/include/asm/unified.h
index 073e85b..bc63116 100644
--- a/arch/arm/include/asm/unified.h
+++ b/arch/arm/include/asm/unified.h
@@ -35,7 +35,9 @@
 
 #define ARM(x...)
 #define THUMB(x...)	x
+#ifdef __ASSEMBLY__
 #define W(instr)	instr.w
+#endif
 #define BSYM(sym)	sym + 1
 
 #else	/* !CONFIG_THUMB2_KERNEL */
@@ -45,7 +47,9 @@
 
 #define ARM(x...)	x
 #define THUMB(x...)
+#ifdef __ASSEMBLY__
 #define W(instr)	instr
+#endif
 #define BSYM(sym)	sym
 
 #endif	/* CONFIG_THUMB2_KERNEL */
