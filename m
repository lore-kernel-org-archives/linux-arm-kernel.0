From: computersforpeace@gmail.com (Brian Norris)
Date: Mon, 29 Sep 2014 18:35:30 -0700
Subject: [PATCH 5/5] ARM: brcmstb: drop unnecessary include
In-Reply-To: <1412040930-16864-1-git-send-email-computersforpeace@gmail.com>
References: <1412040930-16864-1-git-send-email-computersforpeace@gmail.com>
Message-ID: <1412040930-16864-6-git-send-email-computersforpeace@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

<asm/cp15.h> is only being included because of the implicit requirements
of v7_exit_coherency_flush(). Now that the implicit include is provided
for us, we can drop it from our explicit list.

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
Cc: Marc Carino <marc.ceeeee@gmail.com>
---
This is based on code queued for 3.18

 arch/arm/mach-bcm/platsmp-brcmstb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-bcm/platsmp-brcmstb.c b/arch/arm/mach-bcm/platsmp-brcmstb.c
index 31c87a284a34..3911ca7a0c3c 100644
--- a/arch/arm/mach-bcm/platsmp-brcmstb.c
+++ b/arch/arm/mach-bcm/platsmp-brcmstb.c
@@ -25,7 +25,6 @@
 #include <linux/mfd/syscon.h>
 
 #include <asm/cacheflush.h>
-#include <asm/cp15.h>
 #include <asm/mach-types.h>
 #include <asm/smp_plat.h>
 
-- 
1.9.1
