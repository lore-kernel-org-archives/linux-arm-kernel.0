From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 30 May 2012 12:47:21 +0800
Subject: [PATCH 03/22] ARM: ux500: Disable SMSC911x platform code registration
 when DT is enabled
In-Reply-To: <1338353260-10097-1-git-send-email-lee.jones@linaro.org>
References: <1338353260-10097-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1338353260-10097-4-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now the SCMC911x is correctly enabled in Device Tree, there is no need
to continue registering it from platform code. In fact, if we continue
doing so, the system will throw an error on boot.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/board-mop500.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index ff04010..f8e0f1d 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -679,7 +679,6 @@ static struct platform_device *snowball_platform_devs[] __initdata = {
 static struct platform_device *snowball_of_platform_devs[] __initdata = {
 	&snowball_led_dev,
 	&snowball_key_dev,
-	&snowball_sbnet_dev,
 	&ab8500_device,
 };
 
@@ -887,7 +886,7 @@ static void __init u8500_init_machine(void)
 		 * Devices to be DT:ed:
 		 *   snowball_led_dev   = todo
 		 *   snowball_key_dev   = todo
-		 *   snowball_sbnet_dev = todo
+		 *   snowball_sbnet_dev = done
 		 *   ab8500_device      = todo
 		 */
 		platform_add_devices(snowball_of_platform_devs,
-- 
1.7.9.5
