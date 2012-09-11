From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 11 Sep 2012 14:59:43 +0200
Subject: [PATCH 09/16] ARM: tegra: move platform_data definitions
In-Reply-To: <1347368390-31252-1-git-send-email-arnd@arndb.de>
References: <1347368350-31212-1-git-send-email-arnd@arndb.de>
 <1347368390-31252-1-git-send-email-arnd@arndb.de>
Message-ID: <1347368390-31252-9-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Platform data for device drivers should be defined in
include/linux/platform_data/*.h, not in the architecture
and platform specific directories.

This moves such data out of the tegra include directories

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Colin Cross <ccross@android.com>
Cc: Olof Johansson <olof@lixom.net>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Chris Ball <cjb@laptop.org>
Cc: Liam Girdwood <lrg@ti.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-tegra at vger.kernel.org
---
 arch/arm/mach-tegra/board-harmony.c                                |    4 ++--
 arch/arm/mach-tegra/board-paz00.c                                  |    2 +-
 arch/arm/mach-tegra/board-trimslice.c                              |    2 +-
 drivers/input/keyboard/tegra-kbc.c                                 |    2 +-
 drivers/mmc/host/sdhci-tegra.c                                     |    2 +-
 .../linux/platform_data/asoc-tegra_wm8903.h                        |    0
 .../mach/kbc.h => include/linux/platform_data/keyboard-tegra-kbc.h |    0
 .../mach/sdhci.h => include/linux/platform_data/mmc-sdhci-tegra.h  |    0
 sound/soc/tegra/tegra_wm8903.c                                     |    2 +-
 9 files changed, 7 insertions(+), 7 deletions(-)
 rename arch/arm/mach-tegra/include/mach/tegra_wm8903_pdata.h => include/linux/platform_data/asoc-tegra_wm8903.h (100%)
 rename arch/arm/mach-tegra/include/mach/kbc.h => include/linux/platform_data/keyboard-tegra-kbc.h (100%)
 rename arch/arm/mach-tegra/include/mach/sdhci.h => include/linux/platform_data/mmc-sdhci-tegra.h (100%)

diff --git a/arch/arm/mach-tegra/board-harmony.c b/arch/arm/mach-tegra/board-harmony.c
index e65e837..31b3b72 100644
--- a/arch/arm/mach-tegra/board-harmony.c
+++ b/arch/arm/mach-tegra/board-harmony.c
@@ -35,10 +35,10 @@
 #include <asm/hardware/gic.h>
 #include <asm/setup.h>
 
-#include <mach/tegra_wm8903_pdata.h>
+#include <linux/platform_data/asoc-tegra_wm8903.h>
 #include <mach/iomap.h>
 #include <mach/irqs.h>
-#include <mach/sdhci.h>
+#include <linux/platform_data/mmc-sdhci-tegra.h>
 
 #include "board.h"
 #include "board-harmony.h"
diff --git a/arch/arm/mach-tegra/board-paz00.c b/arch/arm/mach-tegra/board-paz00.c
index 4b64af5..6dd6854 100644
--- a/arch/arm/mach-tegra/board-paz00.c
+++ b/arch/arm/mach-tegra/board-paz00.c
@@ -40,7 +40,7 @@
 
 #include <mach/iomap.h>
 #include <mach/irqs.h>
-#include <mach/sdhci.h>
+#include <linux/platform_data/mmc-sdhci-tegra.h>
 
 #include "board.h"
 #include "board-paz00.h"
diff --git a/arch/arm/mach-tegra/board-trimslice.c b/arch/arm/mach-tegra/board-trimslice.c
index 776aa95..fb80c8f 100644
--- a/arch/arm/mach-tegra/board-trimslice.c
+++ b/arch/arm/mach-tegra/board-trimslice.c
@@ -34,7 +34,7 @@
 #include <asm/setup.h>
 
 #include <mach/iomap.h>
-#include <mach/sdhci.h>
+#include <linux/platform_data/mmc-sdhci-tegra.h>
 
 #include "board.h"
 #include "clock.h"
diff --git a/drivers/input/keyboard/tegra-kbc.c b/drivers/input/keyboard/tegra-kbc.c
index 2c1c9ed..40aded8 100644
--- a/drivers/input/keyboard/tegra-kbc.c
+++ b/drivers/input/keyboard/tegra-kbc.c
@@ -30,7 +30,7 @@
 #include <linux/clk.h>
 #include <linux/slab.h>
 #include <mach/clk.h>
-#include <mach/kbc.h>
+#include <linux/platform_data/keyboard-tegra-kbc.h>
 
 #define KBC_MAX_DEBOUNCE_CNT	0x3ffu
 
diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 0810ccc..d43e746 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -28,7 +28,7 @@
 #include <asm/gpio.h>
 
 #include <mach/gpio-tegra.h>
-#include <mach/sdhci.h>
+#include <linux/platform_data/mmc-sdhci-tegra.h>
 
 #include "sdhci-pltfm.h"
 
diff --git a/arch/arm/mach-tegra/include/mach/tegra_wm8903_pdata.h b/include/linux/platform_data/asoc-tegra_wm8903.h
similarity index 100%
rename from arch/arm/mach-tegra/include/mach/tegra_wm8903_pdata.h
rename to include/linux/platform_data/asoc-tegra_wm8903.h
diff --git a/arch/arm/mach-tegra/include/mach/kbc.h b/include/linux/platform_data/keyboard-tegra-kbc.h
similarity index 100%
rename from arch/arm/mach-tegra/include/mach/kbc.h
rename to include/linux/platform_data/keyboard-tegra-kbc.h
diff --git a/arch/arm/mach-tegra/include/mach/sdhci.h b/include/linux/platform_data/mmc-sdhci-tegra.h
similarity index 100%
rename from arch/arm/mach-tegra/include/mach/sdhci.h
rename to include/linux/platform_data/mmc-sdhci-tegra.h
diff --git a/sound/soc/tegra/tegra_wm8903.c b/sound/soc/tegra/tegra_wm8903.c
index d4f14e4..8deedf5 100644
--- a/sound/soc/tegra/tegra_wm8903.c
+++ b/sound/soc/tegra/tegra_wm8903.c
@@ -34,7 +34,7 @@
 #include <linux/gpio.h>
 #include <linux/of_gpio.h>
 
-#include <mach/tegra_wm8903_pdata.h>
+#include <linux/platform_data/asoc-tegra_wm8903.h>
 
 #include <sound/core.h>
 #include <sound/jack.h>
-- 
1.7.10
