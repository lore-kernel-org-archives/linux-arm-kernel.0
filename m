From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 12 Sep 2012 16:21:15 +0000
Subject: [PATCH 09/16] ARM: tegra: move platform_data definitions
In-Reply-To: <504F5A51.9000506@wwwdotorg.org>
References: <1347368350-31212-1-git-send-email-arnd@arndb.de>
 <1347368390-31252-9-git-send-email-arnd@arndb.de>
 <504F5A51.9000506@wwwdotorg.org>
Message-ID: <201209121621.16019.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 11 September 2012, Stephen Warren wrote:

> >  .../mach/sdhci.h => include/linux/platform_data/mmc-sdhci-tegra.h  |    0
> 
> I have a not-yet-applied (but ack'd by Chris Ball) patch to move this to
> include/linux/mmc/tegra_sdhci.h. I believe all the dependencies are
> staged in the Tegra tree now, so I can apply it if you want. I'm fine
> with you apply this patch though; just let me know. If you want to take
> your patch, then this part:
> 
> Acked-by: Stephen Warren <swarren@wwwdotorg.org>

I've redone my patch now, the version below is what I have now.

Thanks,

	Arnd

>From 1580b8b9c820db3d1e9ffce91fc741516ad5547a Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 12 Sep 2012 18:15:42 +0200
Subject: [PATCH] ARM: tegra: move sdhci platform_data definition

Platform data for device drivers should be defined in
include/linux/platform_data/*.h, not in the architecture
and platform specific directories.

This the definitions for the tegra sdhci driver out of
the tegra include directories, which is the last one
for this platform.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: Nicolas Pitre <nico@linaro.org>
Acked-by: Stephen Warren <swarren@wwwdotorg.org>
Acked-by: Chris Ball <cjb@laptop.org>

diff --git a/arch/arm/mach-tegra/board-harmony.c b/arch/arm/mach-tegra/board-harmony.c
index e65e837..5f428ff 100644
--- a/arch/arm/mach-tegra/board-harmony.c
+++ b/arch/arm/mach-tegra/board-harmony.c
@@ -26,6 +26,7 @@
 #include <linux/io.h>
 #include <linux/gpio.h>
 #include <linux/i2c.h>
+#include <linux/platform_data/mmc-sdhci-tegra.h>
 
 #include <sound/wm8903.h>
 
@@ -38,7 +39,6 @@
 #include <mach/tegra_wm8903_pdata.h>
 #include <mach/iomap.h>
 #include <mach/irqs.h>
-#include <mach/sdhci.h>
 
 #include "board.h"
 #include "board-harmony.h"
diff --git a/arch/arm/mach-tegra/board-paz00.c b/arch/arm/mach-tegra/board-paz00.c
index 4b64af5..112bf68 100644
--- a/arch/arm/mach-tegra/board-paz00.c
+++ b/arch/arm/mach-tegra/board-paz00.c
@@ -31,6 +31,7 @@
 #include <linux/i2c.h>
 #include <linux/gpio.h>
 #include <linux/rfkill-gpio.h>
+#include <linux/platform_data/mmc-sdhci-tegra.h>
 
 #include <asm/hardware/gic.h>
 #include <asm/mach-types.h>
@@ -40,7 +41,6 @@
 
 #include <mach/iomap.h>
 #include <mach/irqs.h>
-#include <mach/sdhci.h>
 
 #include "board.h"
 #include "board-paz00.h"
diff --git a/arch/arm/mach-tegra/board-trimslice.c b/arch/arm/mach-tegra/board-trimslice.c
index 776aa95..8d1a66a 100644
--- a/arch/arm/mach-tegra/board-trimslice.c
+++ b/arch/arm/mach-tegra/board-trimslice.c
@@ -27,6 +27,7 @@
 #include <linux/i2c.h>
 #include <linux/gpio.h>
 #include <linux/platform_data/tegra_usb.h>
+#include <linux/platform_data/mmc-sdhci-tegra.h>
 
 #include <asm/hardware/gic.h>
 #include <asm/mach-types.h>
@@ -34,7 +35,6 @@
 #include <asm/setup.h>
 
 #include <mach/iomap.h>
-#include <mach/sdhci.h>
 
 #include "board.h"
 #include "clock.h"
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
 
diff --git a/arch/arm/mach-tegra/include/mach/sdhci.h b/include/linux/platform_data/mmc-sdhci-tegra.h
similarity index 84%
rename from arch/arm/mach-tegra/include/mach/sdhci.h
rename to include/linux/platform_data/mmc-sdhci-tegra.h
index 4231bc7..8f84306 100644
--- a/arch/arm/mach-tegra/include/mach/sdhci.h
+++ b/include/linux/platform_data/mmc-sdhci-tegra.h
@@ -1,6 +1,4 @@
 /*
- * include/asm-arm/arch-tegra/include/mach/sdhci.h
- *
  * Copyright (C) 2009 Palm, Inc.
  * Author: Yvonne Yip <y@palm.com>
  *
@@ -14,8 +12,8 @@
  * GNU General Public License for more details.
  *
  */
-#ifndef __ASM_ARM_ARCH_TEGRA_SDHCI_H
-#define __ASM_ARM_ARCH_TEGRA_SDHCI_H
+#ifndef __PLATFORM_DATA_TEGRA_SDHCI_H
+#define __PLATFORM_DATA_TEGRA_SDHCI_H
 
 #include <linux/mmc/host.h>
 
