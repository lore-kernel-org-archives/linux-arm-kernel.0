From: jacmet@sunsite.dk (Peter Korsgaard)
Date: Tue, 28 Jun 2011 14:49:17 +0200
Subject: [PATCH 5/5] mach-s3c2410: remove unused spi-gpio.h file
In-Reply-To: <1309265357-15879-1-git-send-email-jacmet@sunsite.dk>
References: <1309265357-15879-1-git-send-email-jacmet@sunsite.dk>
Message-ID: <1309265357-15879-6-git-send-email-jacmet@sunsite.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Not used anymore as the spi_s3c24xx_gpio driver is gone (replaced by
the generic spi-gpio).

Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
---
 arch/arm/mach-s3c2410/include/mach/spi-gpio.h |   28 -------------------------
 1 files changed, 0 insertions(+), 28 deletions(-)
 delete mode 100644 arch/arm/mach-s3c2410/include/mach/spi-gpio.h

diff --git a/arch/arm/mach-s3c2410/include/mach/spi-gpio.h b/arch/arm/mach-s3c2410/include/mach/spi-gpio.h
deleted file mode 100644
index dcef228..0000000
--- a/arch/arm/mach-s3c2410/include/mach/spi-gpio.h
+++ /dev/null
@@ -1,28 +0,0 @@
-/* arch/arm/mach-s3c2410/include/mach/spi-gpio.h
- *
- * Copyright (c) 2006 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *
- * S3C2410 - SPI Controller platform_device info
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#ifndef __ASM_ARCH_SPIGPIO_H
-#define __ASM_ARCH_SPIGPIO_H __FILE__
-
-struct s3c2410_spigpio_info {
-	unsigned long		 pin_clk;
-	unsigned long		 pin_mosi;
-	unsigned long		 pin_miso;
-
-	int			 num_chipselect;
-	int			 bus_num;
-
-	void (*chip_select)(struct s3c2410_spigpio_info *spi, int cs);
-};
-
-
-#endif /* __ASM_ARCH_SPIGPIO_H */
-- 
1.7.5.4
