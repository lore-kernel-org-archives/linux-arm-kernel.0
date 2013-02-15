From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 15 Feb 2013 19:20:07 +0000
Subject: [PATCH 3.9-rc1 2/3] ARM: KVM: Rename KVM_MEMORY_SLOTS ->
 KVM_USER_MEM_SLOTS
In-Reply-To: <1360956008-5925-1-git-send-email-marc.zyngier@arm.com>
References: <1360956008-5925-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1360956008-5925-3-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit bbacc0c (KVM: Rename KVM_MEMORY_SLOTS -> KVM_USER_MEM_SLOTS)
broke KVM/ARM by changing a global #define.

Apply the same change to fix the compilation breakage.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/kvm_host.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index dfe9886..d1736a5 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -26,7 +26,7 @@
 #include <asm/kvm_arch_timer.h>
 
 #define KVM_MAX_VCPUS CONFIG_KVM_ARM_MAX_VCPUS
-#define KVM_MEMORY_SLOTS 32
+#define KVM_USER_MEM_SLOTS 32
 #define KVM_PRIVATE_MEM_SLOTS 4
 #define KVM_COALESCED_MMIO_PAGE_OFFSET 1
 #define KVM_HAVE_ONE_REG
-- 
1.8.1.2
