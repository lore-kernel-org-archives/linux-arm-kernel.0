From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 25 Nov 2015 16:37:53 +0100
Subject: [PATCH 5/7] ARM: mmp: make plat-pxa build standalone
In-Reply-To: <1448465875-435039-1-git-send-email-arnd@arndb.de>
References: <1448465875-435039-1-git-send-email-arnd@arndb.de>
Message-ID: <1448465875-435039-6-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ssp.c driver in plat-pxa is the only remaining file including a
mach/*.h header from mmp. It actually doesn't need mach/hardware.h at
all, so we can remove the #include.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/plat-pxa/ssp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/plat-pxa/ssp.c b/arch/arm/plat-pxa/ssp.c
index daa1a65f2eb7..ba13f793fbce 100644
--- a/arch/arm/plat-pxa/ssp.c
+++ b/arch/arm/plat-pxa/ssp.c
@@ -34,7 +34,6 @@
 #include <linux/of_device.h>
 
 #include <asm/irq.h>
-#include <mach/hardware.h>
 
 static DEFINE_MUTEX(ssp_lock);
 static LIST_HEAD(ssp_list);
-- 
2.1.0.rc2
