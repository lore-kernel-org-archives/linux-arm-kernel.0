From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Wed, 27 Dec 2017 08:39:40 +0530
Subject: [PATCH 09/11 v3] ARM: orion5x: constify gpio_led
Message-ID: <c5483727438a3cccbaec5d62b20b01fde67a589a.1514343098.git.arvind.yadav.cs@gmail.com>
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
changes in v3: 
              Fix build error.

 arch/arm/mach-orion5x/board-d2net.c      | 2 +-
 arch/arm/mach-orion5x/dns323-setup.c     | 2 +-
 arch/arm/mach-orion5x/ls_hgl-setup.c     | 2 +-
 arch/arm/mach-orion5x/mv2120-setup.c     | 2 +-
 arch/arm/mach-orion5x/net2big-setup.c    | 2 +-
 arch/arm/mach-orion5x/rd88f5182-setup.c  | 2 +-
 arch/arm/mach-orion5x/ts409-setup.c      | 2 +-
 arch/arm/mach-orion5x/wrt350n-v2-setup.c | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-orion5x/board-d2net.c b/arch/arm/mach-orion5x/board-d2net.c
index a89376a..55d6562 100644
--- a/arch/arm/mach-orion5x/board-d2net.c
+++ b/arch/arm/mach-orion5x/board-d2net.c
@@ -54,7 +54,7 @@
 #define D2NET_GPIO_BLUE_LED_BLINK_CTRL	16
 #define D2NET_GPIO_BLUE_LED_OFF		23
 
-static struct gpio_led d2net_leds[] = {
+static const struct gpio_led d2net_leds[] = {
 	{
 		.name = "d2net:blue:sata",
 		.default_trigger = "default-on",
diff --git a/arch/arm/mach-orion5x/dns323-setup.c b/arch/arm/mach-orion5x/dns323-setup.c
index cd483bf..792a56e 100644
--- a/arch/arm/mach-orion5x/dns323-setup.c
+++ b/arch/arm/mach-orion5x/dns323-setup.c
@@ -221,7 +221,7 @@ static struct gpio_led dns323ab_leds[] = {
 };
 
 
-static struct gpio_led dns323c_leds[] = {
+static const struct gpio_led dns323c_leds[] = {
 	{
 		.name = "power:blue",
 		.gpio = DNS323C_GPIO_LED_POWER,
diff --git a/arch/arm/mach-orion5x/ls_hgl-setup.c b/arch/arm/mach-orion5x/ls_hgl-setup.c
index 47ba6e0..c394281 100644
--- a/arch/arm/mach-orion5x/ls_hgl-setup.c
+++ b/arch/arm/mach-orion5x/ls_hgl-setup.c
@@ -86,7 +86,7 @@ static struct i2c_board_info __initdata ls_hgl_i2c_rtc = {
 #define LS_HGL_GPIO_LED_PWR     0
 
 
-static struct gpio_led ls_hgl_led_pins[] = {
+static const struct gpio_led ls_hgl_led_pins[] = {
 	{
 		.name	   = "alarm:red",
 		.gpio	   = LS_HGL_GPIO_LED_ALARM,
diff --git a/arch/arm/mach-orion5x/mv2120-setup.c b/arch/arm/mach-orion5x/mv2120-setup.c
index 2bf8ec7..724c08a 100644
--- a/arch/arm/mach-orion5x/mv2120-setup.c
+++ b/arch/arm/mach-orion5x/mv2120-setup.c
@@ -136,7 +136,7 @@ static struct i2c_board_info __initdata mv2120_i2c_rtc = {
 	.irq	= 0,
 };
 
-static struct gpio_led mv2120_led_pins[] = {
+static const struct gpio_led mv2120_led_pins[] = {
 	{
 		.name			= "mv2120:blue:health",
 		.gpio			= 0,
diff --git a/arch/arm/mach-orion5x/net2big-setup.c b/arch/arm/mach-orion5x/net2big-setup.c
index bf6be4c..7d59888 100644
--- a/arch/arm/mach-orion5x/net2big-setup.c
+++ b/arch/arm/mach-orion5x/net2big-setup.c
@@ -214,7 +214,7 @@ static void __init net2big_sata_power_init(void)
 #define NET2BIG_GPIO_SATA0_BLUE_LED	17
 #define NET2BIG_GPIO_SATA1_BLUE_LED	13
 
-static struct gpio_led net2big_leds[] = {
+static const struct gpio_led net2big_leds[] = {
 	{
 		.name = "net2big:red:power",
 		.gpio = NET2BIG_GPIO_PWR_RED_LED,
diff --git a/arch/arm/mach-orion5x/rd88f5182-setup.c b/arch/arm/mach-orion5x/rd88f5182-setup.c
index fe3e67c..e2f280d 100644
--- a/arch/arm/mach-orion5x/rd88f5182-setup.c
+++ b/arch/arm/mach-orion5x/rd88f5182-setup.c
@@ -83,7 +83,7 @@ static struct platform_device rd88f5182_nor_flash = {
 
 #define RD88F5182_GPIO_LED		0
 
-static struct gpio_led rd88f5182_gpio_led_pins[] = {
+static const struct gpio_led rd88f5182_gpio_led_pins[] = {
 	{
 		.name		= "rd88f5182:cpu",
 		.default_trigger = "cpu0",
diff --git a/arch/arm/mach-orion5x/ts409-setup.c b/arch/arm/mach-orion5x/ts409-setup.c
index a77613b..a31f6848 100644
--- a/arch/arm/mach-orion5x/ts409-setup.c
+++ b/arch/arm/mach-orion5x/ts409-setup.c
@@ -169,7 +169,7 @@ static struct i2c_board_info __initdata qnap_ts409_i2c_rtc = {
  * LEDs attached to GPIO
  ****************************************************************************/
 
-static struct gpio_led ts409_led_pins[] = {
+static const struct gpio_led ts409_led_pins[] = {
 	{
 		.name		= "ts409:red:sata1",
 		.gpio		= 4,
diff --git a/arch/arm/mach-orion5x/wrt350n-v2-setup.c b/arch/arm/mach-orion5x/wrt350n-v2-setup.c
index 9250bb2..5493d73 100644
--- a/arch/arm/mach-orion5x/wrt350n-v2-setup.c
+++ b/arch/arm/mach-orion5x/wrt350n-v2-setup.c
@@ -29,7 +29,7 @@
 /*
  * LEDs attached to GPIO
  */
-static struct gpio_led wrt350n_v2_led_pins[] = {
+static const struct gpio_led wrt350n_v2_led_pins[] = {
 	{
 		.name		= "wrt350nv2:green:power",
 		.gpio		= 0,
-- 
2.7.4
