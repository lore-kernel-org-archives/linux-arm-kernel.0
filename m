From: ijc@hellion.org.uk (Ian Campbell)
Date: Sun, 29 Apr 2012 14:40:42 +0100
Subject: [PATCH] ARM: kirkwood: add missing kexec.h include
Message-ID: <1335706842-11725-1-git-send-email-ijc@hellion.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixes the following build error when CONFIG_KEXEC is enabled:
  CC      arch/arm/mach-kirkwood/board-dt.o
arch/arm/mach-kirkwood/board-dt.c: In function 'kirkwood_dt_init':
arch/arm/mach-kirkwood/board-dt.c:52:2: error: 'kexec_reinit' undeclared (first use in this function)
arch/arm/mach-kirkwood/board-dt.c:52:2: note: each undeclared identifier is reported only once for each function it appears in

Signed-off-by: Ian Campbell <ijc@hellion.org.uk>
[v4, rebase onto recent Linus for repost]
[v3, speak actual English in the commit message, thanks Sergei Shtylyov]
[v2, using linux/kexec.h not asm/kexec.h]
---
 arch/arm/mach-kirkwood/board-dt.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
index 1c672d9..f7fe1b9 100644
--- a/arch/arm/mach-kirkwood/board-dt.c
+++ b/arch/arm/mach-kirkwood/board-dt.c
@@ -14,6 +14,7 @@
 #include <linux/init.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
+#include <linux/kexec.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <mach/bridge-regs.h>
-- 
1.7.10
