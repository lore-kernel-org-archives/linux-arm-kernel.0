From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu,  7 Dec 2017 18:06:12 +0100
Subject: [PATCH v2 18/36] KVM: arm/arm64: Remove leftover comment from
 kvm_vcpu_run_vhe
In-Reply-To: <20171207170630.592-1-christoffer.dall@linaro.org>
References: <20171207170630.592-1-christoffer.dall@linaro.org>
Message-ID: <20171207170630.592-19-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The comment only applied to SPE on non-VHE systems, so we simply remove
it.

Suggested-by: Andrew Jones <drjones@redhat.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm64/kvm/hyp/switch.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
index 13c990c6eb64..9e5bc490ef0f 100644
--- a/arch/arm64/kvm/hyp/switch.c
+++ b/arch/arm64/kvm/hyp/switch.c
@@ -382,10 +382,6 @@ int kvm_vcpu_run_vhe(struct kvm_vcpu *vcpu)
 
 	sysreg_restore_host_state_vhe(host_ctxt);
 
-	/*
-	 * This must come after restoring the host sysregs, since a non-VHE
-	 * system may enable SPE here and make use of the TTBRs.
-	 */
 	__debug_switch_to_host(vcpu);
 
 	return exit_code;
-- 
2.14.2
