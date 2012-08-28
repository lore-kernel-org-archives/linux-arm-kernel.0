From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 28 Aug 2012 20:59:09 +0200
Subject: [PATCH 8/8] net: mv643xx_eth: move <linux/mv643xx_eth.h> to
 <linux/platform_data/mv643xx_eth.h>
In-Reply-To: <1346180349-25123-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1346180349-25123-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1346180349-25123-9-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Even though this platform_data header was already in <linux/...> and
not in <plat/...>, it makes sense to move it as well to
<linux/platform_data/...>.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-dove/cm-a510.c                    |    2 +-
 arch/arm/mach-dove/dove-db-setup.c              |    2 +-
 arch/arm/mach-kirkwood/board-dnskw.c            |    2 +-
 arch/arm/mach-kirkwood/board-dreamplug.c        |    2 +-
 arch/arm/mach-kirkwood/board-goflexnet.c        |    2 +-
 arch/arm/mach-kirkwood/board-ib62x0.c           |    2 +-
 arch/arm/mach-kirkwood/board-iconnect.c         |    2 +-
 arch/arm/mach-kirkwood/board-lsxl.c             |    2 +-
 arch/arm/mach-kirkwood/board-ts219.c            |    2 +-
 arch/arm/mach-kirkwood/d2net_v2-setup.c         |    2 +-
 arch/arm/mach-kirkwood/db88f6281-bp-setup.c     |    2 +-
 arch/arm/mach-kirkwood/dockstar-setup.c         |    2 +-
 arch/arm/mach-kirkwood/guruplug-setup.c         |    2 +-
 arch/arm/mach-kirkwood/mv88f6281gtw_ge-setup.c  |    2 +-
 arch/arm/mach-kirkwood/netspace_v2-setup.c      |    2 +-
 arch/arm/mach-kirkwood/netxbig_v2-setup.c       |    2 +-
 arch/arm/mach-kirkwood/openrd-setup.c           |    2 +-
 arch/arm/mach-kirkwood/rd88f6192-nas-setup.c    |    2 +-
 arch/arm/mach-kirkwood/rd88f6281-setup.c        |    2 +-
 arch/arm/mach-kirkwood/sheevaplug-setup.c       |    2 +-
 arch/arm/mach-kirkwood/t5325-setup.c            |    2 +-
 arch/arm/mach-kirkwood/ts219-setup.c            |    2 +-
 arch/arm/mach-kirkwood/ts41x-setup.c            |    2 +-
 arch/arm/mach-mv78xx0/buffalo-wxl-setup.c       |    2 +-
 arch/arm/mach-mv78xx0/db78x00-bp-setup.c        |    2 +-
 arch/arm/mach-mv78xx0/rd78x00-masa-setup.c      |    2 +-
 arch/arm/mach-orion5x/d2net-setup.c             |    2 +-
 arch/arm/mach-orion5x/db88f5281-setup.c         |    2 +-
 arch/arm/mach-orion5x/dns323-setup.c            |    2 +-
 arch/arm/mach-orion5x/edmini_v2-setup.c         |    2 +-
 arch/arm/mach-orion5x/kurobox_pro-setup.c       |    2 +-
 arch/arm/mach-orion5x/ls-chl-setup.c            |    2 +-
 arch/arm/mach-orion5x/ls_hgl-setup.c            |    2 +-
 arch/arm/mach-orion5x/lsmini-setup.c            |    2 +-
 arch/arm/mach-orion5x/mss2-setup.c              |    2 +-
 arch/arm/mach-orion5x/mv2120-setup.c            |    2 +-
 arch/arm/mach-orion5x/net2big-setup.c           |    2 +-
 arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c    |    2 +-
 arch/arm/mach-orion5x/rd88f5181l-ge-setup.c     |    2 +-
 arch/arm/mach-orion5x/rd88f5182-setup.c         |    2 +-
 arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c    |    2 +-
 arch/arm/mach-orion5x/terastation_pro2-setup.c  |    2 +-
 arch/arm/mach-orion5x/ts209-setup.c             |    2 +-
 arch/arm/mach-orion5x/ts409-setup.c             |    2 +-
 arch/arm/mach-orion5x/ts78xx-setup.c            |    2 +-
 arch/arm/mach-orion5x/tsx09-common.c            |    2 +-
 arch/arm/mach-orion5x/wnr854t-setup.c           |    2 +-
 arch/arm/mach-orion5x/wrt350n-v2-setup.c        |    2 +-
 arch/arm/plat-orion/common.c                    |    2 +-
 arch/arm/plat-orion/include/plat/common.h       |    2 +-
 drivers/net/ethernet/marvell/mv643xx_eth.c      |    2 +-
 include/linux/mv643xx.h                         |    2 +-
 include/linux/{ => platform_data}/mv643xx_eth.h |    4 ++--
 53 files changed, 54 insertions(+), 54 deletions(-)
 rename include/linux/{ => platform_data}/mv643xx_eth.h (96%)

