From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu,  9 Mar 2017 09:55:38 +0000
Subject: [PATCH 09/10] KVM: arm/arm64: Remove KVM_PRIVATE_MEM_SLOTS definition
 that are unused
In-Reply-To: <20170309095539.14512-1-marc.zyngier@arm.com>
References: <20170309095539.14512-1-marc.zyngier@arm.com>
Message-ID: <20170309095539.14512-10-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linu Cherian <linu.cherian@cavium.com>

arm/arm64 architecture doesnt use private memslots, hence removing
KVM_PRIVATE_MEM_SLOTS macro definition.

Reviewed-by: Christoffer Dall <cdall@linaro.org>
Signed-off-by: Linu Cherian <linu.cherian@cavium.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/kvm_host.h   | 1 -
 arch/arm64/include/asm/kvm_host.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index cc495d799c67..31ee468ce667 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -30,7 +30,6 @@
 #define __KVM_HAVE_ARCH_INTC_INITIALIZED
 
 #define KVM_USER_MEM_SLOTS 32
-#define KVM_PRIVATE_MEM_SLOTS 4
 #define KVM_COALESCED_MMIO_PAGE_OFFSET 1
 #define KVM_HAVE_ONE_REG
 #define KVM_HALT_POLL_NS_DEFAULT 500000
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index f21fd3894370..6ac17ee887c9 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -31,7 +31,6 @@
 #define __KVM_HAVE_ARCH_INTC_INITIALIZED
 
 #define KVM_USER_MEM_SLOTS 32
-#define KVM_PRIVATE_MEM_SLOTS 4
 #define KVM_COALESCED_MMIO_PAGE_OFFSET 1
 #define KVM_HALT_POLL_NS_DEFAULT 500000
 
-- 
2.11.0
