From: Dave.Martin@arm.com (Dave Martin)
Date: Mon, 13 Jul 2015 14:25:50 +0100
Subject: [PATCH v2 03/10] arm64: esr.h type fixes and cleanup
In-Reply-To: <1436793967-7138-1-git-send-email-Dave.Martin@arm.com>
References: <1436793967-7138-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1436793967-7138-4-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ESR_ELx is a 32-bit register, so it is not necessary for all the
template values defined by esr.h to be forced to 64-bit (long).

This patch introduces a UINT() macro analogous to UL(), and applies
it consistently.  (Unfortunately, the more succinct U and UI names
are already used in unrelated code, and cause conflicts since
memory.h is widely included.)

Since this change touches many lines already, I've taken the
opportunity to squash some redundant parentheses and bogus
whitespace at the same time.

The missing include of <asm/memory.h> (for UL(), UINT() etc.) is
also added.

No functional change.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/include/asm/esr.h    |  128 ++++++++++++++++++++-------------------
 arch/arm64/include/asm/memory.h |    3 +-
 2 files changed, 67 insertions(+), 64 deletions(-)

diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
index 7052245..8dab2a9 100644
--- a/arch/arm64/include/asm/esr.h
+++ b/arch/arm64/include/asm/esr.h
@@ -18,86 +18,88 @@
 #ifndef __ASM_ESR_H
 #define __ASM_ESR_H
 
-#define ESR_ELx_EC_UNKNOWN	(0x00)
-#define ESR_ELx_EC_WFx		(0x01)
+#include <asm/memory.h>
+
+#define ESR_ELx_EC_UNKNOWN	UINT(0x00)
+#define ESR_ELx_EC_WFx		UINT(0x01)
 /* Unallocated EC: 0x02 */
-#define ESR_ELx_EC_CP15_32	(0x03)
-#define ESR_ELx_EC_CP15_64	(0x04)
-#define ESR_ELx_EC_CP14_MR	(0x05)
-#define ESR_ELx_EC_CP14_LS	(0x06)
-#define ESR_ELx_EC_FP_ASIMD	(0x07)
-#define ESR_ELx_EC_CP10_ID	(0x08)
+#define ESR_ELx_EC_CP15_32	UINT(0x03)
+#define ESR_ELx_EC_CP15_64	UINT(0x04)
+#define ESR_ELx_EC_CP14_MR	UINT(0x05)
+#define ESR_ELx_EC_CP14_LS	UINT(0x06)
+#define ESR_ELx_EC_FP_ASIMD	UINT(0x07)
+#define ESR_ELx_EC_CP10_ID	UINT(0x08)
 /* Unallocated EC: 0x09 - 0x0B */
-#define ESR_ELx_EC_CP14_64	(0x0C)
+#define ESR_ELx_EC_CP14_64	UINT(0x0C)
 /* Unallocated EC: 0x0d */
-#define ESR_ELx_EC_ILL		(0x0E)
+#define ESR_ELx_EC_ILL		UINT(0x0E)
 /* Unallocated EC: 0x0F - 0x10 */
-#define ESR_ELx_EC_SVC32	(0x11)
-#define ESR_ELx_EC_HVC32	(0x12)
-#define ESR_ELx_EC_SMC32	(0x13)
+#define ESR_ELx_EC_SVC32	UINT(0x11)
+#define ESR_ELx_EC_HVC32	UINT(0x12)
+#define ESR_ELx_EC_SMC32	UINT(0x13)
 /* Unallocated EC: 0x14 */
-#define ESR_ELx_EC_SVC64	(0x15)
-#define ESR_ELx_EC_HVC64	(0x16)
-#define ESR_ELx_EC_SMC64	(0x17)
-#define ESR_ELx_EC_SYS64	(0x18)
+#define ESR_ELx_EC_SVC64	UINT(0x15)
+#define ESR_ELx_EC_HVC64	UINT(0x16)
+#define ESR_ELx_EC_SMC64	UINT(0x17)
+#define ESR_ELx_EC_SYS64	UINT(0x18)
 /* Unallocated EC: 0x19 - 0x1E */
