From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 25 Jan 2013 18:53:52 +0000
Subject: [PATCH] mfd/vexpress: vexpress_sysreg_setup must not be __init
Message-ID: <1359140032-6039-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch 52666298a 'mfd: vexpress-sysreg: Don't skip initialization
on probe' adds a call to vexpress_sysreg_setup from a non-__init
function, so this also has to lose its __init annotation.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: arm at kernel.org
---
 drivers/mfd/vexpress-sysreg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/vexpress-sysreg.c b/drivers/mfd/vexpress-sysreg.c
index 77048b1..558c292 100644
--- a/drivers/mfd/vexpress-sysreg.c
+++ b/drivers/mfd/vexpress-sysreg.c
@@ -313,7 +313,7 @@ static void vexpress_sysreg_config_complete(unsigned long data)
 }
 
 
-void __init vexpress_sysreg_setup(struct device_node *node)
+void vexpress_sysreg_setup(struct device_node *node)
 {
 	if (WARN_ON(!vexpress_sysreg_base))
 		return;
-- 
1.8.0
