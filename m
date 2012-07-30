From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Mon, 30 Jul 2012 22:22:36 +0800
Subject: [PATCH] ARM: mmp: add missing irqs.h
Message-ID: <1343658156-8154-1-git-send-email-haojian.zhuang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arch/arm/mach-mmp/gplugd.c:195:13: error: ?MMP_NR_IRQS? undeclared here
(not in a function)
make[1]: *** [arch/arm/mach-mmp/gplugd.o] Error 1

Include <mach/irqs.h> to fix this issue.

Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>
---
 arch/arm/mach-mmp/gplugd.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-mmp/gplugd.c b/arch/arm/mach-mmp/gplugd.c
index f516e74..5c3d61e 100644
--- a/arch/arm/mach-mmp/gplugd.c
+++ b/arch/arm/mach-mmp/gplugd.c
@@ -14,6 +14,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
 
+#include <mach/irqs.h>
 #include <mach/pxa168.h>
 #include <mach/mfp-pxa168.h>
 
-- 
1.7.9.5
