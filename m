From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon,  1 Aug 2011 09:29:27 +0900
Subject: [PATCH] ARM: SAMSUNG: Fix build of dev- infrastructure for module.h
	changes
Message-ID: <1312158567-22483-1-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The recent module.h changes cause a bunch of missing includes in the
Samsung dev- infrastructure.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/plat-samsung/dev-adc.c       |    2 ++
 arch/arm/plat-samsung/dev-backlight.c |    3 +++
 arch/arm/plat-samsung/dev-ide.c       |    2 ++
 arch/arm/plat-samsung/dev-ts.c        |    2 ++
 arch/arm/plat-samsung/dev-wdt.c       |    3 +++
 arch/arm/plat-samsung/platformdata.c  |    1 +
 6 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-samsung/dev-adc.c b/arch/arm/plat-samsung/dev-adc.c
index 9d903d4..c7e3257 100644
--- a/arch/arm/plat-samsung/dev-adc.c
+++ b/arch/arm/plat-samsung/dev-adc.c
@@ -13,6 +13,8 @@
 #include <linux/string.h>
 #include <linux/platform_device.h>
 
+#include <asm/sizes.h>
+
 #include <mach/irqs.h>
 #include <mach/map.h>
 
diff --git a/arch/arm/plat-samsung/dev-backlight.c b/arch/arm/plat-samsung/dev-backlight.c
index 3cedd4c..825a884 100644
--- a/arch/arm/plat-samsung/dev-backlight.c
+++ b/arch/arm/plat-samsung/dev-backlight.c
@@ -14,6 +14,9 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/pwm_backlight.h>
+#include <linux/slab.h>
+
+#include <asm/sizes.h>
 
 #include <plat/devs.h>
 #include <plat/gpio-cfg.h>
diff --git a/arch/arm/plat-samsung/dev-ide.c b/arch/arm/plat-samsung/dev-ide.c
index b497982..5407574 100644
--- a/arch/arm/plat-samsung/dev-ide.c
+++ b/arch/arm/plat-samsung/dev-ide.c
@@ -14,6 +14,8 @@
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
 
+#include <asm/sizes.h>
+
 #include <mach/map.h>
 #include <plat/ata.h>
 #include <plat/devs.h>
diff --git a/arch/arm/plat-samsung/dev-ts.c b/arch/arm/plat-samsung/dev-ts.c
index 82543f0..3eede40 100644
--- a/arch/arm/plat-samsung/dev-ts.c
+++ b/arch/arm/plat-samsung/dev-ts.c
@@ -17,6 +17,8 @@
 #include <linux/string.h>
 #include <linux/platform_device.h>
 
+#include <asm/sizes.h>
+
 #include <mach/irqs.h>
 #include <mach/map.h>
 
diff --git a/arch/arm/plat-samsung/dev-wdt.c b/arch/arm/plat-samsung/dev-wdt.c
index 019b5b8..207a213 100644
--- a/arch/arm/plat-samsung/dev-wdt.c
+++ b/arch/arm/plat-samsung/dev-wdt.c
@@ -12,6 +12,9 @@
 
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
+#include <linux/module.h>
+
+#include <asm/sizes.h>
 
 #include <mach/irqs.h>
 #include <mach/map.h>
diff --git a/arch/arm/plat-samsung/platformdata.c b/arch/arm/plat-samsung/platformdata.c
index 7cf2e1e..f857593 100644
--- a/arch/arm/plat-samsung/platformdata.c
+++ b/arch/arm/plat-samsung/platformdata.c
@@ -12,6 +12,7 @@
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/platform_device.h>
+#include <linux/slab.h>
 
 #include <plat/devs.h>
 
-- 
1.7.5.4
