From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Mon, 30 Sep 2013 15:07:47 +0200
Subject: [PATCH] ARM: shmobile: ape6evm: fix incorrect placement of __initdata
 tag
Message-ID: <26068642.Hn7T63a6ac@amdc1032>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

__initdata tag should be placed between the variable name and equal
sign for the variable to be placed in the intended .init.data section.

In this particular case __initdata is incorrect as ape6evm_keys_pdata
can be used as a platform data for gpio-keys driver which can be
compiled as module.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-shmobile/board-ape6evm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/board-ape6evm.c b/arch/arm/mach-shmobile/board-ape6evm.c
index 7627385..8954f55 100644
--- a/arch/arm/mach-shmobile/board-ape6evm.c
+++ b/arch/arm/mach-shmobile/board-ape6evm.c
@@ -86,7 +86,7 @@ static struct gpio_keys_button gpio_buttons[] = {
 	GPIO_KEY(KEY_VOLUMEDOWN,	329,	"S21"),
 };
 
-static struct __initdata gpio_keys_platform_data ape6evm_keys_pdata = {
+static struct gpio_keys_platform_data ape6evm_keys_pdata = {
 	.buttons	= gpio_buttons,
 	.nbuttons	= ARRAY_SIZE(gpio_buttons),
 };
-- 
1.8.2.3
