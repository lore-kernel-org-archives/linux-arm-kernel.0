From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 30 Apr 2014 04:15:52 -0700
Subject: [PATCH 1/5] ARM: KVM: disable KVM in Kconfig on big-endian systems
In-Reply-To: <1398856556-13199-1-git-send-email-christoffer.dall@linaro.org>
References: <1398856556-13199-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1398856556-13199-2-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Will Deacon <will.deacon@arm.com>

KVM currently crashes and burns on big-endian hosts, so don't allow it
to be selected until we've got that fixed.

Cc: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm/kvm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kvm/Kconfig b/arch/arm/kvm/Kconfig
index 466bd29..4be5bb1 100644
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
1.8.5.2
