From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 09 Aug 2011 09:05:41 +0100
Subject: [PATCH 04/13] ARM: gpio: at91: convert drivers to use asm/gpio.h
	rather than mach/gpio.h
In-Reply-To: <20110809080411.GA1831@n2100.arm.linux.org.uk>
References: <20110809080411.GA1831@n2100.arm.linux.org.uk>
Message-ID: <E1QqhJl-0003aC-13@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/ata/pata_at91.c           |    2 +-
 drivers/ide/at91_ide.c            |    2 +-
 drivers/net/arm/at91_ether.c      |    2 +-
 drivers/spi/spi-atmel.c           |    2 +-
 drivers/tty/serial/atmel_serial.c |    2 +-
 drivers/video/atmel_lcdfb.c       |    2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/ata/pata_at91.c b/drivers/ata/pata_at91.c
index 960c725..3f4c261 100644
--- a/drivers/ata/pata_at91.c
+++ b/drivers/ata/pata_at91.c
@@ -30,7 +30,7 @@
 
 #include <mach/at91sam9_smc.h>
 #include <mach/board.h>
-#include <mach/gpio.h>
+#include <asm/gpio.h>
 
 #define DRV_NAME		"pata_at91"
 #define DRV_VERSION		"0.3"
diff --git a/drivers/ide/at91_ide.c b/drivers/ide/at91_ide.c
index 000a78e..6dede8f 100644
--- a/drivers/ide/at91_ide.c
+++ b/drivers/ide/at91_ide.c
@@ -28,7 +28,7 @@
 #include <linux/platform_device.h>
 
 #include <mach/board.h>
-#include <mach/gpio.h>
+#include <asm/gpio.h>
 #include <mach/at91sam9_smc.h>
 
 #define DRV_NAME "at91_ide"
diff --git a/drivers/net/arm/at91_ether.c b/drivers/net/arm/at91_ether.c
index 29dc435..48b4ec1 100644
--- a/drivers/net/arm/at91_ether.c
+++ b/drivers/net/arm/at91_ether.c
@@ -35,7 +35,7 @@
 #include <asm/mach-types.h>
 
 #include <mach/at91rm9200_emac.h>
-#include <mach/gpio.h>
+#include <asm/gpio.h>
 #include <mach/board.h>
 
 #include "at91_ether.h"
diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 82dee9a..d3bff42 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -22,7 +22,7 @@
 
 #include <asm/io.h>
 #include <mach/board.h>
-#include <mach/gpio.h>
+#include <asm/gpio.h>
 #include <mach/cpu.h>
 
 /* SPI register offsets */
diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index af9b781..b8a00ae 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -46,7 +46,7 @@
 
 #ifdef CONFIG_ARM
 #include <mach/cpu.h>
-#include <mach/gpio.h>
+#include <asm/gpio.h>
 #endif
 
 #define PDC_BUFFER_SIZE		512
diff --git a/drivers/video/atmel_lcdfb.c b/drivers/video/atmel_lcdfb.c
index 817ab60..dda9206 100644
--- a/drivers/video/atmel_lcdfb.c
+++ b/drivers/video/atmel_lcdfb.c
@@ -21,7 +21,7 @@
 
 #include <mach/board.h>
 #include <mach/cpu.h>
-#include <mach/gpio.h>
+#include <asm/gpio.h>
 
 #include <video/atmel_lcdc.h>
 
-- 
1.7.4.4
