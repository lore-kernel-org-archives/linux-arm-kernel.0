From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Fri, 25 May 2018 15:01:29 +0100
Subject: [PATCH v3 13/15] ARM: spectre-v2: KVM: invalidate icache on guest
 exit for Brahma B15
In-Reply-To: <20180525135938.GE17671@n2100.armlinux.org.uk>
References: <20180525135938.GE17671@n2100.armlinux.org.uk>
Message-ID: <E1fMDHd-00073z-Bg@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Include Brahma B15 in the Spectre v2 KVM workarounds.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
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
