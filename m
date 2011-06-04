From: festevam@gmail.com (Fabio Estevam)
Date: Sat,  4 Jun 2011 15:23:03 -0300
Subject: [PATCH 1/2] ARM: mx5/mx51_3ds: Fix build due to missing header and
	wrong define
Message-ID: <1307211784-13353-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit b50d28 (ARM i.MX: get rid of wrong MXC_INTERNAL_IRQ usage) broke mx51_3ds build.

Fix it by adding the missing gpio header and also add the missing parenthesis for 
EXPIO_PARENT_INT definition.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-mx5/board-mx51_3ds.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mx5/board-mx51_3ds.c b/arch/arm/mach-mx5/board-mx51_3ds.c
index 288965d..befcbad 100644
--- a/arch/arm/mach-mx5/board-mx51_3ds.c
+++ b/arch/arm/mach-mx5/board-mx51_3ds.c
@@ -13,6 +13,7 @@
 #include <linux/irq.h>
 #include <linux/platform_device.h>
 #include <linux/spi/spi.h>
+#include <linux/gpio.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -26,7 +27,7 @@
 #include "devices-imx51.h"
 #include "devices.h"
 
-#define EXPIO_PARENT_INT	gpio_to_irq((IMX_GPIO_NR(1, 6))
+#define EXPIO_PARENT_INT	gpio_to_irq((IMX_GPIO_NR(1, 6)))
 #define MX51_3DS_ECSPI2_CS	(GPIO_PORTC + 28)
 
 static iomux_v3_cfg_t mx51_3ds_pads[] = {
-- 
1.7.1
