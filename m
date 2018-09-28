From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 28 Sep 2018 14:39:06 +0100
Subject: [RFC PATCH v2 02/23] KVM: arm64: Delete orphaned declaration for
 __fpsimd_enabled()
In-Reply-To: <1538141967-15375-1-git-send-email-Dave.Martin@arm.com>
References: <1538141967-15375-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1538141967-15375-3-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

__fpsimd_enabled() no longer exists, but a dangling declaration has
survived in kvm_hyp.h.

This patch gets rid of it.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Reviewed-by: Alex Benn?e <alex.bennee@linaro.org>
---
 arch/arm64/include/asm/kvm_hyp.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/include/asm/kvm_hyp.h b/arch/arm64/include/asm/kvm_hyp.h
index 384c343..9cbbd03 100644
--- a/arch/arm64/include/asm/kvm_hyp.h
+++ b/arch/arm64/include/asm/kvm_hyp.h
@@ -147,7 +147,6 @@ void __debug_switch_to_host(struct kvm_vcpu *vcpu);
 
 void __fpsimd_save_state(struct user_fpsimd_state *fp_regs);
 void __fpsimd_restore_state(struct user_fpsimd_state *fp_regs);
-bool __fpsimd_enabled(void);
 
 void activate_traps_vhe_load(struct kvm_vcpu *vcpu);
 void deactivate_traps_vhe_put(void);
-- 
2.1.4
