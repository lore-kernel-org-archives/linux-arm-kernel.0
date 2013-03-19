From: pebolle@tiscali.nl (Paul Bolle)
Date: Tue, 19 Mar 2013 16:41:37 +0100
Subject: [PATCH] arm64: Kconfig.debug: Remove unused CONFIG_DEBUG_ERRORS
Message-ID: <1363707697.1390.13.camel@x61.thuisdomein>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Kconfig entry for DEBUG_ERRORS is a verbatim copy of the former arm
entry for that symbol. It got removed in v2.6.39 because it wasn't
actually used anywhere. There are still no users of DEBUG_ERRORS so
remove this entry too.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
0) Eyeball tested.

1) The arm entry got removed in commit
b025a3f836d1e8785ae65b59282a4befef9892bb ("ARM: 6876/1: Kconfig.debug:
Remove unused CONFIG_DEBUG_ERRORS").

 arch/arm64/Kconfig.debug | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/arch/arm64/Kconfig.debug b/arch/arm64/Kconfig.debug
index 5149343..1a6bfe9 100644
--- a/arch/arm64/Kconfig.debug
+++ b/arch/arm64/Kconfig.debug
@@ -6,17 +6,6 @@ config FRAME_POINTER
 	bool
 	default y
 
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
1.7.11.7
