From: replabrobin@gmail.com (Robin Becker)
Date: Wed,  9 Mar 2011 13:27:19 +0000
Subject: [PATCH] stable: sheevaplug-setup.c fix LED color name and add support
	for second LED This is a patch to the sheevaplug-setup.c file
	that fixes the color name of the existing health LED. That LED
	gpio 49 is green when off and blue when on. The patch also adds
	support for the second LED that is green when off and red when
	on. Signed-off-by: Robin Becker <robin@reportlab.com>
Message-ID: <1299677239-3352-1-git-send-email-robin@reportlab.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: replabrobin <robin@reportlab.com>

---
 arch/arm/mach-kirkwood/sheevaplug-setup.c |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-kirkwood/sheevaplug-setup.c b/arch/arm/mach-kirkwood/sheevaplug-setup.c
index d2eec35..40441da 100644
--- a/arch/arm/mach-kirkwood/sheevaplug-setup.c
+++ b/arch/arm/mach-kirkwood/sheevaplug-setup.c
@@ -58,7 +58,13 @@ static struct mvsdio_platform_data sheeva_esata_mvsdio_data = {
 
 static struct gpio_led sheevaplug_led_pins[] = {
 	{
-		.name			= "plug:green:health",
+		.name			= "plug:red:misc",
+		.default_trigger	= "none",
+		.gpio			= 46,
+		.active_low		= 1,
+	},
+	{
+		.name			= "plug:blue:health",
 		.default_trigger	= "default-on",
 		.gpio			= 49,
 		.active_low		= 1,
@@ -80,13 +86,15 @@ static struct platform_device sheevaplug_leds = {
 
 static unsigned int sheevaplug_mpp_config[] __initdata = {
 	MPP29_GPIO,	/* USB Power Enable */
-	MPP49_GPIO,	/* LED */
+	MPP46_GPIO,	/* RED LED */
+	MPP49_GPIO,	/* BLUE LED */
 	0
 };
 
 static unsigned int sheeva_esata_mpp_config[] __initdata = {
 	MPP29_GPIO,	/* USB Power Enable */
 	MPP44_GPIO,	/* SD Write Protect */
+	MPP46_GPIO,	/* RED LED */
 	MPP47_GPIO,	/* SD Card Detect */
 	MPP49_GPIO,	/* LED Green */
 	0
-- 
1.7.4.1
