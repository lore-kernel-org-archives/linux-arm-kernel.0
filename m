From: ijc@hellion.org.uk (Ian Campbell)
Date: Fri,  6 Apr 2012 13:30:58 +0100
Subject: [PATCH] ARM: kirkwood: add missing kexec.h include
Message-ID: <1333715458-13834-1-git-send-email-ijc@hellion.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixes build the following error when CONFIG_KEXEC is enabled:
  CC      arch/arm/mach-kirkwood/board-dt.o
arch/arm/mach-kirkwood/board-dt.c: In function 'kirkwood_dt_init':
arch/arm/mach-kirkwood/board-dt.c:52:2: error: 'kexec_reinit' undeclared (first use in this function)
arch/arm/mach-kirkwood/board-dt.c:52:2: note: each undeclared identifier is reported only once for each function it appears in

kexec.h also needs string.h.

Signed-off-by: Ian Campbell <ijc@hellion.org.uk>
---
 arch/arm/mach-kirkwood/board-dt.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
index 1c672d9..5868b71 100644
--- a/arch/arm/mach-kirkwood/board-dt.c
+++ b/arch/arm/mach-kirkwood/board-dt.c
@@ -14,6 +14,8 @@
 #include <linux/init.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
+#include <linux/string.h>
+#include <asm/kexec.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <mach/bridge-regs.h>
-- 
1.7.8.3
