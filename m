From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Tue, 26 Dec 2017 12:07:14 +0530
Subject: [PATCH 11/11 v2] ARM: pxa: constify gpio_led
In-Reply-To: <2b8dd58f9d6dae7f0fa04694e8147524be9300ea.1514267721.git.arvind.yadav.cs@gmail.com>
References: <2b8dd58f9d6dae7f0fa04694e8147524be9300ea.1514267721.git.arvind.yadav.cs@gmail.com>
Message-ID: <19018a2025cdb6bd9994e534ed216790fe5e226e.1514267721.git.arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

gpio_led are not supposed to change at runtime.
struct gpio_led_platform_data working with const gpio_led
provided by <linux/leds.h>. So mark the non-const structs
as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
changes in v2:
              The GPIO LED driver can be built as a module, it can
              be loaded after the init sections have gone away.
              So removed '__initconst'. Resolve auto build test ERROR.

 arch/arm/mach-pxa/balloon3.c  | 4 ++--
 arch/arm/mach-pxa/corgi.c     | 2 +-
 arch/arm/mach-pxa/csb701.c    | 2 +-
 arch/arm/mach-pxa/magician.c  | 2 +-
 arch/arm/mach-pxa/mioa701.c   | 2 +-
 arch/arm/mach-pxa/palmld.c    | 2 +-
 arch/arm/mach-pxa/palmz72.c   | 2 +-
 arch/arm/mach-pxa/pcm027.c    | 2 +-
 arch/arm/mach-pxa/raumfeld.c  | 4 ++--
 arch/arm/mach-pxa/spitz.c     | 2 +-
 arch/arm/mach-pxa/stargate2.c | 2 +-
 arch/arm/mach-pxa/tosa.c      | 2 +-
 arch/arm/mach-pxa/trizeps4.c  | 2 +-
 arch/arm/mach-pxa/zeus.c      | 2 +-
 14 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-pxa/balloon3.c b/arch/arm/mach-pxa/balloon3.c
index d6d92f3..abcfb19 100644
--- a/arch/arm/mach-pxa/balloon3.c
+++ b/arch/arm/mach-pxa/balloon3.c
@@ -387,7 +387,7 @@ static unsigned long balloon3_led_pin_config[] __initdata = {
 	GPIO10_GPIO,	/* Heartbeat LED */
 };
 
