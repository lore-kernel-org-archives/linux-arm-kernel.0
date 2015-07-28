From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Tue, 28 Jul 2015 10:42:23 +0100
Subject: [PATCH] arm64: KVM: remove remaining reference to vgic_sr_vectors
Message-ID: <1438076543-6768-1-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since commit 8a14849 (arm64: KVM: Switch vgic save/restore to
alternative_insn) vgic_sr_vectors is not used anymore, so remove
remaining leftovers and kill the structure.

Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 arch/arm64/include/asm/kvm_host.h |    5 -----
 arch/arm64/kernel/asm-offsets.c   |    2 --
 2 files changed, 7 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 2709db2..19f1182 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -216,11 +216,6 @@ static inline void __cpu_init_hyp_mode(phys_addr_t boot_pgd_ptr,
 		     hyp_stack_ptr, vector_ptr);
 }
 
-struct vgic_sr_vectors {
-	void	*save_vgic;
-	void	*restore_vgic;
-};
-
 static inline void kvm_arch_hardware_disable(void) {}
 static inline void kvm_arch_hardware_unsetup(void) {}
 static inline void kvm_arch_sync_events(struct kvm *kvm) {}
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index c99701a..f0c960d 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -125,8 +125,6 @@ int main(void)
   DEFINE(KVM_TIMER_ENABLED,	offsetof(struct kvm, arch.timer.enabled));
   DEFINE(VCPU_KVM,		offsetof(struct kvm_vcpu, kvm));
   DEFINE(VCPU_VGIC_CPU,		offsetof(struct kvm_vcpu, arch.vgic_cpu));
-  DEFINE(VGIC_SAVE_FN,		offsetof(struct vgic_sr_vectors, save_vgic));
-  DEFINE(VGIC_RESTORE_FN,	offsetof(struct vgic_sr_vectors, restore_vgic));
   DEFINE(VGIC_V2_CPU_HCR,	offsetof(struct vgic_cpu, vgic_v2.vgic_hcr));
   DEFINE(VGIC_V2_CPU_VMCR,	offsetof(struct vgic_cpu, vgic_v2.vgic_vmcr));
   DEFINE(VGIC_V2_CPU_MISR,	offsetof(struct vgic_cpu, vgic_v2.vgic_misr));
-- 
1.7.9.5
