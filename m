From: josh.cartwright@ni.com (Josh Cartwright)
Date: Thu, 29 Nov 2012 19:37:30 -0600
Subject: [PATCH] ARM: sunxi: add missing include for mdelay()
Message-ID: <20121130013730.GA30592@beefymiracle.amer.corp.natinst.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

  CC      arch/arm/mach-sunxi/sunxi.o
./arch/arm/mach-sunxi/sunxi.c: In function 'sunxi_restart':
./arch/arm/mach-sunxi/sunxi.c:55:3: error: implicit declaration of function 'mdelay' [-Werror=implicit-function-declaration]

Signed-off-by: Josh Cartwright <josh.cartwright@ni.com>
---
Fixes multiplatform build error seen with today's linux-next-20121129.

 arch/arm/mach-sunxi/sunxi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-sunxi/sunxi.c b/arch/arm/mach-sunxi/sunxi.c
index dc634ae..9be910f 100644
--- a/arch/arm/mach-sunxi/sunxi.c
+++ b/arch/arm/mach-sunxi/sunxi.c
@@ -10,6 +10,7 @@
  * warranty of any kind, whether express or implied.
  */
 
+#include <linux/delay.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/of_address.h>
-- 
1.8.0
