From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Wed,  8 Dec 2010 22:10:19 +0200
Subject: [PATCH] ARM: S3C2442: rx1950: Retain LEDs state in suspend
Message-ID: <1291839019-27336-1-git-send-email-anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

s3c_adc_battery uses LEDs to indicate charging process,
retain LEDs state in suspend, otherwise user have no information if PDA
battery is charging after he put it to suspend.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 arch/arm/mach-s3c2440/mach-rx1950.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c2440/mach-rx1950.c b/arch/arm/mach-s3c2440/mach-rx1950.c
index e0622bb..2c41254 100644
--- a/arch/arm/mach-s3c2440/mach-rx1950.c
+++ b/arch/arm/mach-s3c2440/mach-rx1950.c
@@ -268,16 +268,19 @@ static struct gpio_led rx1950_leds_desc[] = {
 		.name				= "Green",
 		.default_trigger	= "main-battery-charging-or-full",
 		.gpio				= S3C2410_GPA(6),
+		.retain_state_suspended		= 1,
 	},
 	{
 		.name				= "Red",
 		.default_trigger	= "main-battery-full",
 		.gpio				= S3C2410_GPA(7),
+		.retain_state_suspended		= 1,
 	},
 	{
 		.name				= "Blue",
 		.default_trigger	= "rx1950-acx-mem",
 		.gpio				= S3C2410_GPA(11),
+		.retain_state_suspended		= 1,
 	},
 };
 
-- 
1.7.3.2
