From: will.deacon@arm.com (Will Deacon)
Date: Fri, 25 Apr 2014 11:46:04 +0100
Subject: [PATCH] ARM: KVM: disable KVM in Kconfig on big-endian systems
Message-ID: <1398422764-29351-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

KVM currently crashes and burns on big-endian hosts, so don't allow it
to be selected until we've got that fixed.

Cc: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kvm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kvm/Kconfig b/arch/arm/kvm/Kconfig
index 466bd299b1a8..4be5bb150bdd 100644
--- a/arch/arm/kvm/Kconfig
+++ b/arch/arm/kvm/Kconfig
@@ -23,7 +23,7 @@ config KVM
 	select HAVE_KVM_CPU_RELAX_INTERCEPT
 	select KVM_MMIO
 	select KVM_ARM_HOST
-	depends on ARM_VIRT_EXT && ARM_LPAE
+	depends on ARM_VIRT_EXT && ARM_LPAE && !CPU_BIG_ENDIAN
 	---help---
 	  Support hosting virtualized guest machines. You will also
 	  need to select one or more of the processor modules below.
-- 
1.9.2
