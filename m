From: victor.kamensky@linaro.org (Victor Kamensky)
Date: Thu, 12 Jun 2014 09:30:07 -0700
Subject: [PATCH v4 08/14] ARM: KVM: enable KVM in Kconfig on big-endian systems
In-Reply-To: <1402590613-3341-1-git-send-email-victor.kamensky@linaro.org>
References: <1402590613-3341-1-git-send-email-victor.kamensky@linaro.org>
Message-ID: <1402590613-3341-9-git-send-email-victor.kamensky@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Previous patches addresses ARMV7 big-endian virtualiztion,
kvm related issues, so enable ARM_VIRT_EXT for big-endian
now.

Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
---
 arch/arm/kvm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kvm/Kconfig b/arch/arm/kvm/Kconfig
index 4be5bb1..466bd29 100644
--- a/arch/arm/kvm/Kconfig
+++ b/arch/arm/kvm/Kconfig
@@ -23,7 +23,7 @@ config KVM
 	select HAVE_KVM_CPU_RELAX_INTERCEPT
 	select KVM_MMIO
 	select KVM_ARM_HOST
-	depends on ARM_VIRT_EXT && ARM_LPAE && !CPU_BIG_ENDIAN
+	depends on ARM_VIRT_EXT && ARM_LPAE
 	---help---
 	  Support hosting virtualized guest machines. You will also
 	  need to select one or more of the processor modules below.
-- 
1.8.1.4
