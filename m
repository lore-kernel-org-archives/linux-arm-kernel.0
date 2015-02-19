From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 19 Feb 2015 10:54:46 +0000
Subject: [RFC/RFT PATCH 3/3] arm64: KVM: keep trapping of VM sysreg writes
 enabled
In-Reply-To: <1424343286-6792-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1424343286-6792-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1424343286-6792-4-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

---
 arch/arm/kvm/mmu.c               | 2 +-
 arch/arm64/include/asm/kvm_arm.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index 136662547ca6..fa8ec55220ea 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -1530,7 +1530,7 @@ void kvm_toggle_cache(struct kvm_vcpu *vcpu, bool was_enabled)
 		stage2_flush_vm(vcpu->kvm);
 
 	/* Caches are now on, stop trapping VM ops (until a S/W op) */
-	if (now_enabled)
+	if (0)//now_enabled)
 		vcpu_set_hcr(vcpu, vcpu_get_hcr(vcpu) & ~HCR_TVM);
 
 	trace_kvm_toggle_cache(*vcpu_pc(vcpu), was_enabled, now_enabled);
diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
index 8afb863f5a9e..437e1ec17539 100644
--- a/arch/arm64/include/asm/kvm_arm.h
+++ b/arch/arm64/include/asm/kvm_arm.h
@@ -75,7 +75,7 @@
  * FMO:		Override CPSR.F and enable signaling with VF
  * SWIO:	Turn set/way invalidates into set/way clean+invalidate
  */
-#define HCR_GUEST_FLAGS (HCR_TSC | HCR_TSW | HCR_TWE | HCR_TWI | HCR_VM | \
+#define HCR_GUEST_FLAGS (HCR_TSC | /* HCR_TSW | */ HCR_TWE | HCR_TWI | HCR_VM | \
 			 HCR_TVM | HCR_BSU_IS | HCR_FB | HCR_TAC | \
 			 HCR_AMO | HCR_SWIO | HCR_TIDCP | HCR_RW)
 #define HCR_VIRT_EXCP_MASK (HCR_VA | HCR_VI | HCR_VF)
-- 
1.8.3.2
