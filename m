From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Mon, 30 Sep 2013 17:34:36 +0200
Subject: [PATCH v2] ARM: shmobile: ape6evm: fix incorrect placement of
 __initdata tag
Message-ID: <1959578.PFsrHiTtYY@amdc1032>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

__initdata tag should be placed between the variable name and equal
sign for the variable to be placed in the intended .init.data section.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
v2:
- use __initdata as it is OK to do it

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
+static struct gpio_keys_platform_data ape6evm_keys_pdata __initdata = {
 	.buttons	= gpio_buttons,
 	.nbuttons	= ARRAY_SIZE(gpio_buttons),
 };
-- 
1.8.2.3
