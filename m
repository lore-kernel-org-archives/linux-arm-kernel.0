From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 23 Oct 2017 17:11:18 +0100
Subject: [PATCH v3 5/9] arm64: KVM: PTE/PMD S2 XN bit definition
In-Reply-To: <20171023161122.15291-1-marc.zyngier@arm.com>
References: <20171023161122.15291-1-marc.zyngier@arm.com>
Message-ID: <20171023161122.15291-6-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As we're about to make S2 page-tables eXecute Never by default,
add the required bits for both PMDs and PTEs.

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
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
2.11.0
