From: ben-linux@fluff.org (Ben Dooks)
Date: Mon, 18 Jan 2010 02:38:39 +0000
Subject: [PATCH] ARM: SAMSUNG: Move gpiolib support in gpio.c to plat-samsung
In-Reply-To: <1263782319-20775-1-git-send-email-ben-linux@fluff.org>
References: <1263782319-20775-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1263782319-20775-5-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the gpio.c code containing the core gpiolib and GPIO support to
plat-samsung from plat-s3c as it is used by all current Samsung SoCs.

Note, we didn't move this to gpiolib.c as it contains code that is not
strictly for gpiolib support and the 4bit code is already called gpiolib.c
so make the change easier by not renaming both files in one go.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/plat-s3c/Makefile                 |    1 -
 arch/arm/plat-samsung/Makefile             |    1 +
 arch/arm/{plat-s3c => plat-samsung}/gpio.c |    0
 3 files changed, 1 insertions(+), 1 deletions(-)
 rename arch/arm/{plat-s3c => plat-samsung}/gpio.c (100%)

diff --git a/arch/arm/plat-s3c/Makefile b/arch/arm/plat-s3c/Makefile
index ac12ba5..20cb335 100644
--- a/arch/arm/plat-s3c/Makefile
+++ b/arch/arm/plat-s3c/Makefile
@@ -13,7 +13,6 @@ obj-				:=
 
 obj-y				+= init.o
 obj-y				+= time.o
-obj-y				+= gpio.o
 
 # DMA support
 
diff --git a/arch/arm/plat-samsung/Makefile b/arch/arm/plat-samsung/Makefile
index 0310e04..612450f 100644
--- a/arch/arm/plat-samsung/Makefile
+++ b/arch/arm/plat-samsung/Makefile
@@ -13,6 +13,7 @@ obj-				:=
 
 obj-y				+= clock.o
 obj-y				+= pwm-clock.o
+obj-y				+= gpio.o
 obj-y				+= gpio-config.o
 
 obj-$(CONFIG_SAMSUNG_GPIOLIB)	+= gpiolib.o
diff --git a/arch/arm/plat-s3c/gpio.c b/arch/arm/plat-samsung/gpio.c
similarity index 100%
rename from arch/arm/plat-s3c/gpio.c
rename to arch/arm/plat-samsung/gpio.c
-- 
1.6.0.4
