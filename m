From: dianders@chromium.org (Doug Anderson)
Date: Fri,  1 Mar 2013 12:46:52 -0800
Subject: [PATCH] ARM: Remove VFP debug spew
Message-ID: <1362170812-31048-1-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In commit e36815e2e4a2fb675207d8968bb68e22bc938328:
  ARM: Fix broken commit 0cc41e4a21d43 corrupting kernel messages

...a "#define DEBUG" line was accidentally left in.  This has the side
effect of spewing massive numbers of debug messages into the log at
boot.  Remove the DEBUG define.

Signed-off-by: Doug Anderson <dianders@chromium.org>
---
Note: The commit in question is only on linux-next.

 arch/arm/vfp/vfphw.S | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/vfp/vfphw.S b/arch/arm/vfp/vfphw.S
index 20c8dd7..8d10dc8 100644
--- a/arch/arm/vfp/vfphw.S
+++ b/arch/arm/vfp/vfphw.S
@@ -19,7 +19,6 @@
 #include <linux/kern_levels.h>
 #include "../kernel/entry-header.S"
 
-#define DEBUG
 	.macro	DBGSTR, str
 #ifdef DEBUG
 	stmfd	sp!, {r0-r3, ip, lr}
-- 
1.8.1.3
