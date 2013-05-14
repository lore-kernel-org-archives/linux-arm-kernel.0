From: Baohua.Song@csr.com (Barry Song)
Date: Tue, 14 May 2013 17:32:03 +0800
Subject: [PATCH] arm: prima2: use of_platform_populate instead of
 of_platform_bus_probe
Message-ID: <1368523923-27137-1-git-send-email-Baohua.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

use of_platform_populate to populate platform devices, it is suitable
for creating devices which are children of the root node, then makes
things like pcm work.

Signed-off-by: Barry Song <Baohua.Song@csr.com>
Signed-off-by: Rongjun Ying <Rongjun.Ying@csr.com>
---
 arch/arm/mach-prima2/common.c |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-prima2/common.c b/arch/arm/mach-prima2/common.c
index 4f94cd8..bb67b90 100644
--- a/arch/arm/mach-prima2/common.c
+++ b/arch/arm/mach-prima2/common.c
@@ -17,14 +17,9 @@
 #include <linux/of_platform.h>
 #include "common.h"
 
-static struct of_device_id sirfsoc_of_bus_ids[] __initdata = {
-	{ .compatible = "simple-bus", },
-	{},
-};
-
 void __init sirfsoc_mach_init(void)
 {
-	of_platform_bus_probe(NULL, sirfsoc_of_bus_ids, NULL);
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
 void __init sirfsoc_init_late(void)
-- 
1.7.4.1



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
