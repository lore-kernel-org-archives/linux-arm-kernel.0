From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Tue, 26 Dec 2017 12:07:09 +0530
Subject: [PATCH 06/11 v2] ARM: davinci: constify gpio_led
In-Reply-To: <de0879ef47b96776e3f18a1889c41d976a677b21.1514267721.git.arvind.yadav.cs@gmail.com>
References: <de0879ef47b96776e3f18a1889c41d976a677b21.1514267721.git.arvind.yadav.cs@gmail.com>
Message-ID: <2b8dd58f9d6dae7f0fa04694e8147524be9300ea.1514267721.git.arvind.yadav.cs@gmail.com>
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

 arch/arm/mach-davinci/board-neuros-osd2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-davinci/board-neuros-osd2.c b/arch/arm/mach-davinci/board-neuros-osd2.c
index 0c02aaa..4da210a 100644
--- a/arch/arm/mach-davinci/board-neuros-osd2.c
+++ b/arch/arm/mach-davinci/board-neuros-osd2.c
@@ -128,7 +128,7 @@ static struct platform_device davinci_fb_device = {
 	.num_resources = 0,
 };
 
-static struct gpio_led ntosd2_leds[] = {
+static const struct gpio_led ntosd2_leds[] = {
 	{ .name = "led1_green", .gpio = GPIO(10), },
 	{ .name = "led1_red",   .gpio = GPIO(11), },
 	{ .name = "led2_green", .gpio = GPIO(12), },
-- 
2.7.4
