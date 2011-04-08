From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri,  8 Apr 2011 15:08:38 -0700
Subject: [PATCH] ARM: Kconfig.debug: Remove unused CONFIG_DEBUG_ERRORS
Message-ID: <1302300518-7523-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This config option isn't actually used anywhere and can be safely
removed. The last user was traps.c before commit 082f47a ([ARM]
always allow dump_stack() to produce a backtrace, 2007-07-05).

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/Kconfig.debug |   11 -----------
 1 files changed, 0 insertions(+), 11 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 494224a..03d01d7 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -63,17 +63,6 @@ config DEBUG_USER
 	      8 - SIGSEGV faults
 	     16 - SIGBUS faults
 
-config DEBUG_ERRORS
-	bool "Verbose kernel error messages"
-	depends on DEBUG_KERNEL
-	help
-	  This option controls verbose debugging information which can be
-	  printed when the kernel detects an internal error. This debugging
-	  information is useful to kernel hackers when tracking down problems,
-	  but mostly meaningless to other people. It's safe to say Y unless
-	  you are concerned with the code size or don't want to see these
-	  messages.
-
 config DEBUG_STACK_USAGE
 	bool "Enable stack utilization instrumentation"
 	depends on DEBUG_KERNEL
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