-struct gpio_led balloon3_gpio_leds[] = {
+const struct gpio_led balloon3_gpio_leds[] = {
 	{
 		.name			= "balloon3:green:idle",
 		.default_trigger	= "heartbeat",
@@ -414,7 +414,7 @@ static struct platform_device balloon3_leds = {
 	}
 };
 
-struct gpio_led balloon3_pcf_gpio_leds[] = {
+const struct gpio_led balloon3_pcf_gpio_leds[] = {
 	{
 		.name			= "balloon3:green:led0",
 		.gpio			= BALLOON3_PCF_GPIO_LED0,
diff --git a/arch/arm/mach-pxa/corgi.c b/arch/arm/mach-pxa/corgi.c
index 7270f0db..6d6ded0 100644
--- a/arch/arm/mach-pxa/corgi.c
+++ b/arch/arm/mach-pxa/corgi.c
@@ -450,7 +450,7 @@ static struct platform_device corgi_gpio_keys_device = {
 /*
  * Corgi LEDs
  */
-static struct gpio_led corgi_gpio_leds[] = {
+static const struct gpio_led corgi_gpio_leds[] = {
 	{
 		.name			= "corgi:amber:charge",
 		.default_trigger	= "sharpsl-charge",
diff --git a/arch/arm/mach-pxa/csb701.c b/arch/arm/mach-pxa/csb701.c
index 527c9fd..b062b50 100644
--- a/arch/arm/mach-pxa/csb701.c
+++ b/arch/arm/mach-pxa/csb701.c
@@ -24,7 +24,7 @@ static struct gpio_keys_platform_data csb701_gpio_keys_data = {
 	.nbuttons = ARRAY_SIZE(csb701_buttons),
 };
 
-static struct gpio_led csb701_leds[] = {
+static const struct gpio_led csb701_leds[] = {
 	{
 		.name	= "csb701:yellow:heartbeat",
 		.default_trigger = "heartbeat",
diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach-pxa/magician.c
index 7f3566c..505c9cc 100644
--- a/arch/arm/mach-pxa/magician.c
+++ b/arch/arm/mach-pxa/magician.c
@@ -424,7 +424,7 @@ static struct platform_device backlight = {
  * GPIO LEDs, Phone keys backlight, vibra
  */
 
-static struct gpio_led gpio_leds[] = {
+static const struct gpio_led gpio_leds[] = {
 	{
 		.name = "magician::vibra",
 		.default_trigger = "none",
diff --git a/arch/arm/mach-pxa/mioa701.c b/arch/arm/mach-pxa/mioa701.c
index 8a5d049..88115f0 100644
--- a/arch/arm/mach-pxa/mioa701.c
+++ b/arch/arm/mach-pxa/mioa701.c
@@ -274,7 +274,7 @@ static struct gpio_keys_platform_data mioa701_gpio_keys_data = {
  */
 #define ONE_LED(_gpio, _name) \
 { .gpio = (_gpio), .name = (_name), .active_low = true }
-static struct gpio_led gpio_leds[] = {
+static const struct gpio_led gpio_leds[] = {
 	ONE_LED(GPIO10_LED_nCharging, "mioa701:charging"),
 	ONE_LED(GPIO97_LED_nBlue, "mioa701:blue"),
 	ONE_LED(GPIO98_LED_nOrange, "mioa701:orange"),
diff --git a/arch/arm/mach-pxa/palmld.c b/arch/arm/mach-pxa/palmld.c
index 980f284..eb5992b 100644
--- a/arch/arm/mach-pxa/palmld.c
+++ b/arch/arm/mach-pxa/palmld.c
@@ -246,7 +246,7 @@ static inline void palmld_keys_init(void) {}
  * LEDs
  ******************************************************************************/
 #if defined(CONFIG_LEDS_GPIO) || defined(CONFIG_LEDS_GPIO_MODULE)
-struct gpio_led gpio_leds[] = {
+const struct gpio_led gpio_leds[] = {
 {
 	.name			= "palmld:green:led",
 	.default_trigger	= "none",
diff --git a/arch/arm/mach-pxa/palmz72.c b/arch/arm/mach-pxa/palmz72.c
index 5877e54..99c5bf2 100644
--- a/arch/arm/mach-pxa/palmz72.c
+++ b/arch/arm/mach-pxa/palmz72.c
@@ -182,7 +182,7 @@ static inline void palmz72_kpc_init(void) {}
  * LEDs
  ******************************************************************************/
 #if defined(CONFIG_LEDS_GPIO) || defined(CONFIG_LEDS_GPIO_MODULE)
-static struct gpio_led gpio_leds[] = {
+static const struct gpio_led gpio_leds[] = {
 	{
 		.name			= "palmz72:green:led",
 		.default_trigger	= "none",
diff --git a/arch/arm/mach-pxa/pcm027.c b/arch/arm/mach-pxa/pcm027.c
index ccca9f7..7dbea136 100644
--- a/arch/arm/mach-pxa/pcm027.c
+++ b/arch/arm/mach-pxa/pcm027.c
@@ -177,7 +177,7 @@ static struct platform_device pcm027_flash = {
 
 #ifdef CONFIG_LEDS_GPIO
 
-static struct gpio_led pcm027_led[] = {
+static const struct gpio_led pcm027_led[] = {
 	{
 		.name = "led0:red",	/* FIXME */
 		.gpio = PCM027_LED_CPU
diff --git a/arch/arm/mach-pxa/raumfeld.c b/arch/arm/mach-pxa/raumfeld.c
index 9d662fe..0d86dd6 100644
--- a/arch/arm/mach-pxa/raumfeld.c
+++ b/arch/arm/mach-pxa/raumfeld.c
@@ -468,7 +468,7 @@ static struct platform_device raumfeld_gpio_keys_device = {
  * GPIO LEDs
  */
 
-static struct gpio_led raumfeld_leds[] = {
+static const struct gpio_led raumfeld_leds[] = {
 	{
 		.name		= "raumfeld:1",
 		.gpio		= GPIO_LED1,
@@ -558,7 +558,7 @@ static struct platform_device raumfeld_pwm_backlight_device = {
 };
 
 /* LT3593 controlled backlight */
-static struct gpio_led raumfeld_lt3593_led = {
+static const struct gpio_led raumfeld_lt3593_led = {
 	.name		= "backlight",
 	.gpio		= mfp_to_gpio(MFP_PIN_GPIO17),
 	.default_state	= LEDS_GPIO_DEFSTATE_ON,
diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
index 67d66c7..f7a23f4 100644
--- a/arch/arm/mach-pxa/spitz.c
+++ b/arch/arm/mach-pxa/spitz.c
@@ -456,7 +456,7 @@ static inline void spitz_keys_init(void) {}
  * LEDs
  ******************************************************************************/
 #if defined(CONFIG_LEDS_GPIO) || defined(CONFIG_LEDS_GPIO_MODULE)
-static struct gpio_led spitz_gpio_leds[] = {
+static const struct gpio_led spitz_gpio_leds[] = {
 	{
 		.name			= "spitz:amber:charge",
 		.default_trigger	= "sharpsl-charge",
diff --git a/arch/arm/mach-pxa/stargate2.c b/arch/arm/mach-pxa/stargate2.c
index 6b7df6f..afa70f9 100644
--- a/arch/arm/mach-pxa/stargate2.c
+++ b/arch/arm/mach-pxa/stargate2.c
@@ -441,7 +441,7 @@ static struct pxamci_platform_data imote2_mci_platform_data = {
 	.gpio_power = -1,
 };
 
-static struct gpio_led imote2_led_pins[] = {
+static const struct gpio_led imote2_led_pins[] = {
 	{
 		.name       =  "imote2:red",
 		.gpio       = 103,
diff --git a/arch/arm/mach-pxa/tosa.c b/arch/arm/mach-pxa/tosa.c
index 6a386fd..c551b76 100644
--- a/arch/arm/mach-pxa/tosa.c
+++ b/arch/arm/mach-pxa/tosa.c
@@ -548,7 +548,7 @@ static struct platform_device tosa_gpio_keys_device = {
 /*
  * Tosa LEDs
  */
-static struct gpio_led tosa_gpio_leds[] = {
+static const struct gpio_led tosa_gpio_leds[] = {
 	{
 		.name			= "tosa:amber:charge",
 		.default_trigger	= "main-battery-charging",
diff --git a/arch/arm/mach-pxa/trizeps4.c b/arch/arm/mach-pxa/trizeps4.c
index 3dd13b4..a151c98 100644
--- a/arch/arm/mach-pxa/trizeps4.c
+++ b/arch/arm/mach-pxa/trizeps4.c
@@ -235,7 +235,7 @@ static struct platform_device dm9000_device = {
 /****************************************************************************
  * LED's on GPIO pins of PXA
  ****************************************************************************/
-static struct gpio_led trizeps4_led[] = {
+static const struct gpio_led trizeps4_led[] = {
 #ifdef STATUS_LEDS_ON_STUART_PINS
 	{
 		.name = "led0:orange:heartbeat",	/* */
diff --git a/arch/arm/mach-pxa/zeus.c b/arch/arm/mach-pxa/zeus.c
index ecbcaee..40e036d 100644
--- a/arch/arm/mach-pxa/zeus.c
+++ b/arch/arm/mach-pxa/zeus.c
@@ -438,7 +438,7 @@ static struct spi_board_info zeus_spi_board_info[] = {
 };
 
 /* Leds */
-static struct gpio_led zeus_leds[] = {
+static const struct gpio_led zeus_leds[] = {
 	[0] = {
 		.name		 = "zeus:yellow:1",
 		.default_trigger = "heartbeat",
-- 
2.7.4
