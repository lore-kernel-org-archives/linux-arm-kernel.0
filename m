From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 13 Jan 2011 16:59:25 +0100
Subject: [PATCH] ARM mxs: clkdev related compile fixes
In-Reply-To: <20101117090635.GF12959@game.jcrosoft.org>
References: <20101117090635.GF12959@game.jcrosoft.org>
Message-ID: <1294934365-17087-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sascha Hauer <s.hauer@pengutronix.de>

Since commit

	6d803ba (ARM: 6483/1: arm & sh: factorised duplicated clkdev.c)

platforms need to select CLKDEV_LOOKUP instead of COMMON_CLKDEV and need
to include <linux/clkdev.h>.

Cc: Shawn Guo <shawn.guo@freescale.com>
Cc: Lothar Wa?mann <LW@KARO-electronics.de>
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
[ukl: make commit log more verbose; remove selection of COMMON_CLKDEV]
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/Kconfig               |    2 +-
 arch/arm/mach-mxs/clock-mx23.c |    1 +
 arch/arm/mach-mxs/clock-mx28.c |    1 +
 3 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index e2f8011..041894e 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -368,7 +368,7 @@ config ARCH_MXS
 	bool "Freescale MXS-based"
 	select GENERIC_CLOCKEVENTS
 	select ARCH_REQUIRE_GPIOLIB
-	select COMMON_CLKDEV
+	select CLKDEV_LOOKUP
 	help
 	  Support for Freescale MXS-based family of processors
 
diff --git a/arch/arm/mach-mxs/clock-mx23.c b/arch/arm/mach-mxs/clock-mx23.c
index 8f5a19a..f94925b 100644
--- a/arch/arm/mach-mxs/clock-mx23.c
+++ b/arch/arm/mach-mxs/clock-mx23.c
@@ -21,6 +21,7 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/jiffies.h>
+#include <linux/clkdev.h>
 
 #include <asm/clkdev.h>
 #include <asm/div64.h>
diff --git a/arch/arm/mach-mxs/clock-mx28.c b/arch/arm/mach-mxs/clock-mx28.c
index 74e2103..56d7dc7 100644
--- a/arch/arm/mach-mxs/clock-mx28.c
+++ b/arch/arm/mach-mxs/clock-mx28.c
@@ -21,6 +21,7 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/jiffies.h>
+#include <linux/clkdev.h>
 
 #include <asm/clkdev.h>
 #include <asm/div64.h>
-- 
1.7.2.3
