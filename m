From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 11 Sep 2012 14:59:42 +0200
Subject: [PATCH 08/16] ARM: sa1100: move platform_data definitions
In-Reply-To: <1347368390-31252-1-git-send-email-arnd@arndb.de>
References: <1347368350-31212-1-git-send-email-arnd@arndb.de>
 <1347368390-31252-1-git-send-email-arnd@arndb.de>
Message-ID: <1347368390-31252-8-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Platform data for device drivers should be defined in
include/linux/platform_data/*.h, not in the architecture
and platform specific directories.

This moves such data out of the sa1100 include directories

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Samuel Ortiz <sameo@linux.intel.com>
Cc: Jochen Friedrich <jochen@scram.de>
---
 arch/arm/mach-sa1100/assabet.c                                       |    2 +-
 arch/arm/mach-sa1100/cerf.c                                          |    2 +-
 arch/arm/mach-sa1100/collie.c                                        |    2 +-
 arch/arm/mach-sa1100/lart.c                                          |    2 +-
 arch/arm/mach-sa1100/shannon.c                                       |    2 +-
 arch/arm/mach-sa1100/simpad.c                                        |    2 +-
 drivers/mfd/mcp-sa11x0.c                                             |    2 +-
 .../mach/mcp.h => include/linux/platform_data/mfd-mcp-sa11x0.h       |    0
 8 files changed, 7 insertions(+), 7 deletions(-)
 rename arch/arm/mach-sa1100/include/mach/mcp.h => include/linux/platform_data/mfd-mcp-sa11x0.h (100%)

diff --git a/arch/arm/mach-sa1100/assabet.c b/arch/arm/mach-sa1100/assabet.c
index d673211..ba49241 100644
--- a/arch/arm/mach-sa1100/assabet.c
+++ b/arch/arm/mach-sa1100/assabet.c
@@ -37,7 +37,7 @@
 #include <asm/mach/map.h>
 #include <asm/mach/serial_sa1100.h>
 #include <mach/assabet.h>
-#include <mach/mcp.h>
+#include <linux/platform_data/mfd-mcp-sa11x0.h>
 #include <mach/irqs.h>
 
 #include "generic.h"
diff --git a/arch/arm/mach-sa1100/cerf.c b/arch/arm/mach-sa1100/cerf.c
index 09d7f4b..985d0b5 100644
--- a/arch/arm/mach-sa1100/cerf.c
+++ b/arch/arm/mach-sa1100/cerf.c
@@ -28,7 +28,7 @@
 #include <asm/mach/serial_sa1100.h>
 
 #include <mach/cerf.h>
-#include <mach/mcp.h>
+#include <linux/platform_data/mfd-mcp-sa11x0.h>
 #include <mach/irqs.h>
 #include "generic.h"
 
diff --git a/arch/arm/mach-sa1100/collie.c b/arch/arm/mach-sa1100/collie.c
index ea5cff3..170cb61 100644
--- a/arch/arm/mach-sa1100/collie.c
+++ b/arch/arm/mach-sa1100/collie.c
@@ -45,7 +45,7 @@
 #include <asm/hardware/scoop.h>
 #include <asm/mach/sharpsl_param.h>
 #include <asm/hardware/locomo.h>
-#include <mach/mcp.h>
+#include <linux/platform_data/mfd-mcp-sa11x0.h>
 #include <mach/irqs.h>
 
 #include "generic.h"
diff --git a/arch/arm/mach-sa1100/lart.c b/arch/arm/mach-sa1100/lart.c
index b775a0a..7dc1a89 100644
--- a/arch/arm/mach-sa1100/lart.c
+++ b/arch/arm/mach-sa1100/lart.c
@@ -16,7 +16,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/mach/serial_sa1100.h>
-#include <mach/mcp.h>
+#include <linux/platform_data/mfd-mcp-sa11x0.h>
 #include <mach/irqs.h>
 
 #include "generic.h"
diff --git a/arch/arm/mach-sa1100/shannon.c b/arch/arm/mach-sa1100/shannon.c
index 5d33fc3..ff6b7b3 100644
--- a/arch/arm/mach-sa1100/shannon.c
+++ b/arch/arm/mach-sa1100/shannon.c
@@ -19,7 +19,7 @@
 #include <asm/mach/flash.h>
 #include <asm/mach/map.h>
 #include <asm/mach/serial_sa1100.h>
-#include <mach/mcp.h>
+#include <linux/platform_data/mfd-mcp-sa11x0.h>
 #include <mach/shannon.h>
 #include <mach/irqs.h>
 
diff --git a/arch/arm/mach-sa1100/simpad.c b/arch/arm/mach-sa1100/simpad.c
index fbd5359..c73e1a3 100644
--- a/arch/arm/mach-sa1100/simpad.c
+++ b/arch/arm/mach-sa1100/simpad.c
@@ -24,7 +24,7 @@
 #include <asm/mach/flash.h>
 #include <asm/mach/map.h>
 #include <asm/mach/serial_sa1100.h>
-#include <mach/mcp.h>
+#include <linux/platform_data/mfd-mcp-sa11x0.h>
 #include <mach/simpad.h>
 #include <mach/irqs.h>
 
diff --git a/drivers/mfd/mcp-sa11x0.c b/drivers/mfd/mcp-sa11x0.c
index c54e244..f99d629 100644
--- a/drivers/mfd/mcp-sa11x0.c
+++ b/drivers/mfd/mcp-sa11x0.c
@@ -24,7 +24,7 @@
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
-#include <mach/mcp.h>
+#include <linux/platform_data/mfd-mcp-sa11x0.h>
 
 #define DRIVER_NAME "sa11x0-mcp"
 
diff --git a/arch/arm/mach-sa1100/include/mach/mcp.h b/include/linux/platform_data/mfd-mcp-sa11x0.h
similarity index 100%
rename from arch/arm/mach-sa1100/include/mach/mcp.h
rename to include/linux/platform_data/mfd-mcp-sa11x0.h
-- 
1.7.10
