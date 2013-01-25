From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 25 Jan 2013 05:32:24 +0000
Subject: [RFC V2 PATCH 3/8] ARM: kirkwood: nsa310: cleanup includes and
 unneeded code
In-Reply-To: <cover.1359091286.git.jason@lakedaemon.net>
References: <cover.1358983578.git.jason@lakedaemon.net>
 <cover.1359091286.git.jason@lakedaemon.net>
Message-ID: <31142087d93c2713d067f4ccf470810e6e71f17b.1359091286.git.jason@lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jason Cooper <jason@lakedaemon.net>
---
 arch/arm/mach-kirkwood/board-nsa310.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/arm/mach-kirkwood/board-nsa310.c b/arch/arm/mach-kirkwood/board-nsa310.c
index 1bd328d..0b99533 100644
--- a/arch/arm/mach-kirkwood/board-nsa310.c
+++ b/arch/arm/mach-kirkwood/board-nsa310.c
@@ -10,11 +10,8 @@
 
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/i2c.h>
-
-#include <asm/mach-types.h>
-#include <asm/mach/arch.h>
 #include <mach/kirkwood.h>
+#include <linux/of.h>
 #include "common.h"
 #include "mpp.h"
 
@@ -40,11 +37,7 @@ static unsigned int nsa310_mpp_config[] __initdata = {
 
 void __init nsa310_init(void)
 {
-	u32 dev, rev;
-
 	kirkwood_mpp_conf(nsa310_mpp_config);
-
-	kirkwood_pcie_id(&dev, &rev);
 }
 
 static int __init nsa310_pci_init(void)
-- 
1.8.1.1
