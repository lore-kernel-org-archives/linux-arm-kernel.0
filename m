From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue,  7 Jun 2016 11:58:24 +0100
Subject: [PATCH 04/15] arm64: KVM: Define HYP offset masks
In-Reply-To: <1465297115-13091-1-git-send-email-marc.zyngier@arm.com>
References: <1465297115-13091-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1465297115-13091-5-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define the two possible HYP VA regions in terms of VA_BITS,
and keep HYP_PAGE_OFFSET_MASK as a temporary compatibility
definition.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/include/asm/kvm_mmu.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index d162372..e45df1b 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -73,8 +73,12 @@
  * Thankfully, ARMv8.1 (using VHE) does have a TTBR1_EL2, and doesn't
  * need any of this madness (the entire kernel runs at EL2).
  */
-#define HYP_PAGE_OFFSET_SHIFT	VA_BITS
-#define HYP_PAGE_OFFSET_MASK	((UL(1) << HYP_PAGE_OFFSET_SHIFT) - 1)
+
+#define HYP_PAGE_OFFSET_HIGH_MASK	((UL(1) << VA_BITS) - 1)
+#define HYP_PAGE_OFFSET_LOW_MASK	((UL(1) << (VA_BITS - 1)) - 1)
+
+/* Temporary compat define */
+#define HYP_PAGE_OFFSET_MASK		HYP_PAGE_OFFSET_HIGH_MASK
 
 /*
  * Our virtual mapping for the idmap-ed MMU-enable code. Must be
-- 
2.1.4
