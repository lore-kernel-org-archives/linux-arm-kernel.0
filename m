From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Tue, 29 May 2018 15:55:18 +0100
Subject: [PATCH v5 13/15] ARM: spectre-v2: KVM: invalidate icache on guest
 exit for Brahma B15
In-Reply-To: <20180529145320.GJ17671@n2100.armlinux.org.uk>
References: <20180529145320.GJ17671@n2100.armlinux.org.uk>
Message-ID: <E1fNg1u-0005BA-3z@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Include Brahma B15 in the Spectre v2 KVM workarounds.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
Boot-tested-by: Tony Lindgren <tony@atomide.com>
Reviewed-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/include/asm/kvm_mmu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
index 48edb1f4ced4..fea770f78144 100644
--- a/arch/arm/include/asm/kvm_mmu.h
+++ b/arch/arm/include/asm/kvm_mmu.h
@@ -306,6 +306,7 @@ static inline void *kvm_get_hyp_vector(void)
 		return kvm_ksym_ref(__kvm_hyp_vector_bp_inv);
 	}
 
+	case ARM_CPU_PART_BRAHMA_B15:
 	case ARM_CPU_PART_CORTEX_A15:
 	{
 		extern char __kvm_hyp_vector_ic_inv[];
-- 
2.7.4
