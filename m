From: mcuos.com@gmail.com (Wan ZongShun)
Date: Mon, 23 Nov 2009 15:48:51 +0800
Subject: [PATCH] NUC900: add spi resource plaform_data structure initialization
Message-ID: <4B0A3E63.1080904@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Russell,

Add spi resource plaform_data structure initialization.

Signed-off-by: Wan ZongShun <mcuos.com@gmail.com>

---
 arch/arm/mach-w90x900/dev.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-w90x900/dev.c b/arch/arm/mach-w90x900/dev.c
index 2a6f98d..51f17b7 100644
--- a/arch/arm/mach-w90x900/dev.c
+++ b/arch/arm/mach-w90x900/dev.c
@@ -32,6 +32,7 @@
 #include <asm/mach-types.h>
 
 #include <mach/regs-serial.h>
+#include <mach/nuc900_spi.h>
 #include <mach/map.h>
 
 #include "cpu.h"
@@ -196,6 +197,18 @@ static struct platform_device nuc900_device_emc = {
 
 /* SPI device */
 
+static struct w90p910_spi_info nuc900_spiflash_data = {
+	.num_cs		= 1,
+	.lsb		= 0,
+	.txneg		= 1,
+	.rxneg		= 0,
+	.divider	= 24,
+	.sleep		= 0,
+	.txnum		= 0,
+	.txbitlen	= 1,
+	.bus_num	= 0,
+};
+
 static struct resource nuc900_spi_resource[] = {
 	[0] = {
 		.start = W90X900_PA_I2C + SPIOFFSET,
@@ -214,6 +227,9 @@ static struct platform_device nuc900_device_spi = {
 	.id		= -1,
 	.num_resources	= ARRAY_SIZE(nuc900_spi_resource),
 	.resource	= nuc900_spi_resource,
+	.dev		= {
+				.platform_data = &nuc900_spiflash_data,
+			}
 };
 
 /* spi device, spi flash info */
-- 
1.5.6.3