diff --git a/arch/arm/mach-dove/cm-a510.c b/arch/arm/mach-dove/cm-a510.c
index 792b4e2..bb887b8 100644
--- a/arch/arm/mach-dove/cm-a510.c
+++ b/arch/arm/mach-dove/cm-a510.c
@@ -15,7 +15,7 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/ata_platform.h>
-#include <linux/mv643xx_eth.h>
+#include <linux/platform_data/mv643xx_eth.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/flash.h>
 
diff --git a/arch/arm/mach-dove/dove-db-setup.c b/arch/arm/mach-dove/dove-db-setup.c
index bc2867f..60cac4d 100644
--- a/arch/arm/mach-dove/dove-db-setup.c
+++ b/arch/arm/mach-dove/dove-db-setup.c
@@ -16,7 +16,7 @@
 #include <linux/mtd/nand.h>
 #include <linux/timer.h>
 #include <linux/ata_platform.h>
-#include <linux/mv643xx_eth.h>
+#include <linux/platform_data/mv643xx_eth.h>
 #include <linux/i2c.h>
 #include <linux/pci.h>
 #include <linux/spi/spi.h>
diff --git a/arch/arm/mach-kirkwood/board-dnskw.c b/arch/arm/mach-kirkwood/board-dnskw.c
index 4ab3506..8103961 100644
--- a/arch/arm/mach-kirkwood/board-dnskw.c
+++ b/arch/arm/mach-kirkwood/board-dnskw.c
@@ -15,7 +15,7 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/ata_platform.h>
-#include <linux/mv643xx_eth.h>
+#include <linux/platform_data/mv643xx_eth.h>
 #include <linux/of.h>
 #include <linux/gpio.h>
 #include <linux/input.h>
diff --git a/arch/arm/mach-kirkwood/board-dreamplug.c b/arch/arm/mach-kirkwood/board-dreamplug.c
index 5256c1f..b5a4922 100644
--- a/arch/arm/mach-kirkwood/board-dreamplug.c
+++ b/arch/arm/mach-kirkwood/board-dreamplug.c
@@ -15,7 +15,7 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/ata_platform.h>
-#include <linux/mv643xx_eth.h>
+#include <linux/platform_data/mv643xx_eth.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_fdt.h>
diff --git a/arch/arm/mach-kirkwood/board-goflexnet.c b/arch/arm/mach-kirkwood/board-goflexnet.c
index 3d4ba64..52cde7c 100644
--- a/arch/arm/mach-kirkwood/board-goflexnet.c
+++ b/arch/arm/mach-kirkwood/board-goflexnet.c
@@ -20,7 +20,7 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/ata_platform.h>
-#include <linux/mv643xx_eth.h>
+#include <linux/platform_data/mv643xx_eth.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_fdt.h>
diff --git a/arch/arm/mach-kirkwood/board-ib62x0.c b/arch/arm/mach-kirkwood/board-ib62x0.c
index cfc47f8..4304a44 100644
--- a/arch/arm/mach-kirkwood/board-ib62x0.c
+++ b/arch/arm/mach-kirkwood/board-ib62x0.c
@@ -16,7 +16,7 @@
 #include <linux/platform_device.h>
 #include <linux/mtd/partitions.h>
 #include <linux/ata_platform.h>
-#include <linux/mv643xx_eth.h>
+#include <linux/platform_data/mv643xx_eth.h>
 #include <linux/gpio.h>
 #include <linux/input.h>
 #include <asm/mach-types.h>
diff --git a/arch/arm/mach-kirkwood/board-iconnect.c b/arch/arm/mach-kirkwood/board-iconnect.c
index d7a9198..108bfc5 100644
--- a/arch/arm/mach-kirkwood/board-iconnect.c
+++ b/arch/arm/mach-kirkwood/board-iconnect.c
@@ -17,7 +17,7 @@
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/mtd/partitions.h>
-#include <linux/mv643xx_eth.h>
+#include <linux/platform_data/mv643xx_eth.h>
 #include <linux/gpio.h>
 #include <linux/input.h>
 #include <linux/gpio_keys.h>
diff --git a/arch/arm/mach-kirkwood/board-lsxl.c b/arch/arm/mach-kirkwood/board-lsxl.c
index 83d8975..bf247f0 100644
--- a/arch/arm/mach-kirkwood/board-lsxl.c
+++ b/arch/arm/mach-kirkwood/board-lsxl.c
@@ -18,7 +18,7 @@
 #include <linux/ata_platform.h>
 #include <linux/spi/flash.h>
 #include <linux/spi/spi.h>
-#include <linux/mv643xx_eth.h>
+#include <linux/platform_data/mv643xx_eth.h>
 #include <linux/gpio.h>
 #include <linux/gpio-fan.h>
 #include <linux/input.h>
