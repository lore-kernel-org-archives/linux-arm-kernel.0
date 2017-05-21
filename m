From: wsa@the-dreams.de (Wolfram Sang)
Date: Sun, 21 May 2017 23:57:26 +0200
Subject: [PATCH 2/3] gpio: pcf857x: move header file out of I2C realm
In-Reply-To: <20170521215727.1243-1-wsa@the-dreams.de>
References: <20170521215727.1243-1-wsa@the-dreams.de>
Message-ID: <20170521215727.1243-3-wsa@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

include/linux/i2c is not for client devices. Move the header file to a
more appropriate location.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 arch/arm/mach-davinci/board-da830-evm.c        | 2 +-
 arch/arm/mach-davinci/board-dm644x-evm.c       | 2 +-
 arch/arm/mach-davinci/board-dm646x-evm.c       | 2 +-
 arch/arm/mach-pxa/balloon3.c                   | 2 +-
 arch/arm/mach-pxa/stargate2.c                  | 2 +-
 arch/mips/ath79/mach-pb44.c                    | 2 +-
 drivers/gpio/gpio-pcf857x.c                    | 2 +-
 include/linux/{i2c => platform_data}/pcf857x.h | 0
 8 files changed, 7 insertions(+), 7 deletions(-)
 rename include/linux/{i2c => platform_data}/pcf857x.h (100%)

diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
index 58075627c6df3e..f673cd7a676658 100644
--- a/arch/arm/mach-davinci/board-da830-evm.c
+++ b/arch/arm/mach-davinci/board-da830-evm.c
@@ -17,7 +17,7 @@
 #include <linux/gpio/machine.h>
 #include <linux/platform_device.h>
 #include <linux/i2c.h>
-#include <linux/i2c/pcf857x.h>
+#include <linux/platform_data/pcf857x.h>
 #include <linux/platform_data/at24.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c b/arch/arm/mach-davinci/board-dm644x-evm.c
index 20f1874a5657e2..70e00dbeec9694 100644
--- a/arch/arm/mach-davinci/board-dm644x-evm.c
+++ b/arch/arm/mach-davinci/board-dm644x-evm.c
@@ -14,7 +14,7 @@
 #include <linux/platform_device.h>
 #include <linux/gpio.h>
 #include <linux/i2c.h>
-#include <linux/i2c/pcf857x.h>
+#include <linux/platform_data/pcf857x.h>
 #include <linux/platform_data/at24.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/nand.h>
diff --git a/arch/arm/mach-davinci/board-dm646x-evm.c b/arch/arm/mach-davinci/board-dm646x-evm.c
index cb176826d1cbe4..ca69d0b96a4f07 100644
--- a/arch/arm/mach-davinci/board-dm646x-evm.c
+++ b/arch/arm/mach-davinci/board-dm646x-evm.c
@@ -23,7 +23,7 @@
 #include <linux/platform_device.h>
 #include <linux/i2c.h>
 #include <linux/platform_data/at24.h>
-#include <linux/i2c/pcf857x.h>
+#include <linux/platform_data/pcf857x.h>
 
 #include <media/i2c/tvp514x.h>
 #include <media/i2c/adv7343.h>
diff --git a/arch/arm/mach-pxa/balloon3.c b/arch/arm/mach-pxa/balloon3.c
index d452a49c039647..1467c1d1e54194 100644
--- a/arch/arm/mach-pxa/balloon3.c
+++ b/arch/arm/mach-pxa/balloon3.c
@@ -27,7 +27,7 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
 #include <linux/types.h>
-#include <linux/i2c/pcf857x.h>
+#include <linux/platform_data/pcf857x.h>
 #include <linux/i2c/pxa-i2c.h>
 #include <linux/mtd/nand.h>
 #include <linux/mtd/physmap.h>
diff --git a/arch/arm/mach-pxa/stargate2.c b/arch/arm/mach-pxa/stargate2.c
index 7b6610e9dae46c..2d45d18b1a5e0a 100644
--- a/arch/arm/mach-pxa/stargate2.c
+++ b/arch/arm/mach-pxa/stargate2.c
@@ -26,7 +26,7 @@
 #include <linux/mtd/partitions.h>
 
 #include <linux/i2c/pxa-i2c.h>
-#include <linux/i2c/pcf857x.h>
+#include <linux/platform_data/pcf857x.h>
 #include <linux/platform_data/at24.h>
 #include <linux/smc91x.h>
 #include <linux/gpio.h>
diff --git a/arch/mips/ath79/mach-pb44.c b/arch/mips/ath79/mach-pb44.c
index 67b980d94fb7aa..be78298dffb4f3 100644
--- a/arch/mips/ath79/mach-pb44.c
+++ b/arch/mips/ath79/mach-pb44.c
@@ -12,7 +12,7 @@
 #include <linux/platform_device.h>
 #include <linux/i2c.h>
 #include <linux/i2c-gpio.h>
-#include <linux/i2c/pcf857x.h>
+#include <linux/platform_data/pcf857x.h>
 
 #include "machtypes.h"
 #include "dev-gpio-buttons.h"
diff --git a/drivers/gpio/gpio-pcf857x.c b/drivers/gpio/gpio-pcf857x.c
index 8ddf9302ce3b07..a4fd78b9c0e4e3 100644
--- a/drivers/gpio/gpio-pcf857x.c
+++ b/drivers/gpio/gpio-pcf857x.c
@@ -20,7 +20,7 @@
 
 #include <linux/gpio.h>
 #include <linux/i2c.h>
-#include <linux/i2c/pcf857x.h>
+#include <linux/platform_data/pcf857x.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
diff --git a/include/linux/i2c/pcf857x.h b/include/linux/platform_data/pcf857x.h
similarity index 100%
rename from include/linux/i2c/pcf857x.h
rename to include/linux/platform_data/pcf857x.h
-- 
2.11.0
