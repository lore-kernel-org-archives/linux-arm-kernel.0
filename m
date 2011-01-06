From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Thu,  6 Jan 2011 21:52:51 +0200
Subject: [PATCH 6/7] ARM: S3C2442: RX1950: Retain LEDs state in suspend
In-Reply-To: <1294343572-28518-1-git-send-email-anarsoul@gmail.com>
References: <1294343572-28518-1-git-send-email-anarsoul@gmail.com>
Message-ID: <1294343572-28518-7-git-send-email-anarsoul@gmail.com>
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
index eab6ae5..e7cc993 100644
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
