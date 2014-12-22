From: van.freenix@gmail.com (Peng Fan)
Date: Mon, 22 Dec 2014 19:23:18 +0800
Subject: [PATCH 1/2] arm:kvm correct prototype to make sparse happy
Message-ID: <1419247399-26113-1-git-send-email-van.freenix@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Warning message:
arch/arm/kvm/arm.c:85:17:
error: symbol 'kvm_get_running_vcpus' redeclared with different type
(originally declared at ./arch/arm/include/asm/kvm_host.h :190) -
different address spaces

Signed-off-by: Peng Fan <van.freenix@gmail.com>
CC: Gleb Natapov <gleb@kernel.org>
CC: Paolo Bonzini <pbonzini@redhat.com>
CC: Christoffer Dall <christoffer.dall@linaro.org>
CC: Marc Zyngier <marc.zyngier@arm.com>
CC: Russell King <linux@arm.linux.org.uk>
---
 arch/arm/include/asm/kvm_host.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index 53036e2..219d025 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -187,7 +187,7 @@ static inline void kvm_arch_mmu_notifier_invalidate_page(struct kvm *kvm,
 }
 
 struct kvm_vcpu *kvm_arm_get_running_vcpu(void);
-struct kvm_vcpu __percpu **kvm_get_running_vcpus(void);
+struct kvm_vcpu * __percpu *kvm_get_running_vcpus(void);
 
 int kvm_arm_copy_coproc_indices(struct kvm_vcpu *vcpu, u64 __user *uindices);
 unsigned long kvm_arm_num_coproc_regs(struct kvm_vcpu *vcpu);
-- 
1.8.4
