From: dave.martin@linaro.org (Dave Martin)
Date: Thu,  7 Jul 2011 15:27:09 +0100
Subject: [PATCH v4 02/40] ARM: assembler.h: Add string declaration macro
In-Reply-To: <1310048867-14172-1-git-send-email-dave.martin@linaro.org>
References: <1310048867-14172-1-git-send-email-dave.martin@linaro.org>
Message-ID: <1310048867-14172-3-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Declaring strings in assembler source involves a certain amount of
tedious boilerplate code in order to annotate the resulting symbol
correctly.

Encapsulating this boilerplate in a macro should help to avoid some
duplication and the occasional mistake.

Signed-off-by: Dave Martin <dave.martin@linaro.org>
Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/include/asm/assembler.h |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
index 65c3f24..29035e8 100644
--- a/arch/arm/include/asm/assembler.h
+++ b/arch/arm/include/asm/assembler.h
@@ -293,4 +293,13 @@
 	.macro	ldrusr, reg, ptr, inc, cond=al, rept=1, abort=9001f
 	usracc	ldr, \reg, \ptr, \inc, \cond, \rept, \abort
 	.endm
+
+/* Utility macro for declaring string literals */
+	.macro	string name:req, string
+	.type \name , #object
+\name:
+	.asciz "\string"
+	.size \name , . - \name
+	.endm
+
 #endif /* __ASM_ASSEMBLER_H__ */
-- 
1.7.4.1
