From: computersforpeace@gmail.com (Brian Norris)
Date: Mon, 29 Sep 2014 18:35:28 -0700
Subject: [PATCH 3/5] ARM: rockchip: drop unnecessary include
In-Reply-To: <1412040930-16864-1-git-send-email-computersforpeace@gmail.com>
References: <1412040930-16864-1-git-send-email-computersforpeace@gmail.com>
Message-ID: <1412040930-16864-4-git-send-email-computersforpeace@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

<asm/cp15.h> is only being included because of the implicit requirements
of v7_exit_coherency_flush(). Now that the implicit include is provided
for us, we can drop it from our explicit list.

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: linux-rockchip at lists.infradead.org
---
 arch/arm/mach-rockchip/platsmp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-rockchip/platsmp.c b/arch/arm/mach-rockchip/platsmp.c
index 189684f55927..9b72e84e6494 100644
--- a/arch/arm/mach-rockchip/platsmp.c
+++ b/arch/arm/mach-rockchip/platsmp.c
@@ -21,7 +21,6 @@
 #include <linux/of_address.h>
 
 #include <asm/cacheflush.h>
-#include <asm/cp15.h>
 #include <asm/smp_scu.h>
 #include <asm/smp_plat.h>
 #include <asm/mach/map.h>
-- 
1.9.1
