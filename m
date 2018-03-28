From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 28 Mar 2018 13:52:39 +0100
Subject: [PATCH 70/85] arm64: Update the KVM memory map documentation
In-Reply-To: <20180328125254.31380-1-marc.zyngier@arm.com>
References: <20180328125254.31380-1-marc.zyngier@arm.com>
Message-ID: <20180328125254.31380-71-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update the documentation to reflect the new tricks we play on the
EL2 mappings...

Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 Documentation/arm64/memory.txt | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/arm64/memory.txt b/Documentation/arm64/memory.txt
index 671bc0639262..c58cc5dbe667 100644
--- a/Documentation/arm64/memory.txt
+++ b/Documentation/arm64/memory.txt
@@ -86,9 +86,11 @@ Translation table lookup with 64KB pages:
  +-------------------------------------------------> [63] TTBR0/1
 
 
-When using KVM without the Virtualization Host Extensions, the hypervisor
-maps kernel pages in EL2 at a fixed offset from the kernel VA. See the
-kern_hyp_va macro for more details.
+When using KVM without the Virtualization Host Extensions, the
+hypervisor maps kernel pages in EL2 at a fixed (and potentially
+random) offset from the linear mapping. See the kern_hyp_va macro and
+kvm_update_va_mask function for more details. MMIO devices such as
+GICv2 gets mapped next to the HYP idmap page.
 
 When using KVM with the Virtualization Host Extensions, no additional
 mappings are created, since the host kernel runs directly in EL2.
-- 
2.14.2