diff --git a/arch/arm/mach-kirkwood/board-ts219.c b/arch/arm/mach-kirkwood/board-ts219.c
index 1750e68..304ba38 100644
--- a/arch/arm/mach-kirkwood/board-ts219.c
+++ b/arch/arm/mach-kirkwood/board-ts219.c
@@ -18,7 +18,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
-#include <linux/mv643xx_eth.h>
+#include <linux/platform_data/mv643xx_eth.h>
 #include <linux/ata_platform.h>
 #include <linux/gpio_keys.h>
 #include <linux/input.h>
diff --git a/arch/arm/mach-kirkwood/d2net_v2-setup.c b/arch/arm/mach-kirkwood/d2net_v2-setup.c
index 6e1bac9..d8f615c 100644
--- a/arch/arm/mach-kirkwood/d2net_v2-setup.c
+++ b/arch/arm/mach-kirkwood/d2net_v2-setup.c
@@ -24,7 +24,7 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/ata_platform.h>
-#include <linux/mv643xx_eth.h>
+#include <linux/platform_data/mv643xx_eth.h>
 #include <linux/input.h>
 #include <linux/gpio.h>
 #include <linux/gpio_keys.h>
diff --git a/arch/arm/mach-kirkwood/db88f6281-bp-setup.c b/arch/arm/mach-kirkwood/db88f6281-bp-setup.c
index c0a367b..fdfe211 100644
--- a/arch/arm/mach-kirkwood/db88f6281-bp-setup.c
+++ b/arch/arm/mach-kirkwood/db88f6281-bp-setup.c
@@ -13,7 +13,7 @@
 #include <linux/platform_device.h>
 #include <linux/mtd/partitions.h>
 #include <linux/ata_platform.h>
-#include <linux/mv643xx_eth.h>
+#include <linux/platform_data/mv643xx_eth.h>
 #include <linux/platform_data/mvsdio.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
diff --git a/arch/arm/mach-kirkwood/dockstar-setup.c b/arch/arm/mach-kirkwood/dockstar-setup.c
index 819cad1..0f4c340 100644
--- a/arch/arm/mach-kirkwood/dockstar-setup.c
+++ b/arch/arm/mach-kirkwood/dockstar-setup.c
@@ -13,7 +13,7 @@
 #include <linux/platform_device.h>
 #include <linux/ata_platform.h>
 #include <linux/mtd/partitions.h>
-#include <linux/mv643xx_eth.h>
+#include <linux/platform_data/mv643xx_eth.h>
 #include <linux/gpio.h>
 #include <linux/leds.h>
 #include <linux/platform_data/mvsdio.h>
diff --git a/arch/arm/mach-kirkwood/guruplug-setup.c b/arch/arm/mach-kirkwood/guruplug-setup.c
index be2b8fe..4de18b8 100644
--- a/arch/arm/mach-kirkwood/guruplug-setup.c
+++ b/arch/arm/mach-kirkwood/guruplug-setup.c
@@ -13,7 +13,7 @@
 #include <linux/platform_device.h>
 #include <linux/mtd/partitions.h>
 #include <linux/ata_platform.h>
-#include <linux/mv643xx_eth.h>
+#include <linux/platform_data/mv643xx_eth.h>
 #include <linux/gpio.h>
 #include <linux/leds.h>
 #include <linux/platform_data/mvsdio.h>
diff --git a/arch/arm/mach-kirkwood/mv88f6281gtw_ge-setup.c b/arch/arm/mach-kirkwood/mv88f6281gtw_ge-setup.c
index 6d8364a..faf50bf 100644
--- a/arch/arm/mach-kirkwood/mv88f6281gtw_ge-setup.c
+++ b/arch/arm/mach-kirkwood/mv88f6281gtw_ge-setup.c
@@ -15,7 +15,7 @@
 #include <linux/irq.h>
 #include <linux/mtd/physmap.h>
 #include <linux/timer.h>
-#include <linux/mv643xx_eth.h>
+#include <linux/platform_data/mv643xx_eth.h>
 #include <linux/ethtool.h>
 #include <linux/gpio.h>
 #include <linux/leds.h>
diff --git a/arch/arm/mach-kirkwood/netspace_v2-setup.c b/arch/arm/mach-kirkwood/netspace_v2-setup.c
index e6bba01..1f307e7 100644
--- a/arch/arm/mach-kirkwood/netspace_v2-setup.c
+++ b/arch/arm/mach-kirkwood/netspace_v2-setup.c
@@ -25,7 +25,7 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/ata_platform.h>
-#include <linux/mv643xx_eth.h>
+#include <linux/platform_data/mv643xx_eth.h>
 #include <linux/input.h>
 #include <linux/gpio.h>
 #include <linux/gpio_keys.h>
diff --git a/arch/arm/mach-kirkwood/netxbig_v2-setup.c b/arch/arm/mach-kirkwood/netxbig_v2-setup.c
index 31ae8de..a970001 100644
--- a/arch/arm/mach-kirkwood/netxbig_v2-setup.c
+++ b/arch/arm/mach-kirkwood/netxbig_v2-setup.c
@@ -24,7 +24,7 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/ata_platform.h>
-#include <linux/mv643xx_eth.h>
+#include <linux/platform_data/mv643xx_eth.h>
 #include <linux/input.h>
 #include <linux/gpio.h>
 #include <linux/gpio_keys.h>
