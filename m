From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 31 Jan 2018 10:34:56 +0100
Subject: [PULL 17/28] arm64: KVM: PTE/PMD S2 XN bit definition
In-Reply-To: <20180131093507.22219-1-christoffer.dall@linaro.org>
References: <20180131093507.22219-1-christoffer.dall@linaro.org>
Message-ID: <20180131093507.22219-18-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

As we're about to make S2 page-tables eXecute Never by default,
add the required bits for both PMDs and PTEs.

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm64/include/asm/pgtable-hwdef.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
index eb0c2bd90de9..af035331fb09 100644
--- a/arch/arm64/include/asm/pgtable-hwdef.h
+++ b/arch/arm64/include/asm/pgtable-hwdef.h
@@ -177,9 +177,11 @@
  */
 #define PTE_S2_RDONLY		(_AT(pteval_t, 1) << 6)   /* HAP[2:1] */
 #define PTE_S2_RDWR		(_AT(pteval_t, 3) << 6)   /* HAP[2:1] */
+#define PTE_S2_XN		(_AT(pteval_t, 2) << 53)  /* XN[1:0] */
 
 #define PMD_S2_RDONLY		(_AT(pmdval_t, 1) << 6)   /* HAP[2:1] */
 #define PMD_S2_RDWR		(_AT(pmdval_t, 3) << 6)   /* HAP[2:1] */
+#define PMD_S2_XN		(_AT(pmdval_t, 2) << 53)  /* XN[1:0] */
 
 /*
  * Memory Attribute override for Stage-2 (MemAttr[3:0])
-- 
2.14.2
