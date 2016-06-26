From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 27 Jun 2016 00:03:03 +0200
Subject: [PATCH 5/5] rtc: v3020: move rtc-v3020.h to platform_data
In-Reply-To: <1466978583-13310-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1466978583-13310-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1466978583-13310-5-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

rtc-v3020.h belongs to include/linux/platform_data/

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
Cc: Daniel Mack <daniel@zonque.org>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: linux-arm-kernel at lists.infradead.org
 arch/arm/mach-pxa/cm-x270.c                   | 2 +-
 arch/arm/mach-pxa/cm-x300.c                   | 2 +-
 arch/arm/mach-pxa/em-x270.c                   | 2 +-
 drivers/rtc/rtc-v3020.c                       | 2 +-
 include/linux/{ => platform_data}/rtc-v3020.h | 0
 5 files changed, 4 insertions(+), 4 deletions(-)
 rename include/linux/{ => platform_data}/rtc-v3020.h (100%)

diff --git a/arch/arm/mach-pxa/cm-x270.c b/arch/arm/mach-pxa/cm-x270.c
index fa5f51d633a3..be4a66166d61 100644
--- a/arch/arm/mach-pxa/cm-x270.c
+++ b/arch/arm/mach-pxa/cm-x270.c
@@ -14,7 +14,7 @@
 #include <linux/gpio.h>
 #include <linux/delay.h>
 
-#include <linux/rtc-v3020.h>
+#include <linux/platform_data/rtc-v3020.h>
 #include <video/mbxfb.h>
 
 #include <linux/spi/spi.h>
diff --git a/arch/arm/mach-pxa/cm-x300.c b/arch/arm/mach-pxa/cm-x300.c
index 5f5ac7c8faf0..868448d2cd82 100644
--- a/arch/arm/mach-pxa/cm-x300.c
+++ b/arch/arm/mach-pxa/cm-x300.c
@@ -25,7 +25,7 @@
 #include <linux/gpio.h>
 #include <linux/dm9000.h>
 #include <linux/leds.h>
-#include <linux/rtc-v3020.h>
+#include <linux/platform_data/rtc-v3020.h>
 #include <linux/pwm.h>
 #include <linux/pwm_backlight.h>
 
diff --git a/arch/arm/mach-pxa/em-x270.c b/arch/arm/mach-pxa/em-x270.c
index 6e0268deec43..03354c21e1f2 100644
--- a/arch/arm/mach-pxa/em-x270.c
+++ b/arch/arm/mach-pxa/em-x270.c
@@ -14,7 +14,7 @@
 #include <linux/delay.h>
 
 #include <linux/dm9000.h>
-#include <linux/rtc-v3020.h>
+#include <linux/platform_data/rtc-v3020.h>
 #include <linux/mtd/nand.h>
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/physmap.h>
diff --git a/drivers/rtc/rtc-v3020.c b/drivers/rtc/rtc-v3020.c
index 7a0436329d6c..1f3117b5a83c 100644
--- a/drivers/rtc/rtc-v3020.c
+++ b/drivers/rtc/rtc-v3020.c
@@ -25,7 +25,7 @@
 #include <linux/rtc.h>
 #include <linux/types.h>
 #include <linux/bcd.h>
-#include <linux/rtc-v3020.h>
+#include <linux/platform_data/rtc-v3020.h>
 #include <linux/delay.h>
 #include <linux/gpio.h>
 #include <linux/slab.h>
diff --git a/include/linux/rtc-v3020.h b/include/linux/platform_data/rtc-v3020.h
similarity index 100%
rename from include/linux/rtc-v3020.h
rename to include/linux/platform_data/rtc-v3020.h
-- 
2.8.1
