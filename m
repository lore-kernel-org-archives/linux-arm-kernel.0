From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Fri, 15 Mar 2013 16:30:26 +0800
Subject: [PATCH] ARM: mmp: add platform_device head file in gplugd
Message-ID: <1363336226-23175-1-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arch/arm/mach-mmp/gplugd.c: In function ?gplugd_init?:
arch/arm/mach-mmp/gplugd.c:188:2: error: implicit declaration of
function ?platform_device_register?
[-Werror=implicit-function-declaration]
cc1: some warnings being treated as errors
make[1]: *** [arch/arm/mach-mmp/gplugd.o] Error 1
make: *** [arch/arm/mach-mmp] Error 2

So append platform_device.h to resolve build issue.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 arch/arm/mach-mmp/gplugd.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-mmp/gplugd.c b/arch/arm/mach-mmp/gplugd.c
index d1e2d59..f62b68d 100644
--- a/arch/arm/mach-mmp/gplugd.c
+++ b/arch/arm/mach-mmp/gplugd.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/init.h>
+#include <linux/platform_device.h>
 #include <linux/gpio.h>
 
 #include <asm/mach/arch.h>
-- 
1.7.10.4