-#define ESR_ELx_EC_IMP_DEF	(0x1f)
-#define ESR_ELx_EC_IABT_LOW	(0x20)
-#define ESR_ELx_EC_IABT_CUR	(0x21)
-#define ESR_ELx_EC_PC_ALIGN	(0x22)
+#define ESR_ELx_EC_IMP_DEF	UINT(0x1f)
+#define ESR_ELx_EC_IABT_LOW	UINT(0x20)
+#define ESR_ELx_EC_IABT_CUR	UINT(0x21)
+#define ESR_ELx_EC_PC_ALIGN	UINT(0x22)
 /* Unallocated EC: 0x23 */
-#define ESR_ELx_EC_DABT_LOW	(0x24)
-#define ESR_ELx_EC_DABT_CUR	(0x25)
-#define ESR_ELx_EC_SP_ALIGN	(0x26)
+#define ESR_ELx_EC_DABT_LOW	UINT(0x24)
+#define ESR_ELx_EC_DABT_CUR	UINT(0x25)
+#define ESR_ELx_EC_SP_ALIGN	UINT(0x26)
 /* Unallocated EC: 0x27 */
-#define ESR_ELx_EC_FP_EXC32	(0x28)
+#define ESR_ELx_EC_FP_EXC32	UINT(0x28)
 /* Unallocated EC: 0x29 - 0x2B */
-#define ESR_ELx_EC_FP_EXC64	(0x2C)
+#define ESR_ELx_EC_FP_EXC64	UINT(0x2C)
 /* Unallocated EC: 0x2D - 0x2E */
-#define ESR_ELx_EC_SERROR	(0x2F)
-#define ESR_ELx_EC_BREAKPT_LOW	(0x30)
-#define ESR_ELx_EC_BREAKPT_CUR	(0x31)
-#define ESR_ELx_EC_SOFTSTP_LOW	(0x32)
-#define ESR_ELx_EC_SOFTSTP_CUR	(0x33)
-#define ESR_ELx_EC_WATCHPT_LOW	(0x34)
-#define ESR_ELx_EC_WATCHPT_CUR	(0x35)
+#define ESR_ELx_EC_SERROR	UINT(0x2F)
+#define ESR_ELx_EC_BREAKPT_LOW	UINT(0x30)
+#define ESR_ELx_EC_BREAKPT_CUR	UINT(0x31)
+#define ESR_ELx_EC_SOFTSTP_LOW	UINT(0x32)
+#define ESR_ELx_EC_SOFTSTP_CUR	UINT(0x33)
+#define ESR_ELx_EC_WATCHPT_LOW	UINT(0x34)
+#define ESR_ELx_EC_WATCHPT_CUR	UINT(0x35)
 /* Unallocated EC: 0x36 - 0x37 */
-#define ESR_ELx_EC_BKPT32	(0x38)
+#define ESR_ELx_EC_BKPT32	UINT(0x38)
 /* Unallocated EC: 0x39 */
-#define ESR_ELx_EC_VECTOR32	(0x3A)
+#define ESR_ELx_EC_VECTOR32	UINT(0x3A)
 /* Unallocted EC: 0x3B */
-#define ESR_ELx_EC_BRK64	(0x3C)
+#define ESR_ELx_EC_BRK64	UINT(0x3C)
 /* Unallocated EC: 0x3D - 0x3F */
-#define ESR_ELx_EC_MAX		(0x3F)
+#define ESR_ELx_EC_MAX		UINT(0x3F)
 
-#define ESR_ELx_EC_SHIFT	(26)
-#define ESR_ELx_EC_MASK		(UL(0x3F) << ESR_ELx_EC_SHIFT)
+#define ESR_ELx_EC_SHIFT	26
+#define ESR_ELx_EC_MASK		(ESR_ELx_EC_MAX << ESR_ELx_EC_SHIFT)
 
-#define ESR_ELx_IL		(UL(1) << 25)
+#define ESR_ELx_IL		(UINT(1) << 25)
 #define ESR_ELx_ISS_MASK	(ESR_ELx_IL - 1)
