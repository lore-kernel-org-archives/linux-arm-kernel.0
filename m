From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Thu, 17 Mar 2011 20:04:57 +0200
Subject: [PATCH] ARM: S3C24XX: H1940: RX1950: Change default LED triggers
Message-ID: <1300385097-18283-1-git-send-email-anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change LED triggers to mimic WinMobile behavior:
red blinking when battery is charging,
orange solid when battery is charged.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 arch/arm/mach-s3c2410/mach-h1940.c  |    5 +++--
 arch/arm/mach-s3c2440/mach-rx1950.c |   23 ++++++++++++-----------
 2 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-s3c2410/mach-h1940.c b/arch/arm/mach-s3c2410/mach-h1940.c
index 5531c4c..84a1422 100644
--- a/arch/arm/mach-s3c2410/mach-h1940.c
+++ b/arch/arm/mach-s3c2410/mach-h1940.c
@@ -437,13 +437,14 @@ EXPORT_SYMBOL(h1940_led_blink_set);
 static struct gpio_led h1940_leds_desc[] = {
 	{
 		.name			= "Green",
-		.default_trigger	= "main-battery-charging-or-full",
+		.default_trigger	= "main-battery-full",
 		.gpio			= H1940_LATCH_LED_GREEN,
 		.retain_state_suspended	= 1,
 	},
 	{
 		.name			= "Red",
-		.default_trigger	= "main-battery-full",
+		.default_trigger
+			= "main-battery-charging-blink-full-solid",
 		.gpio			= H1940_LATCH_LED_RED,
 		.retain_state_suspended	= 1,
 	},
diff --git a/arch/arm/mach-s3c2440/mach-rx1950.c b/arch/arm/mach-s3c2440/mach-rx1950.c
index 2d2f4e4..20beee3 100644
--- a/arch/arm/mach-s3c2440/mach-rx1950.c
+++ b/arch/arm/mach-s3c2440/mach-rx1950.c
@@ -311,22 +311,23 @@ static int rx1950_led_blink_set(unsigned gpio, int state,
 
 static struct gpio_led rx1950_leds_desc[] = {
 	{
-		.name				= "Green",
-		.default_trigger	= "main-battery-charging-or-full",
-		.gpio				= S3C2410_GPA(6),
-		.retain_state_suspended		= 1,
+		.name			= "Green",
+		.default_trigger	= "main-battery-full",
+		.gpio			= S3C2410_GPA(6),
+		.retain_state_suspended	= 1,
 	},
 	{
-		.name				= "Red",
-		.default_trigger	= "main-battery-full",
-		.gpio				= S3C2410_GPA(7),
-		.retain_state_suspended		= 1,
+		.name			= "Red",
+		.default_trigger
+			= "main-battery-charging-blink-full-solid",
+		.gpio			= S3C2410_GPA(7),
+		.retain_state_suspended	= 1,
 	},
 	{
-		.name				= "Blue",
+		.name			= "Blue",
 		.default_trigger	= "rx1950-acx-mem",
-		.gpio				= S3C2410_GPA(11),
-		.retain_state_suspended		= 1,
+		.gpio			= S3C2410_GPA(11),
+		.retain_state_suspended	= 1,
 	},
 };
 
-- 
1.7.4.1
