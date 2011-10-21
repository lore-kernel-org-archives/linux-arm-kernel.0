From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 21 Oct 2011 10:33:00 +0800
Subject: [PATCH] arm/imx: add missing include of asm/exception.h for avic.c
Message-ID: <1319164380-23517-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It adds missing include of asm/exception.h for avic.c to fix the
compile error below.

  arch/arm/plat-mxc/avic.c:154:39: error: expected ?=?, ?,?, ?;?,
  ?asm? or ?__attribute__? before ?avic_handle_irq?

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
Arnd,

I hit this error when building imx6q on your for-next branch.

 arch/arm/plat-mxc/avic.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-mxc/avic.c b/arch/arm/plat-mxc/avic.c
index 8875fb4..3157691 100644
--- a/arch/arm/plat-mxc/avic.c
+++ b/arch/arm/plat-mxc/avic.c
@@ -21,6 +21,7 @@
 #include <linux/irq.h>
 #include <linux/io.h>
 #include <mach/common.h>
+#include <asm/exception.h>
 #include <asm/mach/irq.h>
 #include <mach/hardware.h>
 
-- 
1.7.4.1
