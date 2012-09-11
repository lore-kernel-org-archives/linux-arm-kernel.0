From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 11 Sep 2012 14:59:44 +0200
Subject: [PATCH 10/16] ARM: vt8500: move platform_data definitions
In-Reply-To: <1347368390-31252-1-git-send-email-arnd@arndb.de>
References: <1347368350-31212-1-git-send-email-arnd@arndb.de>
 <1347368390-31252-1-git-send-email-arnd@arndb.de>
Message-ID: <1347368390-31252-10-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Platform data for device drivers should be defined in
include/linux/platform_data/*.h, not in the architecture
and platform specific directories.

This moves such data out of the vt8500 include directories

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Tony Prisk <linux@prisktech.co.nz>
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
---
 arch/arm/mach-vt8500/devices.c                                       |    2 +-
 drivers/video/vt8500lcdfb.c                                          |    2 +-
 drivers/video/wm8505fb.c                                             |    2 +-
 .../vt8500fb.h => include/linux/platform_data/video-vt8500lcdfb.h    |    0
 4 files changed, 3 insertions(+), 3 deletions(-)
 rename arch/arm/mach-vt8500/include/mach/vt8500fb.h => include/linux/platform_data/video-vt8500lcdfb.h (100%)

diff --git a/arch/arm/mach-vt8500/devices.c b/arch/arm/mach-vt8500/devices.c
index 1fcdc36..82b4bce 100644
--- a/arch/arm/mach-vt8500/devices.c
+++ b/arch/arm/mach-vt8500/devices.c
@@ -23,7 +23,7 @@
 
 #include <asm/mach/arch.h>
 
-#include <mach/vt8500fb.h>
+#include <linux/platform_data/video-vt8500lcdfb.h>
 #include <mach/i8042.h>
 #include "devices.h"
 
diff --git a/drivers/video/vt8500lcdfb.c b/drivers/video/vt8500lcdfb.c
index 2a5fe6e..66a74f9 100644
--- a/drivers/video/vt8500lcdfb.c
+++ b/drivers/video/vt8500lcdfb.c
@@ -30,7 +30,7 @@
 #include <linux/platform_device.h>
 #include <linux/wait.h>
 
-#include <mach/vt8500fb.h>
+#include <linux/platform_data/video-vt8500lcdfb.h>
 
 #include "vt8500lcdfb.h"
 #include "wmt_ge_rops.h"
diff --git a/drivers/video/wm8505fb.c b/drivers/video/wm8505fb.c
index c8703bd..ffeff48 100644
--- a/drivers/video/wm8505fb.c
+++ b/drivers/video/wm8505fb.c
@@ -29,7 +29,7 @@
 #include <linux/platform_device.h>
 #include <linux/wait.h>
 
-#include <mach/vt8500fb.h>
+#include <linux/platform_data/video-vt8500lcdfb.h>
 
 #include "wm8505fb_regs.h"
 #include "wmt_ge_rops.h"
diff --git a/arch/arm/mach-vt8500/include/mach/vt8500fb.h b/include/linux/platform_data/video-vt8500lcdfb.h
similarity index 100%
rename from arch/arm/mach-vt8500/include/mach/vt8500fb.h
rename to include/linux/platform_data/video-vt8500lcdfb.h
-- 
1.7.10
