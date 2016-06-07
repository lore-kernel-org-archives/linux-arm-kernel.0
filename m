From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Tue,  7 Jun 2016 20:03:45 +0100
Subject: [PATCH 1/5] mvebu: fix missing includes in pmsu.c
In-Reply-To: <1465326229-24787-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1465326229-24787-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1465326229-24787-2-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The file is missing definitions for some functions due to not
including two header files. Fix the following warnings by
including "pmsu.h" and <linux/mvebu-pmsu.h> in pmsu.c:

arch/arm/mach-mvebu/pmsu.c:127:5: warning: symbol 'mvebu_setup_boot_addr_wa' was not declared. Should it be static?
arch/arm/mach-mvebu/pmsu.c:267:5: warning: symbol 'armada_370_xp_pmsu_idle_enter' was not declared. Should it be static?
arch/arm/mach-mvebu/pmsu.c:313:5: warning: symbol 'armada_38x_do_cpu_suspend' was not declared. Should it be static?
arch/arm/mach-mvebu/pmsu.c:340:6: warning: symbol 'mvebu_v7_pmsu_idle_exit' was not declared. Should it be static?
arch/arm/mach-mvebu/pmsu.c:570:5: warning: symbol 'mvebu_pmsu_dfs_request' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 arch/arm/mach-mvebu/pmsu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
index b444423..f39bd51 100644
--- a/arch/arm/mach-mvebu/pmsu.c
+++ b/arch/arm/mach-mvebu/pmsu.c
@@ -25,6 +25,7 @@
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/mbus.h>
+#include <linux/mvebu-pmsu.h>
 #include <linux/of_address.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
@@ -38,7 +39,7 @@
 #include <asm/suspend.h>
 #include <asm/tlbflush.h>
 #include "common.h"
-
+#include "pmsu.h"
 
 #define PMSU_BASE_OFFSET    0x100
 #define PMSU_REG_SIZE	    0x1000
-- 
2.8.1
