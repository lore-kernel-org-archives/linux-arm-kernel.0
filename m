From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 24 Jul 2015 16:37:45 +0100
Subject: [PATCH v3 5/9] arm64/debug: Move BRK ESR template macro into
 <asm/esr.h>
In-Reply-To: <1437752284-14847-1-git-send-email-Dave.Martin@arm.com>
References: <1437752284-14847-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1437752284-14847-6-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It makes sense to keep all the architectural exception syndrome
definitions in the same place.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/debug-monitors.h |    7 -------
 arch/arm64/include/asm/esr.h            |    7 +++++++
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/debug-monitors.h b/arch/arm64/include/asm/debug-monitors.h
index bb97e9d..e28b1dd 100644
--- a/arch/arm64/include/asm/debug-monitors.h
+++ b/arch/arm64/include/asm/debug-monitors.h
@@ -44,13 +44,6 @@
 #define BREAK_INSTR_SIZE		AARCH64_INSN_SIZE
 
 /*
- * ESR values expected for dynamic and compile time BRK instruction
- */
-#define ESR_ELx_VAL_BRK64(imm)					\
-	((ESR_ELx_EC_BRK64 << ESR_ELx_EC_SHIFT) | ESR_ELx_IL |	\
-	 ((imm) & 0xffff))
-
-/*
  * #imm16 values used for BRK instruction generation
  * Allowed values for kgbd are 0x400 - 0x7ff
  * 0x100: for triggering a fault on purpose (reserved)
diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
index 7052245..1b44cf6 100644
--- a/arch/arm64/include/asm/esr.h
+++ b/arch/arm64/include/asm/esr.h
@@ -99,6 +99,13 @@
 #define ESR_ELx_WFx_ISS_WFE	(UL(1) << 0)
 #define ESR_ELx_xVC_IMM_MASK	((1UL << 16) - 1)
 
+/* ESR value templates for specific events */
+
+/* BRK instruction trap from AArch64 state */
+#define ESR_ELx_VAL_BRK64(imm)					\
+	((ESR_ELx_EC_BRK64 << ESR_ELx_EC_SHIFT) | ESR_ELx_IL |	\
+	 ((imm) & 0xffff))
+
 #ifndef __ASSEMBLY__
 #include <asm/types.h>
 
-- 
1.7.10.4
