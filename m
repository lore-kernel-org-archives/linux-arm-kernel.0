From: Dave.Martin@arm.com (Dave Martin)
Date: Mon, 13 Jul 2015 14:25:55 +0100
Subject: [PATCH v2 08/10] arm64/debug: Add missing #include
In-Reply-To: <1436793967-7138-1-git-send-email-Dave.Martin@arm.com>
References: <1436793967-7138-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1436793967-7138-9-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

<asm/debug-monitors.h> relies on <asm/ptrace.h>, but doesn't
declare this dependency.  This becomes a problem once
debug-monitors.h starts getting included all over the place to get
the BRK immedates.

This patch adds the missing #include.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/include/asm/debug-monitors.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/include/asm/debug-monitors.h b/arch/arm64/include/asm/debug-monitors.h
index 6a17fb8..b5715cb 100644
--- a/arch/arm64/include/asm/debug-monitors.h
+++ b/arch/arm64/include/asm/debug-monitors.h
@@ -20,6 +20,7 @@
 
 #include <asm/esr.h>
 #include <asm/insn.h>
+#include <asm/ptrace.h>
 
 /* Low-level stepping controls. */
 #define DBG_MDSCR_SS		(1 << 0)
-- 
1.7.10.4
