From: arnd@arndb.de (Arnd Bergmann)
Date: Thu,  8 May 2014 16:56:30 +0200
Subject: [PATCH] regulator: arizona-ldo1: add missing #include
In-Reply-To: <1399560990-1402858-1-git-send-email-arnd@arndb.de>
References: <1399560433-1402630-1-git-send-email-arnd@arndb.de>
 <1399560990-1402858-1-git-send-email-arnd@arndb.de>
Message-ID: <1399560990-1402858-19-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit 2cce4be9e6b8 "regulator: arizona-ldo1: Add processing of init_data
from device tree" added a call to of_get_child_by_name() but
did not add an #include to the header file declaring that function.

I got a build error when doing randconfig testing on this, which
is fixed by this patch to include of.h.

drivers/regulator/arizona-ldo1.c:192:2: error: implicit declaration of function 'of_get_child_by_name' [-Werror=implicit-function-declaration]
drivers/regulator/arizona-ldo1.c:193:2: error: implicit declaration of function 'of_parse_phandle' [-Werror=implicit-function-declaration]
drivers/regulator/arizona-ldo1.c:213:2: error: implicit declaration of function 'of_node_put' [-Werror=implicit-function-declaration]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: Mark Brown <broonie@linaro.org>
---
 drivers/regulator/arizona-ldo1.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/arizona-ldo1.c b/drivers/regulator/arizona-ldo1.c
index d3787e1..04f262a 100644
--- a/drivers/regulator/arizona-ldo1.c
+++ b/drivers/regulator/arizona-ldo1.c
@@ -16,6 +16,7 @@
 #include <linux/init.h>
 #include <linux/bitops.h>
 #include <linux/err.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/machine.h>
-- 
1.8.3.2