diff --git a/arch/arm/mach-kirkwood/openrd-setup.c b/arch/arm/mach-kirkwood/openrd-setup.c
index 3b36ae7..a967c32 100644
--- a/arch/arm/mach-kirkwood/openrd-setup.c
+++ b/arch/arm/mach-kirkwood/openrd-setup.c
@@ -14,7 +14,7 @@
 #include <linux/mtd/nand.h>
 #include <linux/mtd/partitions.h>
 #include <linux/ata_platform.h>
-#include <linux/mv643xx_eth.h>
+#include <linux/platform_data/mv643xx_eth.h>
 #include <linux/i2c.h>
 #include <linux/gpio.h>
 #include <linux/platform_data/mvsdio.h>
diff --git a/arch/arm/mach-kirkwood/rd88f6192-nas-setup.c b/arch/arm/mach-kirkwood/rd88f6192-nas-setup.c
index f742a66..f757ab0 100644
--- a/arch/arm/mach-kirkwood/rd88f6192-nas-setup.c
+++ b/arch/arm/mach-kirkwood/rd88f6192-nas-setup.c
@@ -12,7 +12,7 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/ata_platform.h>
-#include <linux/mv643xx_eth.h>
+#include <linux/platform_data/mv643xx_eth.h>
 #include <linux/gpio.h>
 #include <linux/spi/flash.h>
 #include <linux/spi/spi.h>
diff --git a/arch/arm/mach-kirkwood/rd88f6281-setup.c b/arch/arm/mach-kirkwood/rd88f6281-setup.c
index 78e1541..81cdc0c 100644
--- a/arch/arm/mach-kirkwood/rd88f6281-setup.c
+++ b/arch/arm/mach-kirkwood/rd88f6281-setup.c
@@ -14,7 +14,7 @@
 #include <linux/irq.h>
 #include <linux/mtd/partitions.h>
 #include <linux/ata_platform.h>
-#include <linux/mv643xx_eth.h>
+#include <linux/platform_data/mv643xx_eth.h>
 #include <linux/ethtool.h>
 #include <linux/platform_data/mvsdio.h>
 #include <net/dsa.h>
diff --git a/arch/arm/mach-kirkwood/sheevaplug-setup.c b/arch/arm/mach-kirkwood/sheevaplug-setup.c
index 006dc69..c80b660 100644
--- a/arch/arm/mach-kirkwood/sheevaplug-setup.c
+++ b/arch/arm/mach-kirkwood/sheevaplug-setup.c
@@ -13,7 +13,7 @@
 #include <linux/platform_device.h>
 #include <linux/ata_platform.h>
 #include <linux/mtd/partitions.h>
-#include <linux/mv643xx_eth.h>
+#include <linux/platform_data/mv643xx_eth.h>
 #include <linux/gpio.h>
 #include <linux/leds.h>
 #include <linux/platform_data/mvsdio.h>
diff --git a/arch/arm/mach-kirkwood/t5325-setup.c b/arch/arm/mach-kirkwood/t5325-setup.c
index bad738e..d3dda63 100644
--- a/arch/arm/mach-kirkwood/t5325-setup.c
+++ b/arch/arm/mach-kirkwood/t5325-setup.c
@@ -17,7 +17,7 @@
 #include <linux/spi/flash.h>
 #include <linux/spi/spi.h>
 #include <linux/i2c.h>
-#include <linux/mv643xx_eth.h>
+#include <linux/platform_data/mv643xx_eth.h>
 #include <linux/ata_platform.h>
 #include <linux/gpio.h>
 #include <linux/gpio_keys.h>
diff --git a/arch/arm/mach-kirkwood/ts219-setup.c b/arch/arm/mach-kirkwood/ts219-setup.c
index 73e2b6c..3cf2266 100644
--- a/arch/arm/mach-kirkwood/ts219-setup.c
+++ b/arch/arm/mach-kirkwood/ts219-setup.c
@@ -15,7 +15,7 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/i2c.h>
-#include <linux/mv643xx_eth.h>
+#include <linux/platform_data/mv643xx_eth.h>
 #include <linux/ata_platform.h>
 #include <linux/gpio_keys.h>
 #include <linux/input.h>
diff --git a/arch/arm/mach-kirkwood/ts41x-setup.c b/arch/arm/mach-kirkwood/ts41x-setup.c
index 5bbca26..0ce35ed 100644
--- a/arch/arm/mach-kirkwood/ts41x-setup.c
+++ b/arch/arm/mach-kirkwood/ts41x-setup.c
@@ -15,7 +15,7 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/i2c.h>
-#include <linux/mv643xx_eth.h>
+#include <linux/platform_data/mv643xx_eth.h>
 #include <linux/ata_platform.h>
 #include <linux/gpio.h>
 #include <linux/gpio_keys.h>
