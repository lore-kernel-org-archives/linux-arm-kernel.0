From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 19 Jun 2015 13:53:05 +0100
Subject: [PATCH 01/12] ARM: KVM: Remove pointless void pointer cast
In-Reply-To: <1434718396-13110-1-git-send-email-marc.zyngier@arm.com>
References: <1434718396-13110-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1434718396-13110-2-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Firo Yang <firogm@gmail.com>

No need to cast the void pointer returned by kmalloc() in
arch/arm/kvm/mmu.c::kvm_alloc_stage2_pgd().

Signed-off-by: Firo Yang <firogm@gmail.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/kvm/mmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index 1d5accb..ce0bce4 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -691,8 +691,8 @@ int kvm_alloc_stage2_pgd(struct kvm *kvm)
 		 * work.  This is not used by the hardware and we have no
 		 * alignment requirement for this allocation.
 		 */
-		pgd = (pgd_t *)kmalloc(PTRS_PER_S2_PGD * sizeof(pgd_t),
-				       GFP_KERNEL | __GFP_ZERO);
+		pgd = kmalloc(PTRS_PER_S2_PGD * sizeof(pgd_t),
+				GFP_KERNEL | __GFP_ZERO);
 
 		if (!pgd) {
 			kvm_free_hwpgd(hwpgd);
-- 
2.1.4
