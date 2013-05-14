From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 14 May 2013 12:11:35 +0100
Subject: [PATCH v3 2/7] ARM: KVM: remove dead prototype for
 __kvm_tlb_flush_vmid
In-Reply-To: <1368529900-22572-1-git-send-email-marc.zyngier@arm.com>
References: <1368529900-22572-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1368529900-22572-3-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

__kvm_tlb_flush_vmid has been renamed to __kvm_tlb_flush_vmid_ipa,
and the old prototype should have been removed when the code was
modified.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/kvm_asm.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/include/asm/kvm_asm.h b/arch/arm/include/asm/kvm_asm.h
index 18d5032..6ae3d2a 100644
--- a/arch/arm/include/asm/kvm_asm.h
+++ b/arch/arm/include/asm/kvm_asm.h
@@ -72,8 +72,6 @@ extern char __kvm_hyp_vector[];
 extern char __kvm_hyp_code_start[];
 extern char __kvm_hyp_code_end[];
 
-extern void __kvm_tlb_flush_vmid(struct kvm *kvm);
-
 extern void __kvm_flush_vm_context(void);
 extern void __kvm_tlb_flush_vmid_ipa(struct kvm *kvm, phys_addr_t ipa);
 
-- 
1.8.2.3
