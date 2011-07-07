From: dave.martin@linaro.org (Dave Martin)
Date: Thu,  7 Jul 2011 15:27:47 +0100
Subject: [PATCH v4 40/40] ARM: mm: tlb-v7: Use the new processor struct macros
In-Reply-To: <1310048867-14172-1-git-send-email-dave.martin@linaro.org>
References: <1310048867-14172-1-git-send-email-dave.martin@linaro.org>
Message-ID: <1310048867-14172-41-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 arch/arm/mm/tlb-v7.S |    9 ++-------
 1 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mm/tlb-v7.S b/arch/arm/mm/tlb-v7.S
index 53cd5b4..ebd4290 100644
--- a/arch/arm/mm/tlb-v7.S
+++ b/arch/arm/mm/tlb-v7.S
@@ -85,10 +85,5 @@ ENDPROC(v7wbi_flush_kern_tlb_range)
 
 	__INIT
 
-	.type	v7wbi_tlb_fns, #object
-ENTRY(v7wbi_tlb_fns)
-	.long	v7wbi_flush_user_tlb_range
-	.long	v7wbi_flush_kern_tlb_range
-	ALT_SMP(.long	v7wbi_tlb_flags_smp)
-	ALT_UP(.long	v7wbi_tlb_flags_up)
-	.size	v7wbi_tlb_fns, . - v7wbi_tlb_fns
+	/* define struct cpu_tlb_fns (see <asm/tlbflush.h> and proc-macros.S) */
+	define_tlb_functions v7wbi, v7wbi_tlb_flags_up, flags_smp=v7wbi_tlb_flags_smp
-- 
1.7.4.1
