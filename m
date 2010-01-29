From: ben-linux@fluff.org (Ben Dooks)
Date: Fri, 29 Jan 2010 09:02:15 +0000
Subject: [PATCH] ARM: SAMSUNG: Move DMA support to plat-samsung
In-Reply-To: <1264755741-16184-1-git-send-email-ben-linux@fluff.org>
References: <1264755741-16184-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1264755741-16184-5-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the core of the DMA support to plat-samsung for everyone to use.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/plat-s3c/Makefile                         |    4 ----
 arch/arm/plat-samsung/Makefile                     |    4 ++++
 arch/arm/{plat-s3c => plat-samsung}/dma.c          |    0
 .../{plat-s3c => plat-samsung}/include/plat/dma.h  |    2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)
 rename arch/arm/{plat-s3c => plat-samsung}/dma.c (100%)
 rename arch/arm/{plat-s3c => plat-samsung}/include/plat/dma.h (98%)

diff --git a/arch/arm/plat-s3c/Makefile b/arch/arm/plat-s3c/Makefile
index 197b9bd..2a3c4a4 100644
--- a/arch/arm/plat-s3c/Makefile
+++ b/arch/arm/plat-s3c/Makefile
@@ -13,7 +13,3 @@ obj-				:=
 
 obj-y				+= init.o
 obj-y				+= time.o
-
-# DMA support
-
-obj-$(CONFIG_S3C_DMA)		+= dma.o
diff --git a/arch/arm/plat-samsung/Makefile b/arch/arm/plat-samsung/Makefile
index 629fd9f..facc7e3 100644
--- a/arch/arm/plat-samsung/Makefile
+++ b/arch/arm/plat-samsung/Makefile
@@ -39,6 +39,10 @@ obj-$(CONFIG_S3C_DEV_USB_HOST)	+= dev-usb.o
 obj-$(CONFIG_S3C_DEV_USB_HSOTG)	+= dev-usb-hsotg.o
 obj-$(CONFIG_S3C_DEV_NAND)	+= dev-nand.o
 
+# DMA support
+
+obj-$(CONFIG_S3C_DMA)		+= dma.o
+
 # PM support
 
 obj-$(CONFIG_PM)		+= pm.o
diff --git a/arch/arm/plat-s3c/dma.c b/arch/arm/plat-samsung/dma.c
similarity index 100%
rename from arch/arm/plat-s3c/dma.c
rename to arch/arm/plat-samsung/dma.c
diff --git a/arch/arm/plat-s3c/include/plat/dma.h b/arch/arm/plat-samsung/include/plat/dma.h
similarity index 98%
rename from arch/arm/plat-s3c/include/plat/dma.h
rename to arch/arm/plat-samsung/include/plat/dma.h
index e429d10..7584d75 100644
--- a/arch/arm/plat-s3c/include/plat/dma.h
+++ b/arch/arm/plat-samsung/include/plat/dma.h
@@ -1,4 +1,4 @@
-/* arch/arm/plat-s3c/include/plat/dma.h
+/* arch/arm/plat-samsung/include/plat/dma.h
  *
  * Copyright (C) 2003-2006 Simtec Electronics
  *	Ben Dooks <ben@simtec.co.uk>
-- 
1.6.0.4
