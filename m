From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 15 Oct 2013 17:49:29 -0700
Subject: [PATCH 1/9] KVM: ARM: Fix typo in comments of inject_abt()
In-Reply-To: <1381884577-24747-1-git-send-email-christoffer.dall@linaro.org>
References: <1381884577-24747-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1381884577-24747-2-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Anup Patel <anup.patel@linaro.org>

Very minor typo in comments of inject_abt() when we update fault status
register for injecting prefetch abort.

Signed-off-by: Anup Patel <anup.patel@linaro.org>
Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm/kvm/emulate.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kvm/emulate.c b/arch/arm/kvm/emulate.c
index bdede9e..d6c0052 100644
--- a/arch/arm/kvm/emulate.c
+++ b/arch/arm/kvm/emulate.c
@@ -354,7 +354,7 @@ static void inject_abt(struct kvm_vcpu *vcpu, bool is_pabt, unsigned long addr)
 	*vcpu_pc(vcpu) = exc_vector_base(vcpu) + vect_offset;
 
 	if (is_pabt) {
-		/* Set DFAR and DFSR */
+		/* Set IFAR and IFSR */
 		vcpu->arch.cp15[c6_IFAR] = addr;
 		is_lpae = (vcpu->arch.cp15[c2_TTBCR] >> 31);
 		/* Always give debug fault for now - should give guest a clue */
-- 
1.7.10.4
