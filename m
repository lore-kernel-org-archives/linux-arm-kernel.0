From: mcrapet@gmail.com (Matthieu Crapet)
Date: Wed, 06 Jan 2010 07:40:28 +0100
Subject: [PATCH] ep93xx: register the pwm devices on the ts-72xx dev boards
Message-ID: <4B44305C.3030305@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ep93xx: register the pwm devices on the ts-72xx dev boards

Add the platform init code to register the pwm devices that exist
on the various ts-72xx development boards.

Signed-off-by: Matthieu Crapet <mcrapet@gmail.com>
Cc: H Hartley Sweeten <hsweeten@visionengravers.com>

---

diff --git a/arch/arm/mach-ep93xx/ts72xx.c b/arch/arm/mach-ep93xx/ts72xx.c
index 259f782..1a831a5 100644
--- a/arch/arm/mach-ep93xx/ts72xx.c
+++ b/arch/arm/mach-ep93xx/ts72xx.c
@@ -177,6 +177,9 @@ static void __init ts72xx_init_machine(void)
        platform_device_register(&ts72xx_rtc_device);
 
        ep93xx_register_eth(&ts72xx_eth_data, 1);
+
+       /* PWM1 is DIO_6 on TS-72xx header */
+       ep93xx_register_pwm(0, 1);
 }
 
 MACHINE_START(TS72XX, "Technologic Systems TS-72xx SBC")
