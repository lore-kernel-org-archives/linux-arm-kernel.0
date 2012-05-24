From: pebolle@tiscali.nl (Paul Bolle)
Date: Thu, 24 May 2012 16:30:29 +0200
Subject: [PATCH] at91: set i2c_board_info.type to "ds1339" directly
Message-ID: <1337869829.22505.15.camel@x61.thuisdomein>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The single element of the cpu9krea_i2c_devices array (of type struct
i2c_board_info) has its "type" member set twice. First to "rtc-ds1307"
(through the I2C_BOARD_INFO macro) and then directly to "ds1339". Just
set it (once and) directly to "ds1339" instead.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
0) This is just something I stumbled upon while researching a different
issue. (An unrelated board apparently uses a ds1307 compatible RTC but
the kernel doesn't see it. I hope to submit a patch for that issue one
of these days.)

1) Entirely untested. I'm unsure what toolchain is needed to compile
this and I am certain that I don't have this hardware.

2) This is apparently legal. Doesn't gcc issue a warning for this?

 arch/arm/mach-at91/board-cpu9krea.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-at91/board-cpu9krea.c b/arch/arm/mach-at91/board-cpu9krea.c
index 5f3680e..f680755 100644
--- a/arch/arm/mach-at91/board-cpu9krea.c
+++ b/arch/arm/mach-at91/board-cpu9krea.c
@@ -281,8 +281,7 @@ static struct gpio_led cpu9krea_leds[] = {
 
 static struct i2c_board_info __initdata cpu9krea_i2c_devices[] = {
 	{
-		I2C_BOARD_INFO("rtc-ds1307", 0x68),
-		.type	= "ds1339",
+		I2C_BOARD_INFO("ds1339", 0x68),
 	},
 };
 
-- 
1.7.7.6
