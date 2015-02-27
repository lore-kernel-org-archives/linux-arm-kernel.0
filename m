From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 27 Feb 2015 14:31:27 +0100
Subject: [PATCH 7/8] ARM: mmp: make plat-pxa build standalone
In-Reply-To: <1425043775-3106827-1-git-send-email-arnd@arndb.de>
References: <1425043775-3106827-1-git-send-email-arnd@arndb.de>
Message-ID: <1425043887-3107341-1-git-send-email-arnd@arndb.de>
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
index ad9529cc4203..257790259d2b 100644
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
