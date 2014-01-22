From: cov@codeaurora.org (Christopher Covington)
Date: Wed, 22 Jan 2014 13:29:25 -0500
Subject: [PATCH] ARM: hw_breakpoint: Add ARMv8 support
Message-ID: <1390415365-17230-1-git-send-email-cov@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the trivial support necessary to get hardware breakpoints
working for GDB on ARMv8 simulators running in AArch32 mode.

Signed-off-by: Christopher Covington <cov@codeaurora.org>
---
 arch/arm/include/asm/hw_breakpoint.h | 1 +
 arch/arm/kernel/hw_breakpoint.c      | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/include/asm/hw_breakpoint.h b/arch/arm/include/asm/hw_breakpoint.h
index eef55ea..8e427c7 100644
--- a/arch/arm/include/asm/hw_breakpoint.h
+++ b/arch/arm/include/asm/hw_breakpoint.h
@@ -51,6 +51,7 @@ static inline void decode_ctrl_reg(u32 reg,
 #define ARM_DEBUG_ARCH_V7_ECP14	3
 #define ARM_DEBUG_ARCH_V7_MM	4
 #define ARM_DEBUG_ARCH_V7_1	5
+#define ARM_DEBUG_ARCH_V8	6
 
 /* Breakpoint */
 #define ARM_BREAKPOINT_EXECUTE	0
diff --git a/arch/arm/kernel/hw_breakpoint.c b/arch/arm/kernel/hw_breakpoint.c
index 3d44660..45fbcaf 100644
--- a/arch/arm/kernel/hw_breakpoint.c
+++ b/arch/arm/kernel/hw_breakpoint.c
@@ -257,6 +257,7 @@ static int enable_monitor_mode(void)
 		break;
 	case ARM_DEBUG_ARCH_V7_ECP14:
 	case ARM_DEBUG_ARCH_V7_1:
+	case ARM_DEBUG_ARCH_V8:
 		ARM_DBG_WRITE(c0, c2, 2, (dscr | ARM_DSCR_MDBGEN));
 		isb();
 		break;
-- 
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by the Linux Foundation.
