From: joe@perches.com (Joe Perches)
Date: Wed,  5 Jul 2017 13:02:11 -0700
Subject: [PATCH 02/18] ARM: KVM: Move asmlinkage before type
In-Reply-To: <cover.1499284835.git.joe@perches.com>
References: <cover.1499284835.git.joe@perches.com>
Message-ID: <005b8e120650c6a13b541e420f4e3605603fe9e6.1499284835.git.joe@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

asmlinkage is either 'extern "C"' or blank.

Move the uses of asmlinkage before the return types to be similar
to the rest of the kernel.

Signed-off-by: Joe Perches <joe@perches.com>
---
 arch/arm/include/asm/kvm_hyp.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/kvm_hyp.h b/arch/arm/include/asm/kvm_hyp.h
index 58508900c4bb..14b5903f0224 100644
--- a/arch/arm/include/asm/kvm_hyp.h
+++ b/arch/arm/include/asm/kvm_hyp.h
@@ -110,8 +110,8 @@ void __sysreg_restore_state(struct kvm_cpu_context *ctxt);
 void __vgic_v3_save_state(struct kvm_vcpu *vcpu);
 void __vgic_v3_restore_state(struct kvm_vcpu *vcpu);
 
-void asmlinkage __vfp_save_state(struct vfp_hard_struct *vfp);
-void asmlinkage __vfp_restore_state(struct vfp_hard_struct *vfp);
+asmlinkage void __vfp_save_state(struct vfp_hard_struct *vfp);
+asmlinkage void __vfp_restore_state(struct vfp_hard_struct *vfp);
 static inline bool __vfp_enabled(void)
 {
 	return !(read_sysreg(HCPTR) & (HCPTR_TCP(11) | HCPTR_TCP(10)));
@@ -120,8 +120,8 @@ static inline bool __vfp_enabled(void)
 void __hyp_text __banked_save_state(struct kvm_cpu_context *ctxt);
 void __hyp_text __banked_restore_state(struct kvm_cpu_context *ctxt);
 
-int asmlinkage __guest_enter(struct kvm_vcpu *vcpu,
+asmlinkage int __guest_enter(struct kvm_vcpu *vcpu,
 			     struct kvm_cpu_context *host);
-int asmlinkage __hyp_do_panic(const char *, int, u32);
+asmlinkage int __hyp_do_panic(const char *, int, u32);
 
 #endif /* __ARM_KVM_HYP_H__ */
-- 
2.10.0.rc2.1.g053435c
