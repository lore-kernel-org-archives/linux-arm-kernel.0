From: ben-linux@fluff.org (Ben Dooks)
Date: Fri, 29 Jan 2010 09:02:14 +0000
Subject: [PATCH] ARM: SAMSUNG: Move pm.c to plat-samsung
In-Reply-To: <1264755741-16184-1-git-send-email-ben-linux@fluff.org>
References: <1264755741-16184-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1264755741-16184-4-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move pm.c to plat-samsung, it should be usable by all Samsung systems

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/plat-s3c/Makefile               |    4 ----
 arch/arm/plat-samsung/Makefile           |    1 +
 arch/arm/{plat-s3c => plat-samsung}/pm.c |    0
 3 files changed, 1 insertions(+), 4 deletions(-)
 rename arch/arm/{plat-s3c => plat-samsung}/pm.c (100%)

diff --git a/arch/arm/plat-s3c/Makefile b/arch/arm/plat-s3c/Makefile
index 89dbdb0..197b9bd 100644
--- a/arch/arm/plat-s3c/Makefile
+++ b/arch/arm/plat-s3c/Makefile
@@ -17,7 +17,3 @@ obj-y				+= time.o
 # DMA support
 
 obj-$(CONFIG_S3C_DMA)		+= dma.o
-
-# PM support
-
-obj-$(CONFIG_PM)		+= pm.o
diff --git a/arch/arm/plat-samsung/Makefile b/arch/arm/plat-samsung/Makefile
index c8c8cae..629fd9f 100644
--- a/arch/arm/plat-samsung/Makefile
+++ b/arch/arm/plat-samsung/Makefile
@@ -41,6 +41,7 @@ obj-$(CONFIG_S3C_DEV_NAND)	+= dev-nand.o
 
 # PM support
 
+obj-$(CONFIG_PM)		+= pm.o
 obj-$(CONFIG_PM)		+= pm-gpio.o
 obj-$(CONFIG_SAMSUNG_PM_CHECK)	+= pm-check.o
 
diff --git a/arch/arm/plat-s3c/pm.c b/arch/arm/plat-samsung/pm.c
similarity index 100%
rename from arch/arm/plat-s3c/pm.c
rename to arch/arm/plat-samsung/pm.c
-- 
1.6.0.4
