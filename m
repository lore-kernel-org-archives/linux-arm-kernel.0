From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 24 Jul 2015 16:37:41 +0100
Subject: [PATCH v3 1/9] arm64/debug: Eliminate magic number for size of BRK
 instruction
In-Reply-To: <1437752284-14847-1-git-send-email-Dave.Martin@arm.com>
References: <1437752284-14847-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1437752284-14847-2-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The size of an A64 BRK instruction is the same as the size of all other
A64 instructions, because all A64 instructions are the same size.

BREAK_INSTR_SIZE is retained for readibility, but it should not be
an independent constant from AARCH64_INSN_SIZE.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/debug-monitors.h |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/debug-monitors.h b/arch/arm64/include/asm/debug-monitors.h
index 40ec68a..f3d2dbd 100644
--- a/arch/arm64/include/asm/debug-monitors.h
+++ b/arch/arm64/include/asm/debug-monitors.h
@@ -18,6 +18,8 @@
 
 #ifdef __KERNEL__
 
+#include <asm/insn.h>
+
 /* Low-level stepping controls. */
 #define DBG_MDSCR_SS		(1 << 0)
 #define DBG_SPSR_SS		(1 << 21)
@@ -38,7 +40,7 @@
 /*
  * Break point instruction encoding
  */
-#define BREAK_INSTR_SIZE		4
+#define BREAK_INSTR_SIZE		AARCH64_INSN_SIZE
 
 /*
  * ESR values expected for dynamic and compile time BRK instruction
-- 
1.7.10.4
