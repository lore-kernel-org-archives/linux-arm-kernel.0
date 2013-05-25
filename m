From: cdall@cs.columbia.edu (Christoffer Dall)
Date: Fri, 24 May 2013 18:12:39 -0700
Subject: [PATCH v2] ARM: mm: Get rid of L_PTE_USER ref from PAGE_S2_DEVICE
Message-ID: <1369444359-28962-1-git-send-email-cdall@cs.columbia.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

THe L_PTE_USER actually has nothing to do with stage 2 mappings and the
L_PTE_S2_RDWR value sets the readable bit, which was what L_PTE_USER
was used for before proper handling of stage 2 memory defines.

Changelog:
 [v2]: Change default mappings to be r/w instead of r/o, as per Marc
       Zyngier's suggestion.

Cc: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <cdall@cs.columbia.edu>
---
 arch/arm/include/asm/pgtable.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index 9bcd262..8afc60c 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -97,7 +97,7 @@ extern pgprot_t		pgprot_s2_device;
 #define PAGE_HYP		_MOD_PROT(pgprot_kernel, L_PTE_HYP)
 #define PAGE_HYP_DEVICE		_MOD_PROT(pgprot_hyp_device, L_PTE_HYP)
 #define PAGE_S2			_MOD_PROT(pgprot_s2, L_PTE_S2_RDONLY)
-#define PAGE_S2_DEVICE		_MOD_PROT(pgprot_s2_device, L_PTE_USER | L_PTE_S2_RDONLY)
+#define PAGE_S2_DEVICE		_MOD_PROT(pgprot_s2_device, L_PTE_S2_RDWR)
 
 #define __PAGE_NONE		__pgprot(_L_PTE_DEFAULT | L_PTE_RDONLY | L_PTE_XN | L_PTE_NONE)
 #define __PAGE_SHARED		__pgprot(_L_PTE_DEFAULT | L_PTE_USER | L_PTE_XN)
-- 
1.7.9.5
