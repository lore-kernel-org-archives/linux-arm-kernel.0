From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Tue, 26 Dec 2017 12:07:10 +0530
Subject: [PATCH 07/11 v2] ARM: ixp4xx: constify gpio_led
In-Reply-To: <2b8dd58f9d6dae7f0fa04694e8147524be9300ea.1514267721.git.arvind.yadav.cs@gmail.com>
References: <2b8dd58f9d6dae7f0fa04694e8147524be9300ea.1514267721.git.arvind.yadav.cs@gmail.com>
Message-ID: <db84a270310dc8466cd2b78af7b193b534b031f2.1514267721.git.arvind.yadav.cs@gmail.com>
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

 arch/arm/mach-ixp4xx/dsmg600-setup.c | 2 +-
 arch/arm/mach-ixp4xx/nas100d-setup.c | 2 +-
 arch/arm/mach-ixp4xx/omixp-setup.c   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-ixp4xx/dsmg600-setup.c b/arch/arm/mach-ixp4xx/dsmg600-setup.c
index 0f5c999..77d894d 100644
--- a/arch/arm/mach-ixp4xx/dsmg600-setup.c
+++ b/arch/arm/mach-ixp4xx/dsmg600-setup.c
@@ -93,7 +93,7 @@ static struct i2c_board_info __initdata dsmg600_i2c_board_info [] = {
 	},
 };
 
-static struct gpio_led dsmg600_led_pins[] = {
+static const struct gpio_led dsmg600_led_pins[] = {
 	{
 		.name		= "dsmg600:green:power",
 		.gpio		= DSMG600_LED_PWR_GPIO,
diff --git a/arch/arm/mach-ixp4xx/nas100d-setup.c b/arch/arm/mach-ixp4xx/nas100d-setup.c
index 76dfff0..8d6bab9 100644
--- a/arch/arm/mach-ixp4xx/nas100d-setup.c
+++ b/arch/arm/mach-ixp4xx/nas100d-setup.c
@@ -72,7 +72,7 @@ static struct i2c_board_info __initdata nas100d_i2c_board_info [] = {
 	},
 };
 
-static struct gpio_led nas100d_led_pins[] = {
+static const struct gpio_led nas100d_led_pins[] = {
 	{
 		.name		= "nas100d:green:wlan",
 		.gpio		= NAS100D_LED_WLAN_GPIO,
diff --git a/arch/arm/mach-ixp4xx/omixp-setup.c b/arch/arm/mach-ixp4xx/omixp-setup.c
index 2d494b4..42c83a6 100644
--- a/arch/arm/mach-ixp4xx/omixp-setup.c
+++ b/arch/arm/mach-ixp4xx/omixp-setup.c
@@ -152,7 +152,7 @@ static struct platform_device omixp_uart = {
 	.resource		= omixp_uart_resources,
 };
 
-static struct gpio_led mic256_led_pins[] = {
+static const struct gpio_led mic256_led_pins[] = {
 	{
 		.name		= "LED-A",
 		.gpio		= 7,
-- 
2.7.4
