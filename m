From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Mar 2014 20:29:30 +0100
Subject: [PATCH 33/62] ARM: pxa: remove broken balloon3_gpio_vbus reference
In-Reply-To: <1395257399-359545-1-git-send-email-arnd@arndb.de>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
Message-ID: <1395257399-359545-34-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

balloon3_udc_init() tries to register a balloon3_gpio_vbus
device, but this has never been defined in the mainline
kernel. To avoid the obvious build failure when this function
is enabled, remove the bogus reference here.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Eric Miao <eric.y.miao@gmail.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Daniel Mack <zonque@gmail.com>
---
 arch/arm/mach-pxa/balloon3.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-pxa/balloon3.c b/arch/arm/mach-pxa/balloon3.c
index 2f71b3f..43596e0 100644
--- a/arch/arm/mach-pxa/balloon3.c
+++ b/arch/arm/mach-pxa/balloon3.c
@@ -331,7 +331,6 @@ static struct pxa2xx_udc_mach_info balloon3_udc_info __initdata = {
 static void __init balloon3_udc_init(void)
 {
 	pxa_set_udc_info(&balloon3_udc_info);
-	platform_device_register(&balloon3_gpio_vbus);
 }
 #else
 static inline void balloon3_udc_init(void) {}
-- 
1.8.3.2
