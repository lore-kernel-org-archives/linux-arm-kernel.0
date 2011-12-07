From: lauraa@codeaurora.org (Laura Abbott)
Date: Wed,  7 Dec 2011 13:36:06 -0800
Subject: [PATCH] fault_inject: Don't select frame pointer with ARM unwind
Message-ID: <1323293766-31394-1-git-send-email-lauraa@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CONFIG_FAULT_INJECTION_STACKTRACE_FILTER selects FRAME_POINTER.
If ARM_UNWIND is used for backtracing, the FRAME_POINTER
should not be selected.

Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
---
 lib/Kconfig.debug |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 6a9e368..75b5d6b 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1079,7 +1079,7 @@ config FAULT_INJECTION_STACKTRACE_FILTER
 	depends on FAULT_INJECTION_DEBUG_FS && STACKTRACE_SUPPORT
 	depends on !X86_64
 	select STACKTRACE
-	select FRAME_POINTER if !PPC && !S390 && !MICROBLAZE
+	select FRAME_POINTER if !PPC && !S390 && !MICROBLAZE && !ARM_UNWIND
 	help
 	  Provide stacktrace filter for fault-injection capabilities
 
-- 
1.7.6
