From: dave.martin@linaro.org (Dave Martin)
Date: Thu,  7 Jul 2011 15:27:42 +0100
Subject: [PATCH v4 35/40] ARM: mm: tlb-v3: Use the new processor struct macros
In-Reply-To: <1310048867-14172-1-git-send-email-dave.martin@linaro.org>
References: <1310048867-14172-1-git-send-email-dave.martin@linaro.org>
Message-ID: <1310048867-14172-36-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 arch/arm/mm/tlb-v3.S |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mm/tlb-v3.S b/arch/arm/mm/tlb-v3.S
index c10786e..d253995 100644
--- a/arch/arm/mm/tlb-v3.S
+++ b/arch/arm/mm/tlb-v3.S
@@ -44,9 +44,5 @@ ENTRY(v3_flush_kern_tlb_range)
 
 	__INITDATA
 
-	.type	v3_tlb_fns, #object
-ENTRY(v3_tlb_fns)
-	.long	v3_flush_user_tlb_range
-	.long	v3_flush_kern_tlb_range
-	.long	v3_tlb_flags
-	.size	v3_tlb_fns, . - v3_tlb_fns
+	/* define struct cpu_tlb_fns (see <asm/tlbflush.h> and proc-macros.S) */
+	define_tlb_functions v3, v3_tlb_flags
-- 
1.7.4.1
