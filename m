From: mark.rutland@arm.com (Mark Rutland)
Date: Fri,  2 Jun 2017 12:02:20 +0100
Subject: [PATCH] arm64/kvm: fix misleading kconfig text for 16K pages
Message-ID: <1496401340-24802-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We've supported KVM with 16K pages since commit:

  02e0b7600f835007 ("arm64: kvm: Add support for 16K pages")

... yet the kconfig text says this combination is not supported.

Let's fix that by deleting the misleading text.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Cc: Christoffer Dall <christoffer.dall@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: kvmarm at lists.cs.columbia.edu
---
 arch/arm64/kvm/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
index 52cb7ad..6e4e461 100644
--- a/arch/arm64/kvm/Kconfig
+++ b/arch/arm64/kvm/Kconfig
@@ -37,8 +37,6 @@ config KVM
 	select HAVE_KVM_IRQ_ROUTING
 	---help---
 	  Support hosting virtualized guest machines.
-	  We don't support KVM with 16K page tables yet, due to the multiple
-	  levels of fake page tables.
 
 	  If unsure, say N.
 
-- 
1.9.1
