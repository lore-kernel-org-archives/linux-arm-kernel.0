From: dave.martin@linaro.org (Dave Martin)
Date: Thu,  7 Jul 2011 15:27:32 +0100
Subject: [PATCH v4 25/40] ARM: mm: proc-fa526: Use the new processor struct
	macros
In-Reply-To: <1310048867-14172-1-git-send-email-dave.martin@linaro.org>
References: <1310048867-14172-1-git-send-email-dave.martin@linaro.org>
Message-ID: <1310048867-14172-26-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 arch/arm/mm/proc-fa526.S |   38 +++++---------------------------------
 1 files changed, 5 insertions(+), 33 deletions(-)

diff --git a/arch/arm/mm/proc-fa526.S b/arch/arm/mm/proc-fa526.S
index fc2a4ae..4c7a571 100644
--- a/arch/arm/mm/proc-fa526.S
+++ b/arch/arm/mm/proc-fa526.S
@@ -180,42 +180,14 @@ fa526_cr1_set:
 
 	__INITDATA
 
-/*
- * Purpose : Function pointers used to access above functions - all calls
- *	     come through these
- */
-	.type	fa526_processor_functions, #object
-fa526_processor_functions:
-	.word	v4_early_abort
-	.word	legacy_pabort
-	.word	cpu_fa526_proc_init
-	.word	cpu_fa526_proc_fin
-	.word	cpu_fa526_reset
-	.word   cpu_fa526_do_idle
-	.word	cpu_fa526_dcache_clean_area
-	.word	cpu_fa526_switch_mm
-	.word	cpu_fa526_set_pte_ext
-	.word	0
-	.word	0
-	.word	0
-	.size	fa526_processor_functions, . - fa526_processor_functions
+	@ define struct processor (see <asm/proc-fns.h> and proc-macros.S)
+	define_processor_functions fa526, dabort=v4_early_abort, pabort=legacy_pabort
 
 	.section ".rodata"
 
-	.type	cpu_arch_name, #object
-cpu_arch_name:
-	.asciz	"armv4"
-	.size	cpu_arch_name, . - cpu_arch_name
-
-	.type	cpu_elf_name, #object
-cpu_elf_name:
-	.asciz	"v4"
-	.size	cpu_elf_name, . - cpu_elf_name
-
-	.type	cpu_fa526_name, #object
-cpu_fa526_name:
-	.asciz	"FA526"
-	.size	cpu_fa526_name, . - cpu_fa526_name
+	string	cpu_arch_name, "armv4"
+	string	cpu_elf_name, "v4"
+	string	cpu_fa526_name, "FA526"
 
 	.align
 
-- 
1.7.4.1