-#define ESR_ELx_ISV		(UL(1) << 24)
-#define ESR_ELx_SAS_SHIFT	(22)
-#define ESR_ELx_SAS		(UL(3) << ESR_ELx_SAS_SHIFT)
-#define ESR_ELx_SSE		(UL(1) << 21)
-#define ESR_ELx_SRT_SHIFT	(16)
-#define ESR_ELx_SRT_MASK	(UL(0x1F) << ESR_ELx_SRT_SHIFT)
-#define ESR_ELx_SF 		(UL(1) << 15)
-#define ESR_ELx_AR 		(UL(1) << 14)
-#define ESR_ELx_EA 		(UL(1) << 9)
-#define ESR_ELx_CM 		(UL(1) << 8)
-#define ESR_ELx_S1PTW 		(UL(1) << 7)
-#define ESR_ELx_WNR		(UL(1) << 6)
-#define ESR_ELx_FSC		(0x3F)
-#define ESR_ELx_FSC_TYPE	(0x3C)
-#define ESR_ELx_FSC_EXTABT	(0x10)
-#define ESR_ELx_FSC_ACCESS	(0x08)
-#define ESR_ELx_FSC_FAULT	(0x04)
-#define ESR_ELx_FSC_PERM	(0x0C)
-#define ESR_ELx_CV		(UL(1) << 24)
-#define ESR_ELx_COND_SHIFT	(20)
-#define ESR_ELx_COND_MASK	(UL(0xF) << ESR_ELx_COND_SHIFT)
-#define ESR_ELx_WFx_ISS_WFE	(UL(1) << 0)
-#define ESR_ELx_xVC_IMM_MASK	((1UL << 16) - 1)
+#define ESR_ELx_ISV		(UINT(1) << 24)
+#define ESR_ELx_SAS_SHIFT	22
+#define ESR_ELx_SAS		(UINT(3) << ESR_ELx_SAS_SHIFT)
+#define ESR_ELx_SSE		(UINT(1) << 21)
+#define ESR_ELx_SRT_SHIFT	16
+#define ESR_ELx_SRT_MASK	(UINT(0x1F) << ESR_ELx_SRT_SHIFT)
+#define ESR_ELx_SF		(UINT(1) << 15)
+#define ESR_ELx_AR		(UINT(1) << 14)
+#define ESR_ELx_EA		(UINT(1) << 9)
+#define ESR_ELx_CM		(UINT(1) << 8)
+#define ESR_ELx_S1PTW		(UINT(1) << 7)
+#define ESR_ELx_WNR		(UINT(1) << 6)
+#define ESR_ELx_FSC		UINT(0x3F)
+#define ESR_ELx_FSC_TYPE	UINT(0x3C)
+#define ESR_ELx_FSC_EXTABT	UINT(0x10)
+#define ESR_ELx_FSC_ACCESS	UINT(0x08)
+#define ESR_ELx_FSC_FAULT	UINT(0x04)
+#define ESR_ELx_FSC_PERM	UINT(0x0C)
+#define ESR_ELx_CV		(UINT(1) << 24)
+#define ESR_ELx_COND_SHIFT	20
+#define ESR_ELx_COND_MASK	(UINT(0xF) << ESR_ELx_COND_SHIFT)
+#define ESR_ELx_WFx_ISS_WFE	(UINT(1) << 0)
+#define ESR_ELx_xVC_IMM_MASK	((UINT(1) << 16) - 1)
 
 #ifndef __ASSEMBLY__
 #include <asm/types.h>
diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index f800d45..c6a6592a 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -28,9 +28,10 @@
 
 /*
  * Allow for constants defined here to be used from assembly code
- * by prepending the UL suffix only with actual C code compilation.
+ * by prepending type suffixes only with actual C code compilation.
  */
 #define UL(x) _AC(x, UL)
+#define UINT(x) _AC(x, U)
 
 /*
  * Size of the PCI I/O space. This must remain a power of two so that
-- 
1.7.10.4
