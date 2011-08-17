From: bryan.wu@canonical.com (Bryan Wu)
Date: Wed, 17 Aug 2011 18:00:04 +0800
Subject: [PATCH] ARM: mach-footbridge: add missing header file <video/vga.h>
Message-ID: <1313575204-25374-1-git-send-email-bryan.wu@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes following building error:
--
arch/arm/mach-footbridge/dc21285.c: In function 'dc21285_preinit':
arch/arm/mach-footbridge/dc21285.c:299:2: error: 'vga_base' undeclared (first use in this function)
arch/arm/mach-footbridge/dc21285.c:299:2: note: each undeclared identifier is reported only once for each function it appears in
make[1]: *** [arch/arm/mach-footbridge/dc21285.o] Error 1
--

Signed-off-by: Bryan Wu <bryan.wu@canonical.com>
---
 arch/arm/mach-footbridge/dc21285.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-footbridge/dc21285.c b/arch/arm/mach-footbridge/dc21285.c
index 1331fff..18c32a5 100644
--- a/arch/arm/mach-footbridge/dc21285.c
+++ b/arch/arm/mach-footbridge/dc21285.c
@@ -18,6 +18,7 @@
 #include <linux/irq.h>
 #include <linux/io.h>
 #include <linux/spinlock.h>
+#include <video/vga.h>
 
 #include <asm/irq.h>
 #include <asm/system.h>
-- 
1.7.5
