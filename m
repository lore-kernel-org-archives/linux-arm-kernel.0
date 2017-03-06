From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon,  6 Mar 2017 14:24:53 +0000
Subject: [PATCH v3 20/25] arm/arm64: KVM: Remove kvm_get_idmap_start
In-Reply-To: <20170306142458.8875-1-marc.zyngier@arm.com>
References: <20170306142458.8875-1-marc.zyngier@arm.com>
Message-ID: <20170306142458.8875-21-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With __cpu_reset_hyp_mode having become fairly dumb, there is no
need for kvm_get_idmap_start anymore.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/kvm_mmu.h   | 1 -
 arch/arm/kvm/mmu.c               | 5 -----
 arch/arm64/include/asm/kvm_mmu.h | 1 -
 3 files changed, 7 deletions(-)

diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
index 95f38dcd611d..fa6f2174276b 100644
--- a/arch/arm/include/asm/kvm_mmu.h
+++ b/arch/arm/include/asm/kvm_mmu.h
@@ -56,7 +56,6 @@ void kvm_mmu_free_memory_caches(struct kvm_vcpu *vcpu);
 
 phys_addr_t kvm_mmu_get_httbr(void);
 phys_addr_t kvm_get_idmap_vector(void);
-phys_addr_t kvm_get_idmap_start(void);
 int kvm_mmu_init(void);
 void kvm_clear_hyp_idmap(void);
 
diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index 962616fd4ddd..59f555b64dec 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -1674,11 +1674,6 @@ phys_addr_t kvm_get_idmap_vector(void)
 	return hyp_idmap_vector;
 }
 
-phys_addr_t kvm_get_idmap_start(void)
-{
-	return hyp_idmap_start;
-}
-
 static int kvm_map_idmap_text(pgd_t *pgd)
 {
 	int err;
diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index ed1246014901..91d93a5d8fd3 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -155,7 +155,6 @@ void kvm_mmu_free_memory_caches(struct kvm_vcpu *vcpu);
 
 phys_addr_t kvm_mmu_get_httbr(void);
 phys_addr_t kvm_get_idmap_vector(void);
-phys_addr_t kvm_get_idmap_start(void);
 int kvm_mmu_init(void);
 void kvm_clear_hyp_idmap(void);
 
-- 
2.11.0
