From: dave.martin@linaro.org (Dave Martin)
Date: Thu,  7 Jul 2011 15:27:35 +0100
Subject: [PATCH v4 28/40] ARM: mm: proc-sa110: Use the new processor struct
	macros
In-Reply-To: <1310048867-14172-1-git-send-email-dave.martin@linaro.org>
References: <1310048867-14172-1-git-send-email-dave.martin@linaro.org>
Message-ID: <1310048867-14172-29-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 arch/arm/mm/proc-sa110.S |   39 +++++----------------------------------
 1 files changed, 5 insertions(+), 34 deletions(-)

diff --git a/arch/arm/mm/proc-sa110.S b/arch/arm/mm/proc-sa110.S
index 46f09ed..d50ada2 100644
--- a/arch/arm/mm/proc-sa110.S
+++ b/arch/arm/mm/proc-sa110.S
@@ -187,43 +187,14 @@ sa110_crval:
 
 	__INITDATA
 
-/*
- * Purpose : Function pointers used to access above functions - all calls
- *	     come through these
- */
-
-	.type	sa110_processor_functions, #object
-ENTRY(sa110_processor_functions)
-	.word	v4_early_abort
-	.word	legacy_pabort
-	.word	cpu_sa110_proc_init
-	.word	cpu_sa110_proc_fin
-	.word	cpu_sa110_reset
-	.word	cpu_sa110_do_idle
-	.word	cpu_sa110_dcache_clean_area
-	.word	cpu_sa110_switch_mm
-	.word	cpu_sa110_set_pte_ext
-	.word	0
-	.word	0
-	.word	0
-	.size	sa110_processor_functions, . - sa110_processor_functions
+	@ define struct processor (see <asm/proc-fns.h> and proc-macros.S)
+	define_processor_functions sa110, dabort=v4_early_abort, pabort=legacy_pabort
 
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
-	.type	cpu_sa110_name, #object
-cpu_sa110_name:
-	.asciz	"StrongARM-110"
-	.size	cpu_sa110_name, . - cpu_sa110_name
+	string	cpu_arch_name, "armv4"
+	string	cpu_elf_name, "v4"
+	string	cpu_sa110_name, "StrongARM-110"
 
 	.align
 
-- 
1.7.4.1
