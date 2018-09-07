From: christoffer.dall@arm.com (Christoffer Dall)
Date: Fri,  7 Sep 2018 15:12:56 +0200
Subject: [PULL RESEND v2 4/4] arm64: KVM: Remove pgd_lock
In-Reply-To: <20180907131256.2412-1-christoffer.dall@arm.com>
References: <20180907131256.2412-1-christoffer.dall@arm.com>
Message-ID: <20180907131256.2412-5-christoffer.dall@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Steven Price <steven.price@arm.com>

The lock has never been used and the page tables are protected by
mmu_lock in struct kvm.

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Steven Price <steven.price@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@arm.com>
---
 arch/arm64/include/asm/kvm_host.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 8e6d46df38aa..3d6d7336f871 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -61,8 +61,7 @@ struct kvm_arch {
 	u64    vmid_gen;
 	u32    vmid;
 
-	/* 1-level 2nd stage table and lock */
-	spinlock_t pgd_lock;
+	/* 1-level 2nd stage table, protected by kvm->mmu_lock */
 	pgd_t *pgd;
 
 	/* VTTBR value associated with above pgd and vmid */
-- 
2.18.0
