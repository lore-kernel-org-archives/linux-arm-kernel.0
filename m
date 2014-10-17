From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 17 Oct 2014 10:26:37 +0200
Subject: [PATCHv2 2/3] ARM: at91: remove mach/atmel-mci.h
In-Reply-To: <1413534398-22645-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1413534398-22645-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1413534398-22645-3-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the generic platform_data header file instead of mach/atmel-mci.h

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/mach-at91/at91sam9g45_devices.c    |  2 +-
 arch/arm/mach-at91/include/mach/atmel-mci.h | 17 -----------------
 2 files changed, 1 insertion(+), 18 deletions(-)
 delete mode 100644 arch/arm/mach-at91/include/mach/atmel-mci.h

diff --git a/arch/arm/mach-at91/at91sam9g45_devices.c b/arch/arm/mach-at91/at91sam9g45_devices.c
index 21ab782cc8e9..06ecbafd01ee 100644
--- a/arch/arm/mach-at91/at91sam9g45_devices.c
+++ b/arch/arm/mach-at91/at91sam9g45_devices.c
@@ -19,6 +19,7 @@
 #include <linux/i2c-gpio.h>
 #include <linux/atmel-mci.h>
 #include <linux/platform_data/crypto-atmel.h>
+#include <linux/platform_data/mmc-atmel-mci.h>
 
 #include <linux/platform_data/at91_adc.h>
 
@@ -30,7 +31,6 @@
 #include <mach/at91_matrix.h>
 #include <mach/at91sam9_smc.h>
 #include <linux/platform_data/dma-atmel.h>
-#include <mach/atmel-mci.h>
 #include <mach/hardware.h>
 
 #include <media/atmel-isi.h>
diff --git a/arch/arm/mach-at91/include/mach/atmel-mci.h b/arch/arm/mach-at91/include/mach/atmel-mci.h
deleted file mode 100644
index 3069e4135573..000000000000
--- a/arch/arm/mach-at91/include/mach/atmel-mci.h
+++ /dev/null
@@ -1,17 +0,0 @@
-#ifndef __MACH_ATMEL_MCI_H
-#define __MACH_ATMEL_MCI_H
-
-#include <linux/platform_data/dma-atmel.h>
-
-/**
- * struct mci_dma_data - DMA data for MCI interface
- */
-struct mci_dma_data {
-	struct at_dma_slave	sdata;
-};
-
-/* accessor macros */
-#define	slave_data_ptr(s)	(&(s)->sdata)
-#define find_slave_dev(s)	((s)->sdata.dma_dev)
-
-#endif /* __MACH_ATMEL_MCI_H */
-- 
1.9.1
