From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 17 May 2012 14:45:10 +0100
Subject: [PATCH 05/18] ARM: ux500: Enable the user LED on Snowball via Device
 Tree
In-Reply-To: <1337262323-27692-1-git-send-email-lee.jones@linaro.org>
References: <1337262323-27692-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1337262323-27692-6-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables and illuminates the user_led on the
Snowball low-cost development board using DT. It also
removes initialisation carried out from platform code.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/snowball.dts     |    1 +
 arch/arm/mach-ux500/board-mop500.c |    3 +--
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/snowball.dts b/arch/arm/boot/dts/snowball.dts
index 56f8a76..579c304 100644
--- a/arch/arm/boot/dts/snowball.dts
+++ b/arch/arm/boot/dts/snowball.dts
@@ -67,6 +67,7 @@
 		used-led {
 			label = "user_led";
 			gpios = <&gpio4 14 0x4>;
+			default-state = "on";
 		};
 	};
 
diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index b8331fe..433045d 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -600,7 +600,6 @@ static struct platform_device *snowball_platform_devs[] __initdata = {
 };
 
 static struct platform_device *snowball_of_platform_devs[] __initdata = {
-	&snowball_led_dev,
 	&snowball_key_dev,
 	&ab8500_device,
 };
@@ -814,7 +813,7 @@ static void __init u8500_init_machine(void)
 
 		/*
 		 * Devices to be DT:ed:
-		 *   snowball_led_dev   = todo
+		 *   snowball_led_dev   = done
 		 *   snowball_key_dev   = todo
 		 *   snowball_sbnet_dev = done
 		 *   ab8500_device      = todo
-- 
1.7.9.5
