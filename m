From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 28 Mar 2018 13:52:02 +0100
Subject: [PATCH 33/85] KVM: arm/arm64: Remove leftover comment from
 kvm_vcpu_run_vhe
In-Reply-To: <20180328125254.31380-1-marc.zyngier@arm.com>
References: <20180328125254.31380-1-marc.zyngier@arm.com>
Message-ID: <20180328125254.31380-34-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Christoffer Dall <christoffer.dall@linaro.org>

The comment only applied to SPE on non-VHE systems, so we simply remove
it.

Suggested-by: Andrew Jones <drjones@redhat.com>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Reviewed-by: Andrew Jones <drjones@redhat.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/kvm/hyp/switch.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
index d60d3a018882..fd845dda007a 100644
--- a/arch/arm64/kvm/hyp/switch.c
+++ b/arch/arm64/kvm/hyp/switch.c
@@ -410,10 +410,6 @@ int kvm_vcpu_run_vhe(struct kvm_vcpu *vcpu)
 		__fpsimd_restore_state(&host_ctxt->gp_regs.fp_regs);
 	}
 
-	/*
-	 * This must come after restoring the host sysregs, since a non-VHE
-	 * system may enable SPE here and make use of the TTBRs.
-	 */
 	__debug_switch_to_host(vcpu);
 
 	return exit_code;
-- 
2.14.2
