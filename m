From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu,  1 Mar 2018 19:14:06 +0000
Subject: [PATCH] KVM: arm/arm64: drop pr_info() of IDMAP page
Message-ID: <20180301191406.18083-1-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The KVM IDMAP is a mapping of a statically allocated kernel structure,
and so printing its physical address leaks the physical placement of
the kernel when physical KASLR is in effect. Just remove it, nobody
except Marc needs this anyway.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
CC -stable?

 virt/kvm/arm/mmu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
index ec62d1cccab7..c07f88cb6dcf 100644
--- a/virt/kvm/arm/mmu.c
+++ b/virt/kvm/arm/mmu.c
@@ -1810,7 +1810,6 @@ int kvm_mmu_init(void)
 	 */
 	BUG_ON((hyp_idmap_start ^ (hyp_idmap_end - 1)) & PAGE_MASK);
 
-	kvm_info("IDMAP page: %lx\n", hyp_idmap_start);
 	kvm_info("HYP VA range: %lx:%lx\n",
 		 kern_hyp_va(PAGE_OFFSET), kern_hyp_va(~0UL));
 
-- 
2.11.0
