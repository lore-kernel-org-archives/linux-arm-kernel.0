From: m.krawczuk@partner.samsung.com (Mateusz Krawczuk)
Date: Mon, 23 Sep 2013 12:14:49 +0200
Subject: [PATCH] DT: if dt is available don't use s3c_arch_init
Message-ID: <1379931289-29384-1-git-send-email-m.krawczuk@partner.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It prevents from executing platform code, when booting from device tree.

Signed-off-by: Mateusz Krawczuk <m.krawczuk@partner.samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/plat-samsung/init.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/plat-samsung/init.c b/arch/arm/plat-samsung/init.c
index aa9511b..0ace02d 100644
--- a/arch/arm/plat-samsung/init.c
+++ b/arch/arm/plat-samsung/init.c
@@ -20,6 +20,7 @@
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/ioport.h>
+#include <linux/of.h>
 #include <linux/serial_core.h>
 #include <linux/platform_device.h>
 #include <linux/of.h>
@@ -152,6 +153,8 @@ static int __init s3c_arch_init(void)
 {
 	int ret;
 
+	if (of_have_populated_dt())
+		return 0;
 	// do the correct init for cpu
 
 	if (cpu == NULL) {
-- 
1.8.1.2
