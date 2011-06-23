From: dave.martin@linaro.org (Dave Martin)
Date: Thu, 23 Jun 2011 18:50:38 +0100
Subject: [PATCH v3 30/40] Subject: ARM: mm: proc-v6: Use the new processor
	struct macros
In-Reply-To: <1308851448-25139-1-git-send-email-dave.martin@linaro.org>
References: <1308851448-25139-1-git-send-email-dave.martin@linaro.org>
Message-ID: <1308851448-25139-31-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 arch/arm/mm/proc-v6.S |   34 +++++-----------------------------
 1 files changed, 5 insertions(+), 29 deletions(-)

diff --git a/arch/arm/mm/proc-v6.S b/arch/arm/mm/proc-v6.S
index 1d2b845..5ec1543 100644
--- a/arch/arm/mm/proc-v6.S
+++ b/arch/arm/mm/proc-v6.S
@@ -169,11 +169,7 @@ cpu_resume_l1_flags:
 #define cpu_v6_do_resume 0
 #endif
 
-
-	.type	cpu_v6_name, #object
-cpu_v6_name:
-	.asciz	"ARMv6-compatible processor"
-	.size	cpu_v6_name, . - cpu_v6_name
+	string	cpu_v6_name, "ARMv6-compatible processor"
 
 	.align
 
@@ -239,33 +235,13 @@ v6_crval:
 
 	__INITDATA
 
-	.type	v6_processor_functions, #object
-ENTRY(v6_processor_functions)
-	.word	v6_early_abort
-	.word	v6_pabort
-	.word	cpu_v6_proc_init
-	.word	cpu_v6_proc_fin
-	.word	cpu_v6_reset
-	.word	cpu_v6_do_idle
-	.word	cpu_v6_dcache_clean_area
-	.word	cpu_v6_switch_mm
-	.word	cpu_v6_set_pte_ext
-	.word	cpu_v6_suspend_size
-	.word	cpu_v6_do_suspend
-	.word	cpu_v6_do_resume
-	.size	v6_processor_functions, . - v6_processor_functions
+	@ define struct processor (see <asm/proc-fns.h> and proc-macros.S)
+	define_processor_functions v6, dabort=v6_early_abort, pabort=v6_pabort, suspend=1
 
 	.section ".rodata"
 
-	.type	cpu_arch_name, #object
-cpu_arch_name:
-	.asciz	"armv6"
-	.size	cpu_arch_name, . - cpu_arch_name
-
-	.type	cpu_elf_name, #object
-cpu_elf_name:
-	.asciz	"v6"
-	.size	cpu_elf_name, . - cpu_elf_name
+	string	cpu_arch_name, "armv6"
+	string	cpu_elf_name, "v6"
 	.align
 
 	.section ".proc.info.init", #alloc, #execinstr
-- 
1.7.4.1
