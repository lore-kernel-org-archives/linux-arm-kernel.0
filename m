From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri, 17 Jun 2011 14:03:52 +0200
Subject: [PATCH] plat-iop: fix build error
Message-ID: <1308312232-30488-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

The iop13xx_defconfig didn't build since the platform code uses
defines from <asm/ptrace.h>. Simply add the include so it
compiles.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/plat-iop/cp6.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-iop/cp6.c b/arch/arm/plat-iop/cp6.c
index 9612a87..bab73e2 100644
--- a/arch/arm/plat-iop/cp6.c
+++ b/arch/arm/plat-iop/cp6.c
@@ -18,6 +18,7 @@
  */
 #include <linux/init.h>
 #include <asm/traps.h>
+#include <asm/ptrace.h>
 
 static int cp6_trap(struct pt_regs *regs, unsigned int instr)
 {
-- 
1.7.3.2
