From: dave.martin@linaro.org (Dave Martin)
Date: Thu, 23 Jun 2011 18:50:39 +0100
Subject: [PATCH v3 31/40] Subject: ARM: mm: proc-v7: Use the new processor
	struct macros
In-Reply-To: <1308851448-25139-1-git-send-email-dave.martin@linaro.org>
References: <1308851448-25139-1-git-send-email-dave.martin@linaro.org>
Message-ID: <1308851448-25139-32-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 arch/arm/mm/proc-v7.S |   31 +++++--------------------------
 1 files changed, 5 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index b3b566e..929892b 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -171,8 +171,7 @@ ENTRY(cpu_v7_set_pte_ext)
 	mov	pc, lr
 ENDPROC(cpu_v7_set_pte_ext)
 
-cpu_v7_name:
-	.ascii	"ARMv7 Processor"
+	string	cpu_v7_name, "ARMv7 Processor"
 	.align
 
 	/*
@@ -405,33 +404,13 @@ __v7_setup_stack:
 
 	__INITDATA
 
-	.type	v7_processor_functions, #object
-ENTRY(v7_processor_functions)
-	.word	v7_early_abort
-	.word	v7_pabort
-	.word	cpu_v7_proc_init
-	.word	cpu_v7_proc_fin
-	.word	cpu_v7_reset
-	.word	cpu_v7_do_idle
-	.word	cpu_v7_dcache_clean_area
-	.word	cpu_v7_switch_mm
-	.word	cpu_v7_set_pte_ext
-	.word	0
-	.word	0
-	.word	0
-	.size	v7_processor_functions, . - v7_processor_functions
+	@ define struct processor (see <asm/proc-fns.h> and proc-macros.S)
+	define_processor_functions v7, dabort=v7_early_abort, pabort=v7_pabort
 
 	.section ".rodata"
 
-	.type	cpu_arch_name, #object
-cpu_arch_name:
-	.asciz	"armv7"
-	.size	cpu_arch_name, . - cpu_arch_name
-
-	.type	cpu_elf_name, #object
-cpu_elf_name:
-	.asciz	"v7"
-	.size	cpu_elf_name, . - cpu_elf_name
+	string	cpu_arch_name, "armv7"
+	string	cpu_elf_name, "v7"
 	.align
 
 	.section ".proc.info.init", #alloc, #execinstr
-- 
1.7.4.1
