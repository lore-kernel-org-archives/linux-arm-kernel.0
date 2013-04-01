From: alex@digriz.org.uk (Alexander Clouter)
Date: Tue,  2 Apr 2013 00:22:40 +0100
Subject: [PATCH 1/6] rtc: rtc-m48t86: move m48t86.h to platform_data
In-Reply-To: <1364858565-17192-1-git-send-email-alex@digriz.org.uk>
References: <1364858565-17192-1-git-send-email-alex@digriz.org.uk>
Message-ID: <1364858565-17192-2-git-send-email-alex@digriz.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The header for the rtc-m48t86 platform-data should be in
include/linux/platform_data.

Signed-off-by: Alexander Clouter <alex@digriz.org.uk>
---
 arch/arm/mach-ep93xx/ts72xx.c                          |    2 +-
 arch/arm/mach-orion5x/ts78xx-setup.c                   |    2 +-
 drivers/rtc/rtc-m48t86.c                               |    2 +-
 include/linux/{m48t86.h => platform_data/rtc-m48t86.h} |    0
 4 files changed, 3 insertions(+), 3 deletions(-)
 rename include/linux/{m48t86.h => platform_data/rtc-m48t86.h} (100%)

diff --git a/arch/arm/mach-ep93xx/ts72xx.c b/arch/arm/mach-ep93xx/ts72xx.c
index 61f4b5d..a278639 100644
--- a/arch/arm/mach-ep93xx/ts72xx.c
+++ b/arch/arm/mach-ep93xx/ts72xx.c
@@ -16,7 +16,7 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
-#include <linux/m48t86.h>
+#include <linux/platform_data/rtc-m48t86.h>
 #include <linux/mtd/nand.h>
 #include <linux/mtd/partitions.h>
 
diff --git a/arch/arm/mach-orion5x/ts78xx-setup.c b/arch/arm/mach-orion5x/ts78xx-setup.c
index e960855..ffe3603 100644
--- a/arch/arm/mach-orion5x/ts78xx-setup.c
+++ b/arch/arm/mach-orion5x/ts78xx-setup.c
@@ -16,7 +16,7 @@
 #include <linux/platform_device.h>
 #include <linux/mv643xx_eth.h>
 #include <linux/ata_platform.h>
-#include <linux/m48t86.h>
+#include <linux/platform_data/rtc-m48t86.h>
 #include <linux/mtd/nand.h>
 #include <linux/mtd/partitions.h>
 #include <linux/timeriomem-rng.h>
diff --git a/drivers/rtc/rtc-m48t86.c b/drivers/rtc/rtc-m48t86.c
index 2ffbcac..25e0116 100644
--- a/drivers/rtc/rtc-m48t86.c
+++ b/drivers/rtc/rtc-m48t86.c
@@ -16,7 +16,7 @@
 #include <linux/module.h>
 #include <linux/rtc.h>
 #include <linux/platform_device.h>
-#include <linux/m48t86.h>
+#include <linux/platform_data/rtc-m48t86.h>
 #include <linux/bcd.h>
 
 #define M48T86_REG_SEC		0x00
diff --git a/include/linux/m48t86.h b/include/linux/platform_data/rtc-m48t86.h
similarity index 100%
rename from include/linux/m48t86.h
rename to include/linux/platform_data/rtc-m48t86.h
-- 
1.7.10.4
