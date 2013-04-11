From: jhbird.choi@samsung.com (Jonghwan Choi)
Date: Thu, 11 Apr 2013 11:37:17 +0900
Subject: [PATCH] KVM: ARM: Fix wrong address in comment
Message-ID: <000801ce365d$7b9bce70$72d36b50$%choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hyp_hvc vector offset should be 0x14 and hyp_svc vector offset should be
0x8.

Signed-off-by: Jonghwan Choi <jhbird.choi@samsung.com>
---
 arch/arm/kvm/interrupts.S |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kvm/interrupts.S b/arch/arm/kvm/interrupts.S
index 8ca87ab..a8e0c2d 100644
--- a/arch/arm/kvm/interrupts.S
+++ b/arch/arm/kvm/interrupts.S
@@ -235,9 +235,9 @@ ENTRY(kvm_call_hyp)
  * instruction is issued since all traps are disabled when running the host
  * kernel as per the Hyp-mode initialization at boot time.
  *
- * HVC instructions cause a trap to the vector page + offset 0x18 (see
hyp_hvc
+ * HVC instructions cause a trap to the vector page + offset 0x14 (see
hyp_hvc
  * below) when the HVC instruction is called from SVC mode (i.e. a guest or
the
- * host kernel) and they cause a trap to the vector page + offset 0xc when
HVC
+ * host kernel) and they cause a trap to the vector page + offset 0x8 when
HVC
  * instructions are called from within Hyp-mode.
  *
  * Hyp-ABI: Calling HYP-mode functions from host (in SVC mode):
-- 
1.7.9.5
