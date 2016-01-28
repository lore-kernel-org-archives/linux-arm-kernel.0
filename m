From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 28 Jan 2016 15:56:03 +0000
Subject: [RFC PATCH 3/5] ARM: KVM: Move kvm/hyp/hyp.h to include/asm/kvm_hyp.h
In-Reply-To: <1453996565-19666-1-git-send-email-marc.zyngier@arm.com>
References: <1453996565-19666-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1453996565-19666-4-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to be able to use the code located in virt/kvm/arm/hyp,
we need to make the global hyp.h file accessible from include/asm,
similar to what we did for arm64.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/{kvm/hyp/hyp.h => include/asm/kvm_hyp.h} | 0
 arch/arm/kvm/hyp/banked-sr.c                      | 2 +-
 arch/arm/kvm/hyp/cp15-sr.c                        | 2 +-
 arch/arm/kvm/hyp/switch.c                         | 2 +-
 arch/arm/kvm/hyp/timer-sr.c                       | 4 +---
 arch/arm/kvm/hyp/tlb.c                            | 2 +-
 arch/arm/kvm/hyp/vgic-v2-sr.c                     | 4 +---
 7 files changed, 6 insertions(+), 10 deletions(-)
 rename arch/arm/{kvm/hyp/hyp.h => include/asm/kvm_hyp.h} (100%)

diff --git a/arch/arm/kvm/hyp/hyp.h b/arch/arm/include/asm/kvm_hyp.h
similarity index 100%
rename from arch/arm/kvm/hyp/hyp.h
rename to arch/arm/include/asm/kvm_hyp.h
diff --git a/arch/arm/kvm/hyp/banked-sr.c b/arch/arm/kvm/hyp/banked-sr.c
index d02dc80..111bda8 100644
--- a/arch/arm/kvm/hyp/banked-sr.c
+++ b/arch/arm/kvm/hyp/banked-sr.c
@@ -18,7 +18,7 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
-#include "hyp.h"
+#include <asm/kvm_hyp.h>
 
 __asm__(".arch_extension     virt");
 
diff --git a/arch/arm/kvm/hyp/cp15-sr.c b/arch/arm/kvm/hyp/cp15-sr.c
index 732abbc..c478281 100644
--- a/arch/arm/kvm/hyp/cp15-sr.c
+++ b/arch/arm/kvm/hyp/cp15-sr.c
@@ -18,7 +18,7 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
-#include "hyp.h"
+#include <asm/kvm_hyp.h>
 
 static u64 *cp15_64(struct kvm_cpu_context *ctxt, int idx)
 {
diff --git a/arch/arm/kvm/hyp/switch.c b/arch/arm/kvm/hyp/switch.c
index 7325ad3..17c5e57 100644
--- a/arch/arm/kvm/hyp/switch.c
+++ b/arch/arm/kvm/hyp/switch.c
@@ -16,7 +16,7 @@
  */
 
 #include <asm/kvm_asm.h>
-#include "hyp.h"
+#include <asm/kvm_hyp.h>
 
 __asm__(".arch_extension     virt");
 
diff --git a/arch/arm/kvm/hyp/timer-sr.c b/arch/arm/kvm/hyp/timer-sr.c
index d7535fd..2bb0c92 100644
--- a/arch/arm/kvm/hyp/timer-sr.c
+++ b/arch/arm/kvm/hyp/timer-sr.c
@@ -19,9 +19,7 @@
 #include <linux/compiler.h>
 #include <linux/kvm_host.h>
 
-#include <asm/kvm_mmu.h>
-
-#include "hyp.h"
+#include <asm/kvm_hyp.h>
 
 /* vcpu is already in the HYP VA space */
 void __hyp_text __timer_save_state(struct kvm_vcpu *vcpu)
diff --git a/arch/arm/kvm/hyp/tlb.c b/arch/arm/kvm/hyp/tlb.c
index 3854e31..0e46d1b 100644
--- a/arch/arm/kvm/hyp/tlb.c
+++ b/arch/arm/kvm/hyp/tlb.c
@@ -18,7 +18,7 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
-#include "hyp.h"
+#include <asm/kvm_hyp.h>
 
 /**
  * Flush per-VMID TLBs
diff --git a/arch/arm/kvm/hyp/vgic-v2-sr.c b/arch/arm/kvm/hyp/vgic-v2-sr.c
index e717612..9514a7d 100644
--- a/arch/arm/kvm/hyp/vgic-v2-sr.c
+++ b/arch/arm/kvm/hyp/vgic-v2-sr.c
@@ -19,9 +19,7 @@
 #include <linux/irqchip/arm-gic.h>
 #include <linux/kvm_host.h>
 
-#include <asm/kvm_mmu.h>
-
-#include "hyp.h"
+#include <asm/kvm_hyp.h>
 
 /* vcpu is already in the HYP VA space */
 void __hyp_text __vgic_v2_save_state(struct kvm_vcpu *vcpu)
-- 
2.1.4
