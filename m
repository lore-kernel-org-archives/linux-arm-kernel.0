From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Tue, 26 Dec 2017 12:07:11 +0530
Subject: [PATCH 08/11 v2] ARM: OMAP1: constify gpio_led
In-Reply-To: <2b8dd58f9d6dae7f0fa04694e8147524be9300ea.1514267721.git.arvind.yadav.cs@gmail.com>
References: <2b8dd58f9d6dae7f0fa04694e8147524be9300ea.1514267721.git.arvind.yadav.cs@gmail.com>
Message-ID: <c00efa8371f63d6b888590ea66767c832088cd1a.1514267721.git.arvind.yadav.cs@gmail.com>
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
              So removed '__initconst'.

 arch/arm/mach-omap1/board-h2.c        | 2 +-
 arch/arm/mach-omap1/board-h3.c        | 2 +-
 arch/arm/mach-omap1/board-htcherald.c | 2 +-
 arch/arm/mach-omap1/board-osk.c       | 4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap1/board-h2.c b/arch/arm/mach-omap1/board-h2.c
index ab51f85..9aeb8ad 100644
--- a/arch/arm/mach-omap1/board-h2.c
+++ b/arch/arm/mach-omap1/board-h2.c
@@ -274,7 +274,7 @@ static struct platform_device h2_kp_device = {
 	.resource	= h2_kp_resources,
 };
 
-static struct gpio_led h2_gpio_led_pins[] = {
+static const struct gpio_led h2_gpio_led_pins[] = {
 	{
 		.name		= "h2:red",
 		.default_trigger = "heartbeat",
diff --git a/arch/arm/mach-omap1/board-h3.c b/arch/arm/mach-omap1/board-h3.c
index ad339f5..2edcd63 100644
--- a/arch/arm/mach-omap1/board-h3.c
+++ b/arch/arm/mach-omap1/board-h3.c
@@ -326,7 +326,7 @@ static struct spi_board_info h3_spi_board_info[] __initdata = {
 	},
 };
 
-static struct gpio_led h3_gpio_led_pins[] = {
+static const struct gpio_led h3_gpio_led_pins[] = {
 	{
 		.name		= "h3:red",
 		.default_trigger = "heartbeat",
diff --git a/arch/arm/mach-omap1/board-htcherald.c b/arch/arm/mach-omap1/board-htcherald.c
index 67d4669..e6a79fd 100644
--- a/arch/arm/mach-omap1/board-htcherald.c
+++ b/arch/arm/mach-omap1/board-htcherald.c
@@ -292,7 +292,7 @@ static struct platform_device herald_gpiokeys_device = {
 };
 
 /* LEDs for the Herald.  These connect to the HTCPLD GPIO device. */
-static struct gpio_led gpio_leds[] = {
+static const struct gpio_led gpio_leds[] = {
 	{"dpad",        NULL, HTCPLD_GPIO_LED_DPAD,        0, 0, LEDS_GPIO_DEFSTATE_OFF},
 	{"kbd",         NULL, HTCPLD_GPIO_LED_KBD,         0, 0, LEDS_GPIO_DEFSTATE_OFF},
 	{"vibrate",     NULL, HTCPLD_GPIO_LED_VIBRATE,     0, 0, LEDS_GPIO_DEFSTATE_OFF},
diff --git a/arch/arm/mach-omap1/board-osk.c b/arch/arm/mach-omap1/board-osk.c
index c66372e..e2277b5 100644
--- a/arch/arm/mach-omap1/board-osk.c
+++ b/arch/arm/mach-omap1/board-osk.c
@@ -167,7 +167,7 @@ static struct platform_device *osk5912_devices[] __initdata = {
 	&osk5912_cf_device,
 };
 
-static struct gpio_led tps_leds[] = {
+static const struct gpio_led tps_leds[] = {
 	/* NOTE:  D9 and D2 have hardware blink support.
 	 * Also, D9 requires non-battery power.
 	 */
@@ -385,7 +385,7 @@ static struct platform_device osk5912_lcd_device = {
 	.id		= -1,
 };
 
-static struct gpio_led mistral_gpio_led_pins[] = {
+static const struct gpio_led mistral_gpio_led_pins[] = {
 	{
 		.name		= "mistral:red",
 		.default_trigger = "heartbeat",
-- 
2.7.4