diff --git a/arch/arm/mach-mv78xx0/buffalo-wxl-setup.c b/arch/arm/mach-mv78xx0/buffalo-wxl-setup.c
index ee74ec9..1fce054 100644
--- a/arch/arm/mach-mv78xx0/buffalo-wxl-setup.c
+++ b/arch/arm/mach-mv78xx0/buffalo-wxl-setup.c
@@ -14,7 +14,7 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/ata_platform.h>
-#include <linux/mv643xx_eth.h>
+#include <linux/platform_data/mv643xx_eth.h>
 #include <linux/ethtool.h>
 #include <linux/i2c.h>
 #include <mach/mv78xx0.h>
diff --git a/arch/arm/mach-mv78xx0/db78x00-bp-setup.c b/arch/arm/mach-mv78xx0/db78x00-bp-setup.c
index 4d6d48b..c2ffbb3 100644
--- a/arch/arm/mach-mv78xx0/db78x00-bp-setup.c
+++ b/arch/arm/mach-mv78xx0/db78x00-bp-setup.c
@@ -12,7 +12,7 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/ata_platform.h>
-#include <linux/mv643xx_eth.h>
+#include <linux/platform_data/mv643xx_eth.h>
 #include <linux/ethtool.h>
 #include <linux/i2c.h>
 #include <mach/mv78xx0.h>
diff --git a/arch/arm/mach-mv78xx0/rd78x00-masa-setup.c b/arch/arm/mach-mv78xx0/rd78x00-masa-setup.c
index 9a88270..2423f74 100644
--- a/arch/arm/mach-mv78xx0/rd78x00-masa-setup.c
+++ b/arch/arm/mach-mv78xx0/rd78x00-masa-setup.c
@@ -12,7 +12,7 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/ata_platform.h>
-#include <linux/mv643xx_eth.h>
+#include <linux/platform_data/mv643xx_eth.h>
 #include <linux/ethtool.h>
 #include <mach/mv78xx0.h>
 #include <asm/mach-types.h>
diff --git a/arch/arm/mach-orion5x/d2net-setup.c b/arch/arm/mach-orion5x/d2net-setup.c
index d75dcfa..9f31bbe 100644
--- a/arch/arm/mach-orion5x/d2net-setup.c
+++ b/arch/arm/mach-orion5x/d2net-setup.c
@@ -16,7 +16,7 @@
 #include <linux/pci.h>
 #include <linux/irq.h>
 #include <linux/mtd/physmap.h>
-#include <linux/mv643xx_eth.h>
+#include <linux/platform_data/mv643xx_eth.h>
 #include <linux/leds.h>
 #include <linux/gpio_keys.h>
 #include <linux/input.h>
diff --git a/arch/arm/mach-orion5x/db88f5281-setup.c b/arch/arm/mach-orion5x/db88f5281-setup.c
index be3080e..051bd16 100644
--- a/arch/arm/mach-orion5x/db88f5281-setup.c
+++ b/arch/arm/mach-orion5x/db88f5281-setup.c
@@ -18,7 +18,7 @@
 #include <linux/mtd/physmap.h>
 #include <linux/mtd/nand.h>
 #include <linux/timer.h>
-#include <linux/mv643xx_eth.h>
+#include <linux/platform_data/mv643xx_eth.h>
 #include <linux/i2c.h>
 #include <linux/platform_data/orion_nand.h>
 #include <asm/mach-types.h>
diff --git a/arch/arm/mach-orion5x/dns323-setup.c b/arch/arm/mach-orion5x/dns323-setup.c
index d470864..cdc34e5 100644
--- a/arch/arm/mach-orion5x/dns323-setup.c
+++ b/arch/arm/mach-orion5x/dns323-setup.c
@@ -21,7 +21,7 @@
 #include <linux/pci.h>
 #include <linux/irq.h>
 #include <linux/mtd/physmap.h>
-#include <linux/mv643xx_eth.h>
+#include <linux/platform_data/mv643xx_eth.h>
 #include <linux/leds.h>
 #include <linux/gpio_keys.h>
 #include <linux/input.h>
diff --git a/arch/arm/mach-orion5x/edmini_v2-setup.c b/arch/arm/mach-orion5x/edmini_v2-setup.c
index 355e962..cf47458 100644
--- a/arch/arm/mach-orion5x/edmini_v2-setup.c
+++ b/arch/arm/mach-orion5x/edmini_v2-setup.c
@@ -24,7 +24,7 @@
 #include <linux/pci.h>
 #include <linux/irq.h>
 #include <linux/mtd/physmap.h>
-#include <linux/mv643xx_eth.h>
+#include <linux/platform_data/mv643xx_eth.h>
 #include <linux/leds.h>
 #include <linux/gpio_keys.h>
 #include <linux/input.h>
diff --git a/arch/arm/mach-orion5x/kurobox_pro-setup.c b/arch/arm/mach-orion5x/kurobox_pro-setup.c
index 82cf706..bac1f57 100644
--- a/arch/arm/mach-orion5x/kurobox_pro-setup.c
+++ b/arch/arm/mach-orion5x/kurobox_pro-setup.c
@@ -16,7 +16,7 @@
 #include <linux/delay.h>
 #include <linux/mtd/physmap.h>
 #include <linux/mtd/nand.h>
