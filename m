From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu,  9 Mar 2017 09:55:39 +0000
Subject: [PATCH 10/10] KVM: arm64: Increase number of user memslots to 512
In-Reply-To: <20170309095539.14512-1-marc.zyngier@arm.com>
References: <20170309095539.14512-1-marc.zyngier@arm.com>
Message-ID: <20170309095539.14512-11-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linu Cherian <linu.cherian@cavium.com>

Having only 32 memslots is a real constraint for the maximum
number of PCI devices that can be assigned to a single guest.
Assuming each PCI device/virtual function having two memory BAR
regions, we could assign only 15 devices/virtual functions to a
guest.

Hence increase KVM_USER_MEM_SLOTS to 512 as done in other archs like
powerpc.

Reviewed-by: Christoffer Dall <cdall@linaro.org>
Signed-off-by: Linu Cherian <linu.cherian@cavium.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/include/asm/kvm_host.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 6ac17ee887c9..e7705e7bb07b 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -30,7 +30,7 @@
 
 #define __KVM_HAVE_ARCH_INTC_INITIALIZED
 
-#define KVM_USER_MEM_SLOTS 32
+#define KVM_USER_MEM_SLOTS 512
 #define KVM_COALESCED_MMIO_PAGE_OFFSET 1
 #define KVM_HALT_POLL_NS_DEFAULT 500000
 
-- 
2.11.0
