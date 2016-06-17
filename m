From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Fri, 17 Jun 2016 16:05:07 +0100
Subject: [PATCH 3/9] ARM: add missing <asm/prom.h>
In-Reply-To: <1466175913-19067-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1466175913-19067-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1466175913-19067-4-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the following warnings by including declarations
from <asm/prom.h>:

arch/arm/kernel/devtree.c:69:13: warning: symbol 'arm_dt_init_cpu_maps' was not declared. Should it be static?
arch/arm/kernel/devtree.c:210:27: warning: symbol 'setup_machine_fdt' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Russell King <linux@armlinux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel at lists.infradead.org
---
 arch/arm/kernel/devtree.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/kernel/devtree.c b/arch/arm/kernel/devtree.c
index 2e26016..d42a9fe 100644
--- a/arch/arm/kernel/devtree.c
+++ b/arch/arm/kernel/devtree.c
@@ -23,6 +23,7 @@
 #include <asm/cputype.h>
 #include <asm/setup.h>
 #include <asm/page.h>
+#include <asm/prom.h>
 #include <asm/smp_plat.h>
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
-- 
2.8.1