-#include <linux/mv643xx_eth.h>
+#include <linux/platform_data/mv643xx_eth.h>
 #include <linux/i2c.h>
 #include <linux/serial_reg.h>
 #include <linux/ata_platform.h>
diff --git a/arch/arm/mach-orion5x/ls-chl-setup.c b/arch/arm/mach-orion5x/ls-chl-setup.c
index 0c9e413..e24835f 100644
--- a/arch/arm/mach-orion5x/ls-chl-setup.c
+++ b/arch/arm/mach-orion5x/ls-chl-setup.c
@@ -12,7 +12,7 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/mtd/physmap.h>
-#include <linux/mv643xx_eth.h>
+#include <linux/platform_data/mv643xx_eth.h>
 #include <linux/leds.h>
 #include <linux/gpio_keys.h>
 #include <linux/gpio-fan.h>
diff --git a/arch/arm/mach-orion5x/ls_hgl-setup.c b/arch/arm/mach-orion5x/ls_hgl-setup.c
index c1b5d8a..97ba200 100644
--- a/arch/arm/mach-orion5x/ls_hgl-setup.c
+++ b/arch/arm/mach-orion5x/ls_hgl-setup.c
@@ -12,7 +12,7 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/mtd/physmap.h>
-#include <linux/mv643xx_eth.h>
+#include <linux/platform_data/mv643xx_eth.h>
 #include <linux/leds.h>
 #include <linux/gpio_keys.h>
 #include <linux/input.h>
diff --git a/arch/arm/mach-orion5x/lsmini-setup.c b/arch/arm/mach-orion5x/lsmini-setup.c
index 949eaa8..f73c9d7 100644
--- a/arch/arm/mach-orion5x/lsmini-setup.c
+++ b/arch/arm/mach-orion5x/lsmini-setup.c
@@ -12,7 +12,7 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/mtd/physmap.h>
-#include <linux/mv643xx_eth.h>
+#include <linux/platform_data/mv643xx_eth.h>
 #include <linux/leds.h>
 #include <linux/gpio_keys.h>
 #include <linux/input.h>
diff --git a/arch/arm/mach-orion5x/mss2-setup.c b/arch/arm/mach-orion5x/mss2-setup.c
index 1c16d04..10eb517 100644
--- a/arch/arm/mach-orion5x/mss2-setup.c
+++ b/arch/arm/mach-orion5x/mss2-setup.c
@@ -15,7 +15,7 @@
 #include <linux/pci.h>
 #include <linux/irq.h>
 #include <linux/mtd/physmap.h>
-#include <linux/mv643xx_eth.h>
+#include <linux/platform_data/mv643xx_eth.h>
 #include <linux/leds.h>
 #include <linux/gpio_keys.h>
 #include <linux/input.h>
diff --git a/arch/arm/mach-orion5x/mv2120-setup.c b/arch/arm/mach-orion5x/mv2120-setup.c
index c87fde4..4c1d86f 100644
--- a/arch/arm/mach-orion5x/mv2120-setup.c
+++ b/arch/arm/mach-orion5x/mv2120-setup.c
@@ -13,7 +13,7 @@
 #include <linux/platform_device.h>
 #include <linux/irq.h>
 #include <linux/mtd/physmap.h>
-#include <linux/mv643xx_eth.h>
+#include <linux/platform_data/mv643xx_eth.h>
 #include <linux/leds.h>
 #include <linux/gpio_keys.h>
 #include <linux/input.h>
diff --git a/arch/arm/mach-orion5x/net2big-setup.c b/arch/arm/mach-orion5x/net2big-setup.c
index 0180c39..d10fa5a 100644
--- a/arch/arm/mach-orion5x/net2big-setup.c
+++ b/arch/arm/mach-orion5x/net2big-setup.c
@@ -14,7 +14,7 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/mtd/physmap.h>
-#include <linux/mv643xx_eth.h>
+#include <linux/platform_data/mv643xx_eth.h>
 #include <linux/leds.h>
 #include <linux/gpio_keys.h>
 #include <linux/input.h>
diff --git a/arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c b/arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c
index 78a6a11..c1e874b 100644
--- a/arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c
+++ b/arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c
@@ -14,7 +14,7 @@
 #include <linux/pci.h>
 #include <linux/irq.h>
 #include <linux/mtd/physmap.h>
-#include <linux/mv643xx_eth.h>
+#include <linux/platform_data/mv643xx_eth.h>
 #include <linux/ethtool.h>
 #include <net/dsa.h>
 #include <asm/mach-types.h>
