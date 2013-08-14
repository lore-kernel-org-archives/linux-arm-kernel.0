From: khilman@linaro.org (Kevin Hilman)
Date: Wed, 14 Aug 2013 16:05:02 -0700
Subject: [PATCH] regmap: Add another missing header for !CONFIG_REGMAP stubs
Message-ID: <1376521502-9370-1-git-send-email-khilman@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The use of WARN_ON() needs the definitions from bug.h, without it
you can get:

include/linux/regmap.h: In function 'regmap_write':
include/linux/regmap.h:525:2: error: implicit declaration of function 'WARN_ONCE' [-Werror=implicit-function-declaration]

Cc: Mark Brown <broonie@linaro.org> 
Signed-off-by: Kevin Hilman <khilman@linaro.org> 
--- 
This one has been showing up in linux-next for a bit under various ARM
defconfigs (specifically ape6evm_defconfig and lager_defconfig)u

 include/linux/regmap.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index bafda87..a10380b 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -16,6 +16,7 @@
 #include <linux/list.h>
 #include <linux/rbtree.h>
 #include <linux/err.h>
+#include <linux/bug.h>
 
 struct module;
 struct device;
-- 
1.8.3
