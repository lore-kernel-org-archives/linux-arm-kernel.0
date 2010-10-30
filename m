From: joe@perches.com (Joe Perches)
Date: Sat, 30 Oct 2010 14:21:24 -0700
Subject: [PATCH] arch/arm/kernel/hw_breakpoint.c: Convert WARN_ON to WARN
Message-ID: <1288473684.366.139.camel@Joe-Laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Message isn't printed by WARN_ON.

Signed-off-by: Joe Perches <joe@perches.com>
---
 arch/arm/kernel/hw_breakpoint.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/hw_breakpoint.c b/arch/arm/kernel/hw_breakpoint.c
index 54593b0..21e3a4a 100644
--- a/arch/arm/kernel/hw_breakpoint.c
+++ b/arch/arm/kernel/hw_breakpoint.c
@@ -748,8 +748,7 @@ static int hw_breakpoint_pending(unsigned long addr, unsigned int fsr,
 		breakpoint_handler(addr, regs);
 		break;
 	case ARM_ENTRY_ASYNC_WATCHPOINT:
-		WARN_ON("Asynchronous watchpoint exception taken. "
-			"Debugging results may be unreliable");
+		WARN(1, "Asynchronous watchpoint exception taken. Debugging results may be unreliable\n");
 	case ARM_ENTRY_SYNC_WATCHPOINT:
 		watchpoint_handler(addr, regs);
 		break;
