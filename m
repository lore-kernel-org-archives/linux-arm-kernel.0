From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 11 Aug 2014 11:52:48 +0900
Subject: [PATCH repost 4/5] ARM: shmobile: armadillo800eva-reference: Do not
 use r8a7740_add_standard_devices_dt()
In-Reply-To: <1407725569-31413-1-git-send-email-horms+renesas@verge.net.au>
References: <1407725569-31413-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1407725569-31413-5-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that r8a7740_add_standard_devices_dt() is just a wrapper for
of_platform_populate() call the latter directly.

This is in preparation for removing r8a7740_add_standard_devices_dt().

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-armadillo800eva-reference.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva-reference.c b/arch/arm/mach-shmobile/board-armadillo800eva-reference.c
index c392632..ea8a781 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva-reference.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva-reference.c
@@ -24,6 +24,7 @@
 #include <linux/gpio.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
+#include <linux/of_platform.h>
 
 #include <asm/mach/arch.h>
 #include <asm/hardware/cache-l2x0.h>
@@ -170,7 +171,7 @@ static void __init eva_init(void)
 	l2x0_init(IOMEM(0xf0002000), 0x00400000, 0xc20f0fff);
 #endif
 
-	r8a7740_add_standard_devices_dt();
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 
 	r8a7740_pm_init();
 }
-- 
2.0.1
