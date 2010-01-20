From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 20 Jan 2010 03:48:51 +0000
Subject: [PATCH] ARM: SAMSUNG: Move pmw.c to plat-samsung
In-Reply-To: <1263959332-6264-1-git-send-email-ben-linux@fluff.org>
References: <1263959332-6264-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1263959332-6264-3-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the PWM driver support to plat-samsung, as these PWM blocks are
close enough across the current range to be supported by this driver.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/plat-s3c/Makefile                |    4 ----
 arch/arm/plat-samsung/Makefile            |    4 ++++
 arch/arm/{plat-s3c => plat-samsung}/pwm.c |    0
 3 files changed, 4 insertions(+), 4 deletions(-)
 rename arch/arm/{plat-s3c => plat-samsung}/pwm.c (100%)

diff --git a/arch/arm/plat-s3c/Makefile b/arch/arm/plat-s3c/Makefile
index 20cb335..095bc97 100644
--- a/arch/arm/plat-s3c/Makefile
+++ b/arch/arm/plat-s3c/Makefile
@@ -22,7 +22,3 @@ obj-$(CONFIG_S3C_DMA)		+= dma.o
 
 obj-$(CONFIG_PM)		+= pm.o
 obj-$(CONFIG_S3C2410_PM_CHECK)	+= pm-check.o
-
-# PWM support
-
-obj-$(CONFIG_HAVE_PWM)		+= pwm.o
diff --git a/arch/arm/plat-samsung/Makefile b/arch/arm/plat-samsung/Makefile
index 27d5bfb..f31e64f 100644
--- a/arch/arm/plat-samsung/Makefile
+++ b/arch/arm/plat-samsung/Makefile
@@ -42,3 +42,7 @@ obj-$(CONFIG_S3C_DEV_NAND)	+= dev-nand.o
 # PM support
 
 obj-$(CONFIG_PM)		+= pm-gpio.o
+
+# PWM support
+
+obj-$(CONFIG_HAVE_PWM)		+= pwm.o
diff --git a/arch/arm/plat-s3c/pwm.c b/arch/arm/plat-samsung/pwm.c
similarity index 100%
rename from arch/arm/plat-s3c/pwm.c
rename to arch/arm/plat-samsung/pwm.c
-- 
1.6.0.4
