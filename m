From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 27 Sep 2016 20:05:28 +0200
Subject: [PULL 20/50] arm64: KVM: Add exception code to report EL1
 asynchronous aborts
In-Reply-To: <20160927180558.14699-1-christoffer.dall@linaro.org>
References: <20160927180558.14699-1-christoffer.dall@linaro.org>
Message-ID: <20160927180558.14699-21-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

So far, we don't have a code to indicate that we've taken an
asynchronous abort from EL1. Let's add one.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm64/include/asm/kvm_asm.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index 7561f63..d177e7e 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -21,9 +21,10 @@
 #include <asm/virt.h>
 
 #define ARM_EXCEPTION_IRQ	  0
-#define ARM_EXCEPTION_TRAP	  1
+#define ARM_EXCEPTION_EL1_SERROR  1
+#define ARM_EXCEPTION_TRAP	  2
 /* The hyp-stub will return this for any kvm_call_hyp() call */
-#define ARM_EXCEPTION_HYP_GONE	  2
+#define ARM_EXCEPTION_HYP_GONE	  3
 
 #define KVM_ARM64_DEBUG_DIRTY_SHIFT	0
 #define KVM_ARM64_DEBUG_DIRTY		(1 << KVM_ARM64_DEBUG_DIRTY_SHIFT)
-- 
2.9.0
