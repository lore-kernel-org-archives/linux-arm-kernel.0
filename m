From: gustavo@embeddedor.com (Gustavo A. R. Silva)
Date: Tue, 7 Aug 2018 19:04:40 -0500
Subject: [PATCH] KVM: arm: Use true and false for boolean values
Message-ID: <20180808000440.GA7202@embeddedor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Return statements in functions returning bool should use true or false
instead of an integer value.

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 arch/arm/include/asm/kvm_emulate.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/kvm_emulate.h b/arch/arm/include/asm/kvm_emulate.h
index b0517ad..77121b7 100644
--- a/arch/arm/include/asm/kvm_emulate.h
+++ b/arch/arm/include/asm/kvm_emulate.h
@@ -119,7 +119,7 @@ static inline void vcpu_set_wfe_traps(struct kvm_vcpu *vcpu)
 
 static inline bool vcpu_mode_is_32bit(const struct kvm_vcpu *vcpu)
 {
-	return 1;
+	return true;
 }
 
 static inline unsigned long *vcpu_pc(struct kvm_vcpu *vcpu)
-- 
2.7.4
