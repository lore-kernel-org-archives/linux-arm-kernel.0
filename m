From: dave.martin@linaro.org (Dave Martin)
Date: Thu,  7 Jul 2011 15:27:45 +0100
Subject: [PATCH v4 38/40] ARM: mm: tlb-v4wbi: Use the new processor struct
	macros
In-Reply-To: <1310048867-14172-1-git-send-email-dave.martin@linaro.org>
References: <1310048867-14172-1-git-send-email-dave.martin@linaro.org>
Message-ID: <1310048867-14172-39-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 arch/arm/mm/tlb-v4wbi.S |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mm/tlb-v4wbi.S b/arch/arm/mm/tlb-v4wbi.S
index 60cfc4a..1f6062b 100644
--- a/arch/arm/mm/tlb-v4wbi.S
+++ b/arch/arm/mm/tlb-v4wbi.S
@@ -60,9 +60,5 @@ ENTRY(v4wbi_flush_kern_tlb_range)
 
 	__INITDATA
 
-	.type	v4wbi_tlb_fns, #object
-ENTRY(v4wbi_tlb_fns)
-	.long	v4wbi_flush_user_tlb_range
-	.long	v4wbi_flush_kern_tlb_range
-	.long	v4wbi_tlb_flags
-	.size	v4wbi_tlb_fns, . - v4wbi_tlb_fns
+	/* define struct cpu_tlb_fns (see <asm/tlbflush.h> and proc-macros.S) */
+	define_tlb_functions v4wbi, v4wbi_tlb_flags
-- 
1.7.4.1