diff --git a/arch/arm/mach-orion5x/rd88f5181l-ge-setup.c b/arch/arm/mach-orion5x/rd88f5181l-ge-setup.c
index 2f5dc54..6551cd5 100644
--- a/arch/arm/mach-orion5x/rd88f5181l-ge-setup.c
+++ b/arch/arm/mach-orion5x/rd88f5181l-ge-setup.c
@@ -14,7 +14,7 @@
 #include <linux/pci.h>
 #include <linux/irq.h>
 #include <linux/mtd/physmap.h>
-#include <linux/mv643xx_eth.h>
+#include <linux/platform_data/mv643xx_eth.h>
 #include <linux/ethtool.h>
 #include <linux/i2c.h>
 #include <net/dsa.h>
diff --git a/arch/arm/mach-orion5x/rd88f5182-setup.c b/arch/arm/mach-orion5x/rd88f5182-setup.c
index 399130f..22d423e 100644
--- a/arch/arm/mach-orion5x/rd88f5182-setup.c
+++ b/arch/arm/mach-orion5x/rd88f5182-setup.c
@@ -16,7 +16,7 @@
 #include <linux/pci.h>
 #include <linux/irq.h>
 #include <linux/mtd/physmap.h>
-#include <linux/mv643xx_eth.h>
+#include <linux/platform_data/mv643xx_eth.h>
 #include <linux/ata_platform.h>
 #include <linux/i2c.h>
 #include <asm/mach-types.h>
diff --git a/arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c b/arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c
index 92df49c..a8cbd4e 100644
--- a/arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c
+++ b/arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c
@@ -14,7 +14,7 @@
 #include <linux/pci.h>
 #include <linux/irq.h>
 #include <linux/mtd/physmap.h>
-#include <linux/mv643xx_eth.h>
+#include <linux/platform_data/mv643xx_eth.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/flash.h>
 #include <linux/ethtool.h>
diff --git a/arch/arm/mach-orion5x/terastation_pro2-setup.c b/arch/arm/mach-orion5x/terastation_pro2-setup.c
index 90e571d..33f1fd5 100644
--- a/arch/arm/mach-orion5x/terastation_pro2-setup.c
+++ b/arch/arm/mach-orion5x/terastation_pro2-setup.c
@@ -16,7 +16,7 @@
 #include <linux/irq.h>
 #include <linux/delay.h>
 #include <linux/mtd/physmap.h>
-#include <linux/mv643xx_eth.h>
+#include <linux/platform_data/mv643xx_eth.h>
 #include <linux/i2c.h>
 #include <linux/serial_reg.h>
 #include <asm/mach-types.h>
diff --git a/arch/arm/mach-orion5x/ts209-setup.c b/arch/arm/mach-orion5x/ts209-setup.c
index b184f68..55b59f0 100644
--- a/arch/arm/mach-orion5x/ts209-setup.c
+++ b/arch/arm/mach-orion5x/ts209-setup.c
@@ -16,7 +16,7 @@
 #include <linux/irq.h>
 #include <linux/mtd/physmap.h>
 #include <linux/mtd/nand.h>
-#include <linux/mv643xx_eth.h>
+#include <linux/platform_data/mv643xx_eth.h>
 #include <linux/gpio_keys.h>
 #include <linux/input.h>
 #include <linux/i2c.h>
diff --git a/arch/arm/mach-orion5x/ts409-setup.c b/arch/arm/mach-orion5x/ts409-setup.c
index a5c2e64..a4b5be0 100644
--- a/arch/arm/mach-orion5x/ts409-setup.c
+++ b/arch/arm/mach-orion5x/ts409-setup.c
@@ -18,7 +18,7 @@
 #include <linux/pci.h>
 #include <linux/irq.h>
 #include <linux/mtd/physmap.h>
-#include <linux/mv643xx_eth.h>
+#include <linux/platform_data/mv643xx_eth.h>
 #include <linux/leds.h>
 #include <linux/gpio_keys.h>
 #include <linux/input.h>
diff --git a/arch/arm/mach-orion5x/ts78xx-setup.c b/arch/arm/mach-orion5x/ts78xx-setup.c
index b420327..28e2fe0 100644
--- a/arch/arm/mach-orion5x/ts78xx-setup.c
+++ b/arch/arm/mach-orion5x/ts78xx-setup.c
@@ -14,7 +14,7 @@
 #include <linux/init.h>
 #include <linux/sysfs.h>
 #include <linux/platform_device.h>
-#include <linux/mv643xx_eth.h>
+#include <linux/platform_data/mv643xx_eth.h>
 #include <linux/ata_platform.h>
 #include <linux/m48t86.h>
 #include <linux/mtd/nand.h>
diff --git a/arch/arm/mach-orion5x/tsx09-common.c b/arch/arm/mach-orion5x/tsx09-common.c
index 7189827..9e917bd 100644
--- a/arch/arm/mach-orion5x/tsx09-common.c
+++ b/arch/arm/mach-orion5x/tsx09-common.c
@@ -12,7 +12,7 @@
 
 #include <linux/kernel.h>
 #include <linux/pci.h>
