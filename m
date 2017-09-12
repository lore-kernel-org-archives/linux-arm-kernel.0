From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 12 Sep 2017 14:31:48 +0200
Subject: [PATCH] w90p910_ether: include linux/interrupt.h
Message-ID: <20170912123227.3418786-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A randconfig build caused a compile failure:

drivers/net/ethernet/nuvoton/w90p910_ether.c: In function 'w90p910_ether_close':
drivers/net/ethernet/nuvoton/w90p910_ether.c:580:2: error: implicit declaration of function 'free_irq'; did you mean 'free_uid'? [-Werror=implicit-function-declaration]

Adding the correct include fixes the problem.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/nuvoton/w90p910_ether.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/nuvoton/w90p910_ether.c b/drivers/net/ethernet/nuvoton/w90p910_ether.c
index 89ab786da25f..4a67c55aa9f1 100644
--- a/drivers/net/ethernet/nuvoton/w90p910_ether.c
+++ b/drivers/net/ethernet/nuvoton/w90p910_ether.c
@@ -11,6 +11,7 @@
 
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
 #include <linux/mii.h>
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
-- 
2.9.0
