From: s-anna@ti.com (Suman Anna)
Date: Mon, 12 Feb 2018 19:32:43 -0600
Subject: [PATCH 9/9] ARM: OMAP2+: Remove unused gpio header file references
In-Reply-To: <20180213013243.8378-1-s-anna@ti.com>
References: <20180213013243.8378-1-s-anna@ti.com>
Message-ID: <20180213013243.8378-10-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Drop stale references to the generic and OMAP gpio header
files from couple of files which no longer invoke any gpio
functions.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/mach-omap2/devices.c | 2 +-
 arch/arm/mach-omap2/hsmmc.c   | 2 --
 arch/arm/mach-omap2/msdi.c    | 1 -
 3 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 93057fb65f44..ed6f074ea672 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -8,7 +8,7 @@
  * the Free Software Foundation; either version 2 of the License, or
  * (at your option) any later version.
  */
-#include <linux/gpio.h>
+
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index 6d28aa20a7d3..b064066d431c 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -13,9 +13,7 @@
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/delay.h>
-#include <linux/gpio.h>
 #include <linux/mmc/host.h>
-#include <linux/platform_data/gpio-omap.h>
 #include <linux/platform_data/hsmmc-omap.h>
 
 #include "soc.h"
diff --git a/arch/arm/mach-omap2/msdi.c b/arch/arm/mach-omap2/msdi.c
index 5a3bc3de58d0..978fba722b82 100644
--- a/arch/arm/mach-omap2/msdi.c
+++ b/arch/arm/mach-omap2/msdi.c
@@ -23,7 +23,6 @@
 
 #include <linux/kernel.h>
 #include <linux/err.h>
-#include <linux/platform_data/gpio-omap.h>
 
 #include "prm.h"
 #include "common.h"
-- 
2.15.1