-#include <linux/mv643xx_eth.h>
+#include <linux/platform_data/mv643xx_eth.h>
 #include <linux/timex.h>
 #include <linux/serial_reg.h>
 #include <mach/orion5x.h>
diff --git a/arch/arm/mach-orion5x/wnr854t-setup.c b/arch/arm/mach-orion5x/wnr854t-setup.c
index 754c12b..f815dac 100644
--- a/arch/arm/mach-orion5x/wnr854t-setup.c
+++ b/arch/arm/mach-orion5x/wnr854t-setup.c
@@ -13,7 +13,7 @@
 #include <linux/irq.h>
 #include <linux/delay.h>
 #include <linux/mtd/physmap.h>
-#include <linux/mv643xx_eth.h>
+#include <linux/platform_data/mv643xx_eth.h>
 #include <linux/ethtool.h>
 #include <net/dsa.h>
 #include <asm/mach-types.h>
diff --git a/arch/arm/mach-orion5x/wrt350n-v2-setup.c b/arch/arm/mach-orion5x/wrt350n-v2-setup.c
index 45c2125..61dec34 100644
--- a/arch/arm/mach-orion5x/wrt350n-v2-setup.c
+++ b/arch/arm/mach-orion5x/wrt350n-v2-setup.c
@@ -13,7 +13,7 @@
 #include <linux/irq.h>
 #include <linux/delay.h>
 #include <linux/mtd/physmap.h>
-#include <linux/mv643xx_eth.h>
+#include <linux/platform_data/mv643xx_eth.h>
 #include <linux/ethtool.h>
 #include <linux/leds.h>
 #include <linux/gpio_keys.h>
diff --git a/arch/arm/plat-orion/common.c b/arch/arm/plat-orion/common.c
index 3aeb28f..4585815 100644
--- a/arch/arm/plat-orion/common.c
+++ b/arch/arm/plat-orion/common.c
@@ -16,7 +16,7 @@
 #include <linux/ata_platform.h>
 #include <linux/clk.h>
 #include <linux/clkdev.h>
-#include <linux/mv643xx_eth.h>
+#include <linux/platform_data/mv643xx_eth.h>
 #include <linux/platform_data/ehci-orion.h>
 #include <linux/platform_data/mv_xor.h>
 #include <linux/platform_data/mv643xx_i2c.h>
diff --git a/arch/arm/plat-orion/include/plat/common.h b/arch/arm/plat-orion/include/plat/common.h
index e00fdb2..2a57984 100644
--- a/arch/arm/plat-orion/include/plat/common.h
+++ b/arch/arm/plat-orion/include/plat/common.h
@@ -9,7 +9,7 @@
  */
 
 #ifndef __PLAT_COMMON_H
-#include <linux/mv643xx_eth.h>
+#include <linux/platform_data/mv643xx_eth.h>
 
 struct dsa_platform_data;
 
diff --git a/drivers/net/ethernet/marvell/mv643xx_eth.c b/drivers/net/ethernet/marvell/mv643xx_eth.c
index 087b9e0..9e5c179 100644
--- a/drivers/net/ethernet/marvell/mv643xx_eth.c
+++ b/drivers/net/ethernet/marvell/mv643xx_eth.c
@@ -52,12 +52,12 @@
 #include <linux/spinlock.h>
 #include <linux/workqueue.h>
 #include <linux/phy.h>
-#include <linux/mv643xx_eth.h>
 #include <linux/io.h>
 #include <linux/types.h>
 #include <linux/inet_lro.h>
 #include <linux/slab.h>
 #include <linux/clk.h>
+#include <linux/platform_data/mv643xx_eth.h>
 
 static char mv643xx_eth_driver_name[] = "mv643xx_eth";
 static char mv643xx_eth_driver_version[] = "1.4";
diff --git a/include/linux/mv643xx.h b/include/linux/mv643xx.h
index 7e293ce..21a1a74 100644
--- a/include/linux/mv643xx.h
+++ b/include/linux/mv643xx.h
@@ -14,7 +14,7 @@
 #define __ASM_MV643XX_H
 
 #include <asm/types.h>
-#include <linux/mv643xx_eth.h>
+#include <linux/platform_data/mv643xx_eth.h>
 #include <linux/platform_data/mv643xx_i2c.h>
 
 /****************************************/
diff --git a/include/linux/mv643xx_eth.h b/include/linux/platform_data/mv643xx_eth.h
similarity index 96%
rename from include/linux/mv643xx_eth.h
rename to include/linux/platform_data/mv643xx_eth.h
index 51bf8ad..6c6cfe6 100644
--- a/include/linux/mv643xx_eth.h
+++ b/include/linux/platform_data/mv643xx_eth.h
@@ -2,8 +2,8 @@
  * MV-643XX ethernet platform device data definition file.
  */
 
-#ifndef __LINUX_MV643XX_ETH_H
-#define __LINUX_MV643XX_ETH_H
+#ifndef __MV643XX_ETH_PDATA_H
+#define __MV643XX_ETH_PDATA_H
 
 #include <linux/mbus.h>
 
-- 
1.7.9.5
