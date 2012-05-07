From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Mon, 7 May 2012 19:40:38 +0200
Subject: [PATCH 1/5] ARM: S3C24XX: move plat-s3c24xx/cpu.c
In-Reply-To: <201205071939.37433.heiko@sntech.de>
References: <201205071939.37433.heiko@sntech.de>
Message-ID: <201205071940.38699.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Following the model of s3c64xx cpu.c becomes common.c in mach-s3c24xx,
to got more common code added later on.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/mach-s3c24xx/Makefile                     |    2 ++
 .../{plat-s3c24xx/cpu.c => mach-s3c24xx/common.c}  |    2 +-
 arch/arm/plat-s3c24xx/Makefile                     |    1 -
 3 files changed, 3 insertions(+), 2 deletions(-)
 rename arch/arm/{plat-s3c24xx/cpu.c => mach-s3c24xx/common.c} (99%)

diff --git a/arch/arm/mach-s3c24xx/Makefile b/arch/arm/mach-s3c24xx/Makefile
index d0f3a92..d56b990 100644
--- a/arch/arm/mach-s3c24xx/Makefile
+++ b/arch/arm/mach-s3c24xx/Makefile
@@ -14,6 +14,8 @@ obj-				:=
 
 # core
 
+obj-y				+= common.o
+
 obj-$(CONFIG_CPU_S3C2410)	+= s3c2410.o
 obj-$(CONFIG_S3C2410_DMA)	+= dma-s3c2410.o
 obj-$(CONFIG_S3C2410_PM)	+= pm-s3c2410.o sleep-s3c2410.o
diff --git a/arch/arm/plat-s3c24xx/cpu.c b/arch/arm/mach-s3c24xx/common.c
similarity index 99%
rename from arch/arm/plat-s3c24xx/cpu.c
rename to arch/arm/mach-s3c24xx/common.c
index 290942d..dc9927b 100644
--- a/arch/arm/plat-s3c24xx/cpu.c
+++ b/arch/arm/mach-s3c24xx/common.c
@@ -4,7 +4,7 @@
  *	http://www.simtec.co.uk/products/SWLINUX/
  *	Ben Dooks <ben@simtec.co.uk>
  *
- * S3C24XX CPU Support
+ * Common code for S3C24XX machines
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
diff --git a/arch/arm/plat-s3c24xx/Makefile b/arch/arm/plat-s3c24xx/Makefile
index 2467b80..f7fe935 100644
--- a/arch/arm/plat-s3c24xx/Makefile
+++ b/arch/arm/plat-s3c24xx/Makefile
@@ -12,7 +12,6 @@ obj-				:=
 
 # Core files
 
-obj-y				+= cpu.o
 obj-y				+= irq.o
 obj-y				+= dev-uart.o
 obj-y				+= clock.o
-- 
1.7.5.4
