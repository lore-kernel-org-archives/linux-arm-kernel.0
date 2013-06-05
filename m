From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  5 Jun 2013 17:27:01 +0900
Subject: [PATCH 130/130] ARM: shmobile: marzen: Use RCAR_GP_PIN macro
In-Reply-To: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
References: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1370420821-28420-131-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Replace hardcoded pin numbers with the RCAR_GP_PIN macro to make the
code match the documentation.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-marzen.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-marzen.c b/arch/arm/mach-shmobile/board-marzen.c
index 9105285..fac9e0f 100644
--- a/arch/arm/mach-shmobile/board-marzen.c
+++ b/arch/arm/mach-shmobile/board-marzen.c
@@ -28,6 +28,7 @@
 #include <linux/leds.h>
 #include <linux/dma-mapping.h>
 #include <linux/pinctrl/machine.h>
+#include <linux/platform_data/gpio-rcar.h>
 #include <linux/regulator/fixed.h>
 #include <linux/regulator/machine.h>
 #include <linux/smsc911x.h>
@@ -173,15 +174,15 @@ static struct platform_device usb_phy_device = {
 static struct gpio_led marzen_leds[] = {
 	{
 		.name		= "led2",
-		.gpio		= 157,
+		.gpio		= RCAR_GP_PIN(4, 29),
 		.default_state	= LEDS_GPIO_DEFSTATE_ON,
 	}, {
 		.name		= "led3",
-		.gpio		= 158,
+		.gpio		= RCAR_GP_PIN(4, 30),
 		.default_state	= LEDS_GPIO_DEFSTATE_ON,
 	}, {
 		.name		= "led4",
-		.gpio		= 159,
+		.gpio		= RCAR_GP_PIN(4, 31),
 		.default_state	= LEDS_GPIO_DEFSTATE_ON,
 	},
 };
-- 
1.8.2.1
