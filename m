From: mark.rutland@arm.com (Mark Rutland)
Date: Wed,  7 Jan 2015 12:04:16 +0000
Subject: [PATCH 3/7] arm64: remove ESR_EL1_* macros
In-Reply-To: <1420632260-8798-1-git-send-email-mark.rutland@arm.com>
References: <1420632260-8798-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1420632260-8798-4-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that all users have been moved over to the common ESR_ELx_* macros,
remove the redundant ESR_EL1 macros.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Christoffer Dall <christoffer.dall@linaro.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/esr.h | 36 ------------------------------------
 1 file changed, 36 deletions(-)

diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
index eaee379..19492e1 100644
--- a/arch/arm64/include/asm/esr.h
+++ b/arch/arm64/include/asm/esr.h
@@ -18,42 +18,6 @@
 #ifndef __ASM_ESR_H
 #define __ASM_ESR_H
 
-#define ESR_EL1_WRITE		(1 << 6)
-#define ESR_EL1_CM		(1 << 8)
-#define ESR_EL1_IL		(1 << 25)
-
-#define ESR_EL1_EC_SHIFT	(26)
-#define ESR_EL1_EC_UNKNOWN	(0x00)
-#define ESR_EL1_EC_WFI		(0x01)
-#define ESR_EL1_EC_CP15_32	(0x03)
-#define ESR_EL1_EC_CP15_64	(0x04)
-#define ESR_EL1_EC_CP14_MR	(0x05)
-#define ESR_EL1_EC_CP14_LS	(0x06)
-#define ESR_EL1_EC_FP_ASIMD	(0x07)
-#define ESR_EL1_EC_CP10_ID	(0x08)
-#define ESR_EL1_EC_CP14_64	(0x0C)
-#define ESR_EL1_EC_ILL_ISS	(0x0E)
-#define ESR_EL1_EC_SVC32	(0x11)
-#define ESR_EL1_EC_SVC64	(0x15)
-#define ESR_EL1_EC_SYS64	(0x18)
-#define ESR_EL1_EC_IABT_EL0	(0x20)
-#define ESR_EL1_EC_IABT_EL1	(0x21)
-#define ESR_EL1_EC_PC_ALIGN	(0x22)
-#define ESR_EL1_EC_DABT_EL0	(0x24)
-#define ESR_EL1_EC_DABT_EL1	(0x25)
-#define ESR_EL1_EC_SP_ALIGN	(0x26)
-#define ESR_EL1_EC_FP_EXC32	(0x28)
-#define ESR_EL1_EC_FP_EXC64	(0x2C)
-#define ESR_EL1_EC_SERROR	(0x2F)
-#define ESR_EL1_EC_BREAKPT_EL0	(0x30)
-#define ESR_EL1_EC_BREAKPT_EL1	(0x31)
-#define ESR_EL1_EC_SOFTSTP_EL0	(0x32)
-#define ESR_EL1_EC_SOFTSTP_EL1	(0x33)
-#define ESR_EL1_EC_WATCHPT_EL0	(0x34)
-#define ESR_EL1_EC_WATCHPT_EL1	(0x35)
-#define ESR_EL1_EC_BKPT32	(0x38)
-#define ESR_EL1_EC_BRK64	(0x3C)
-
 #define ESR_ELx_EC_UNKNOWN	(0x00)
 #define ESR_ELx_EC_WFx		(0x01)
 /* Unallocated EC: 0x02 */
-- 
1.9.1
