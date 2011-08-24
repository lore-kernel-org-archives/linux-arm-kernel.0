From: sean@mess.org (Sean Young)
Date: Wed, 24 Aug 2011 20:26:41 +0100
Subject: [PATCH 2/2] [ARM] SheevaPlug: Add the blue led
Message-ID: <1314214001-2731-2-git-send-email-sean@mess.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Also wire the green led to the right gpio. This has been tested
on the standard SheevaPlug and eSATA SheevaPlug.

Signed-off-by: Sean Young <sean@mess.org>
---
 arch/arm/mach-kirkwood/sheevaplug-setup.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-kirkwood/sheevaplug-setup.c b/arch/arm/mach-kirkwood/sheevaplug-setup.c
index 7ba2a08..47e38fb 100644
--- a/arch/arm/mach-kirkwood/sheevaplug-setup.c
+++ b/arch/arm/mach-kirkwood/sheevaplug-setup.c
@@ -60,6 +60,12 @@ static struct gpio_led sheevaplug_led_pins[] = {
 	},
 	{
 		.name			= "plug:green:health",
+		.default_trigger	= "none",
+		.gpio			= 48,
+		.active_low		= 1,
+	},
+	{
+		.name			= "plug:blue:health",
 		.default_trigger	= "default-on",
 		.gpio			= 49,
 		.active_low		= 1,
@@ -82,7 +88,8 @@ static struct platform_device sheevaplug_leds = {
 static unsigned int sheevaplug_mpp_config[] __initdata = {
 	MPP29_GPIO,	/* USB Power Enable */
 	MPP46_GPIO,	/* LED Red */
-	MPP49_GPIO,	/* LED */
+	MPP48_GPIO,	/* LED Green */
+	MPP49_GPIO,	/* LED Blue */
 	0
 };
 
-- 
1.7.2.5
