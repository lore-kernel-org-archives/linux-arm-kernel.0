From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 14 Jul 2010 00:44:27 +0200
Subject: [PATCH 2/2] ARM: PL022 SSP platform data for the Versatile
Message-ID: <1279061067-20573-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds platform data for the PL022 to the ARM Versatile reference
design, and adds the necessary clock definition.

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 arch/arm/mach-versatile/core.c |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-versatile/core.c b/arch/arm/mach-versatile/core.c
index 3dff864..f3a0e07 100644
--- a/arch/arm/mach-versatile/core.c
+++ b/arch/arm/mach-versatile/core.c
@@ -28,6 +28,7 @@
 #include <linux/amba/clcd.h>
 #include <linux/amba/pl061.h>
 #include <linux/amba/mmci.h>
+#include <linux/amba/pl022.h>
 #include <linux/io.h>
 #include <linux/gfp.h>
 
@@ -425,6 +426,9 @@ static struct clk_lookup lookups[] = {
 	}, {	/* MMC1 */
 		.dev_id		= "fpga:0b",
 		.clk		= &ref24_clk,
+	}, {	/* SSP */
+		.dev_id		= "dev:f4",
+		.clk		= &ref24_clk,
 	}, {	/* CLCD */
 		.dev_id		= "dev:20",
 		.clk		= &osc4_clk,
@@ -703,6 +707,12 @@ static struct pl061_platform_data gpio1_plat_data = {
 	.irq_base	= IRQ_GPIO1_START,
 };
 
+static struct pl022_ssp_controller ssp0_plat_data = {
+	.bus_id = 0,
+	.enable_dma = 0,
+	.num_chipselect = 1,
+};
+
 #define AACI_IRQ	{ IRQ_AACI, NO_IRQ }
 #define AACI_DMA	{ 0x80, 0x81 }
 #define MMCI0_IRQ	{ IRQ_MMCI0A,IRQ_SIC_MMCI0B }
@@ -772,7 +782,7 @@ AMBA_DEVICE(sci0,  "dev:f0",  SCI,      NULL);
 AMBA_DEVICE(uart0, "dev:f1",  UART0,    NULL);
 AMBA_DEVICE(uart1, "dev:f2",  UART1,    NULL);
 AMBA_DEVICE(uart2, "dev:f3",  UART2,    NULL);
-AMBA_DEVICE(ssp0,  "dev:f4",  SSP,      NULL);
+AMBA_DEVICE(ssp0,  "dev:f4",  SSP,      &ssp0_plat_data);
 
 static struct amba_device *amba_devs[] __initdata = {
 	&dmac_device,
-- 
1.7.1
