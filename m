From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 04 Oct 2010 18:09:40 +0100
Subject: [PATCH 10/10] ARM: add register documentation for __enable_mmu
Message-ID: <E1P2oXk-00020o-Ly@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add some additional documentation on register usage in __enable_mmu
to help complete the overall picture.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/kernel/head.S |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index ed9ebe5..c11dd14 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -303,6 +303,13 @@ __secondary_data:
  * Setup common bits before finally enabling the MMU.  Essentially
  * this is just loading the page table pointer and domain access
  * registers.
+ *
+ *  r0  = cp#15 control register
+ *  r1  = machine ID
+ *  r2  = atags pointer
+ *  r4  = page table pointer
+ *  r9  = processor ID
+ *  r13 = *virtual* address to jump to upon completion
  */
 __enable_mmu:
 #ifdef CONFIG_ALIGNMENT_TRAP
@@ -335,6 +342,9 @@ ENDPROC(__enable_mmu)
  * mailing list archives BEFORE sending another post to the list.
  *
  *  r0  = cp#15 control register
+ *  r1  = machine ID
+ *  r2  = atags pointer
+ *  r9  = processor ID
  *  r13 = *virtual* address to jump to upon completion
  *
  * other registers depend on the function called upon completion
-- 
1.6.2.5
