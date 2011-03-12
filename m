From: replabrobin@gmail.com (Robin Becker)
Date: Sat, 12 Mar 2011 15:32:45 +0000
Subject: [PATCH] arm: mach-kirkwood: add led in sheevaplug-setup.c
Message-ID: <1299943965-8626-1-git-send-email-robin@reportlab.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Robin Becker <replabrobin@gmail.com>

This patch adds a second, red, led for the standard sheevaplug.
The sheeva_esata mpp config is left unchanged.

Tested on a standard sheevaplug

Signed-off-by: Robin Becker <robin@reportlab.com>
---
 arch/arm/mach-kirkwood/sheevaplug-setup.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-kirkwood/sheevaplug-setup.c b/arch/arm/mach-kirkwood/sheevaplug-setup.c
index d2eec35..247aa92 100644
--- a/arch/arm/mach-kirkwood/sheevaplug-setup.c
+++ b/arch/arm/mach-kirkwood/sheevaplug-setup.c
@@ -58,6 +58,12 @@ static struct mvsdio_platform_data sheeva_esata_mvsdio_data = {
 
 static struct gpio_led sheevaplug_led_pins[] = {
 	{
+		.name			= "plug:red:misc",
+		.default_trigger	= "none",
+		.gpio			= 46,
+		.active_low		= 1,
+	},
+	{
 		.name			= "plug:green:health",
 		.default_trigger	= "default-on",
 		.gpio			= 49,
@@ -80,6 +86,7 @@ static struct platform_device sheevaplug_leds = {
 
 static unsigned int sheevaplug_mpp_config[] __initdata = {
 	MPP29_GPIO,	/* USB Power Enable */
+	MPP46_GPIO,	/* LED Red */
 	MPP49_GPIO,	/* LED */
 	0
 };
-- 
1.7.4.1
