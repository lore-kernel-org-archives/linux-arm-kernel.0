From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 13 Aug 2018 15:57:53 +0100
Subject: [PATCH 35/37] KVM: arm: Use true and false for boolean values
In-Reply-To: <20180813145755.16566-1-marc.zyngier@arm.com>
References: <20180813145755.16566-1-marc.zyngier@arm.com>
Message-ID: <20180813145755.16566-36-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>

Return statements in functions returning bool should use true or false
instead of an integer value.

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/kvm_emulate.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/kvm_emulate.h b/arch/arm/include/asm/kvm_emulate.h
index b50fe8380868..2b7eed21b20e 100644
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
2.18.0
