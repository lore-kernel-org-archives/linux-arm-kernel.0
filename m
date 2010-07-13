From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Tue, 13 Jul 2010 23:12:57 +0300
Subject: [PATCH v3 2/5] rx1950: add LEDs device
In-Reply-To: <1279051980-6316-1-git-send-email-anarsoul@gmail.com>
References: <1279051980-6316-1-git-send-email-anarsoul@gmail.com>
Message-ID: <1279051980-6316-3-git-send-email-anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 arch/arm/mach-s3c2440/mach-rx1950.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c2440/mach-rx1950.c b/arch/arm/mach-s3c2440/mach-rx1950.c
index 8603b57..55b806a 100644
--- a/arch/arm/mach-s3c2440/mach-rx1950.c
+++ b/arch/arm/mach-s3c2440/mach-rx1950.c
@@ -126,6 +126,11 @@ static struct s3c2410fb_display rx1950_display = {
 
 };
 
+static struct platform_device rx1950_device_leds = {
+	.name             = "rx1950-leds",
+	.id               = -1,
+};
+
 static struct s3c2410fb_mach_info rx1950_lcd_cfg = {
 	.displays = &rx1950_display,
 	.num_displays = 1,
@@ -502,6 +507,7 @@ static struct platform_device *rx1950_devices[] __initdata = {
 	&s3c_device_timer[1],
 	&rx1950_backlight,
 	&rx1950_device_gpiokeys,
+	&rx1950_device_leds,
 };
 
 static struct clk *rx1950_clocks[] __initdata = {
-- 
1.7.1.1
