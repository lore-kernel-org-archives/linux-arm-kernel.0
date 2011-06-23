From: dave.martin@linaro.org (Dave Martin)
Date: Thu, 23 Jun 2011 18:50:10 +0100
Subject: [PATCH v3 02/40] Subject: ARM: assembler.h: Add string declaration
	macro
In-Reply-To: <1308851448-25139-1-git-send-email-dave.martin@linaro.org>
References: <1308851448-25139-1-git-send-email-dave.martin@linaro.org>
Message-ID: <1308851448-25139-3-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Declaring strings in assembler source involves a certain amount of
tedious boilerplate code in order to annotate the resulting symbol
correctly.

Encapsulating this boilerplate in a macro should help to avoid some
duplication and the occasional mistake.

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 arch/arm/include/asm/assembler.h |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
index bc2d2d7..9e1e952 100644
--- a/arch/arm/include/asm/assembler.h
+++ b/arch/arm/include/asm/assembler.h
@@ -290,3 +290,11 @@
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
-- 
1.7.4.1
