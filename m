From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 30 Aug 2011 21:27:25 +0900
Subject: [PATCH 3/7 (RE-SEND)] gpio/s5p64x0: move gpio driver into
	drivers/gpio/
In-Reply-To: <1314707249-12241-1-git-send-email-kgene.kim@samsung.com>
References: <1314707249-12241-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1314707249-12241-4-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Grant Likely <grant.likely@secretlab.ca>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5p64x0/Makefile                     |    2 +-
 drivers/gpio/Kconfig                               |    4 ++++
 drivers/gpio/Makefile                              |    1 +
 .../gpiolib.c => drivers/gpio/gpio-s5p64x0.c       |    3 +--
 4 files changed, 7 insertions(+), 3 deletions(-)
 rename arch/arm/mach-s5p64x0/gpiolib.c => drivers/gpio/gpio-s5p64x0.c (99%)

diff --git a/arch/arm/mach-s5p64x0/Makefile b/arch/arm/mach-s5p64x0/Makefile
index 5f6afdf..5b94955 100644
--- a/arch/arm/mach-s5p64x0/Makefile
+++ b/arch/arm/mach-s5p64x0/Makefile
@@ -12,7 +12,7 @@ obj-				:=
 
 # Core support for S5P64X0 system
 
-obj-$(CONFIG_ARCH_S5P64X0)	+= cpu.o init.o clock.o dma.o gpiolib.o
+obj-$(CONFIG_ARCH_S5P64X0)	+= cpu.o init.o clock.o dma.o
 obj-$(CONFIG_ARCH_S5P64X0)	+= setup-i2c0.o irq-eint.o
 obj-$(CONFIG_CPU_S5P6440)	+= clock-s5p6440.o
 obj-$(CONFIG_CPU_S5P6450)	+= clock-s5p6450.o
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 6368730..5eb29bc 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -143,6 +143,10 @@ config GPIO_S3C64XX
 	def_bool y
 	depends on ARCH_S3C64XX
 
+config GPIO_S5P64X0
+	def_bool y
+	depends on ARCH_S5P64X0
+
 config GPIO_S5PC100
 	def_bool y
 	depends on CPU_S5PC100
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 8c1fb23..10f3bbf 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -42,6 +42,7 @@ obj-$(CONFIG_GPIO_RDC321X)	+= gpio-rdc321x.o
 obj-$(CONFIG_GPIO_PLAT_SAMSUNG)	+= gpio-plat-samsung.o
 obj-$(CONFIG_GPIO_S3C24XX)	+= gpio-s3c24xx.o
 obj-$(CONFIG_GPIO_S3C64XX)	+= gpio-s3c64xx.o
+obj-$(CONFIG_GPIO_S5P64X0)	+= gpio-s5p64x0.o
 obj-$(CONFIG_GPIO_S5PC100)	+= gpio-s5pc100.o
 obj-$(CONFIG_GPIO_S5PV210)	+= gpio-s5pv210.o
 
diff --git a/arch/arm/mach-s5p64x0/gpiolib.c b/drivers/gpio/gpio-s5p64x0.c
similarity index 99%
rename from arch/arm/mach-s5p64x0/gpiolib.c
rename to drivers/gpio/gpio-s5p64x0.c
index e7fb3b0..96e816f 100644
--- a/arch/arm/mach-s5p64x0/gpiolib.c
+++ b/drivers/gpio/gpio-s5p64x0.c
@@ -1,5 +1,4 @@
-/* linux/arch/arm/mach-s5p64x0/gpiolib.c
- *
+/*
  * Copyright (c) 2009-2010 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
  *
-- 
1.7.1
