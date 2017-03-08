From: linucherian@gmail.com (linucherian at gmail.com)
Date: Wed,  8 Mar 2017 11:38:35 +0530
Subject: [PATCH v4 4/4] KVM: arm64: Increase number of user memslots to 512
In-Reply-To: <1488953315-22375-1-git-send-email-linucherian@gmail.com>
References: <1488953315-22375-1-git-send-email-linucherian@gmail.com>
Message-ID: <1488953315-22375-5-git-send-email-linucherian@gmail.com>
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

Signed-off-by: Linu Cherian <linu.cherian@cavium.com>
---
 arch/arm64/include/asm/kvm_host.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index a0409b0..4027002 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -30,7 +30,7 @@
 
 #define __KVM_HAVE_ARCH_INTC_INITIALIZED
 
-#define KVM_USER_MEM_SLOTS 32
+#define KVM_USER_MEM_SLOTS 512
 #define KVM_COALESCED_MMIO_PAGE_OFFSET 1
 #define KVM_HALT_POLL_NS_DEFAULT 500000
 
-- 
1.9.1
