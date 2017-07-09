From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Sun,  9 Jul 2017 14:39:49 +0530
Subject: [PATCH] ARM: imx: constify gpio and pins.
Message-ID: <5db99a15fd0c11011e5514ebac7b8caed661ffb0.1499591373.git.arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

gpios and pins are not supposed to change at runtime. All functions
working with gpios provided by <linux/gpio.h> work with const gpio.
Pins is working with 'mxc_iomux_setup_multiple_pins(
const unsigned int *pin_list, ...)'. So mark the non-const structs as
const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 arch/arm/mach-imx/mach-mx31_3ds.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/mach-mx31_3ds.c b/arch/arm/mach-imx/mach-mx31_3ds.c
index 68c3f07..c7edba3 100644
--- a/arch/arm/mach-imx/mach-mx31_3ds.c
+++ b/arch/arm/mach-imx/mach-mx31_3ds.c
@@ -41,7 +41,7 @@
 #include "iomux-mx3.h"
 #include "ulpi.h"
 
-static int mx31_3ds_pins[] = {
+static const int mx31_3ds_pins[] = {
 	/* UART1 */
 	MX31_PIN_CTS1__CTS1,
 	MX31_PIN_RTS1__RTS1,
@@ -180,7 +180,7 @@ static struct l4f00242t03_pdata mx31_3ds_l4f00242t03_pdata = {
 #define MX31_3DS_GPIO_SDHC1_CD IOMUX_TO_GPIO(MX31_PIN_GPIO3_1)
 #define MX31_3DS_GPIO_SDHC1_BE IOMUX_TO_GPIO(MX31_PIN_GPIO3_0)
 
-static struct gpio mx31_3ds_sdhc1_gpios[] = {
+static const struct gpio mx31_3ds_sdhc1_gpios[] = {
 	{ MX31_3DS_GPIO_SDHC1_CD, GPIOF_IN, "sdhc1-card-detect" },
 	{ MX31_3DS_GPIO_SDHC1_BE, GPIOF_OUT_INIT_LOW, "sdhc1-bus-en" },
 };
-- 
2.7.4
