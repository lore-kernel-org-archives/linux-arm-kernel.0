From: arun.murthy@stericsson.com (Arun Murthy)
Date: Wed, 6 Oct 2010 21:29:18 +0530
Subject: [PATCHv3 7/7] pwm: Modify backlight and led Kconfig aligning to pwm
	core
In-Reply-To: <1286380758-14063-1-git-send-email-arun.murthy@stericsson.com>
References: <1286380758-14063-1-git-send-email-arun.murthy@stericsson.com>
Message-ID: <1286380758-14063-8-git-send-email-arun.murthy@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PWM based backlight and led driver will not be calling the pwm drivers
through the pwm core driver and hence adding dependancy on the same.

Signed-off-by: Arun Murthy <arun.murthy@stericsson.com>
Acked-by: Linus Walleij <linus.walleij@stericsson.com>
---
 drivers/leds/Kconfig            |    2 +-
 drivers/pwm/Kconfig             |    2 --
 drivers/video/backlight/Kconfig |    2 +-
 3 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index e411262..8324dd0 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -244,7 +244,7 @@ config LEDS_DAC124S085
 
 config LEDS_PWM
 	tristate "PWM driven LED Support"
-	depends on HAVE_PWM
+	depends on HAVE_PWM || PWM_DEVICES
 	help
 	  This option enables support for pwm driven LEDs
 
diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index e4ef199..4acc0a6 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -19,7 +19,6 @@ if PWM_DEVICES
 config AB8500_PWM
 	bool "AB8500 PWM support"
 	depends on AB8500_CORE
-	select HAVE_PWM
 	help
 	  This driver exports functions to enable/disble/config/free Pulse
 	  Width Modulation in the Analog Baseband Chip AB8500.
@@ -28,7 +27,6 @@ config AB8500_PWM
 config TWL6030_PWM
 	tristate "TWL6030 PWM (Pulse Width Modulator) Support"
 	depends on TWL4030_CORE
-	select HAVE_PWM
 	default n
 	help
 	  Say yes here if you want support for TWL6030 PWM.
diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
index e54a337..c07fc16 100644
--- a/drivers/video/backlight/Kconfig
+++ b/drivers/video/backlight/Kconfig
@@ -217,7 +217,7 @@ config BACKLIGHT_CARILLO_RANCH
 
 config BACKLIGHT_PWM
 	tristate "Generic PWM based Backlight Driver"
-	depends on HAVE_PWM
+	depends on HAVE_PWM || PWM_DEVICES
 	help
 	  If you have a LCD backlight adjustable by PWM, say Y to enable
 	  this driver.
-- 
1.7.2.dirty
