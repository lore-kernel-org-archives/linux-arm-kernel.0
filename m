From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Fri, 20 Dec 2013 10:52:56 +0800
Subject: [PATCH 1/3] ARM: hisi: rename hi3xxx to hisi
Message-ID: <1387507978-4485-1-git-send-email-haojian.zhuang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since some new Hisilicon SoCs are not named as hi3xxx, rename mach-hi3xxx
to mach-hisi instead. And the pronounciation of "hisi" is similar to the
chinese pronounciation of Hisilicon. So Hisilicon guys like this name.

ARCH_HI3xxx will be renamed later since other drivers are using it and
they are still in linux-next git tree. So rename ARCH_HI3xxx later.

Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>
---
 arch/arm/Kconfig                                         | 4 ++--
 arch/arm/Makefile                                        | 2 +-
 arch/arm/{mach-hi3xxx => mach-hisi}/Kconfig              | 0
 arch/arm/{mach-hi3xxx => mach-hisi}/Makefile             | 4 ++--
 arch/arm/{mach-hi3xxx => mach-hisi}/core.h               | 0
 arch/arm/{mach-hi3xxx/hi3xxx.c => mach-hisi/hisilicon.c} | 2 +-
 arch/arm/{mach-hi3xxx => mach-hisi}/hotplug.c            | 0
 arch/arm/{mach-hi3xxx => mach-hisi}/platsmp.c            | 0
 8 files changed, 6 insertions(+), 6 deletions(-)
 rename arch/arm/{mach-hi3xxx => mach-hisi}/Kconfig (100%)
 rename arch/arm/{mach-hi3xxx => mach-hisi}/Makefile (51%)
 rename arch/arm/{mach-hi3xxx => mach-hisi}/core.h (100%)
 rename arch/arm/{mach-hi3xxx/hi3xxx.c => mach-hisi/hisilicon.c} (96%)
 rename arch/arm/{mach-hi3xxx => mach-hisi}/hotplug.c (100%)
 rename arch/arm/{mach-hi3xxx => mach-hisi}/platsmp.c (100%)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index a95e067..db8ddd1 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -928,10 +928,10 @@ source "arch/arm/mach-footbridge/Kconfig"
 
 source "arch/arm/mach-gemini/Kconfig"
 
-source "arch/arm/mach-hi3xxx/Kconfig"
-
 source "arch/arm/mach-highbank/Kconfig"
 
+source "arch/arm/mach-hisi/Kconfig"
+
 source "arch/arm/mach-integrator/Kconfig"
 
 source "arch/arm/mach-iop32x/Kconfig"
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index dfe2bc4..69a6613 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -156,8 +156,8 @@ machine-$(CONFIG_ARCH_EBSA110)		+= ebsa110
 machine-$(CONFIG_ARCH_EP93XX)		+= ep93xx
 machine-$(CONFIG_ARCH_EXYNOS)		+= exynos
 machine-$(CONFIG_ARCH_GEMINI)		+= gemini
-machine-$(CONFIG_ARCH_HI3xxx)		+= hi3xxx
 machine-$(CONFIG_ARCH_HIGHBANK)		+= highbank
+machine-$(CONFIG_ARCH_HI3xxx)		+= hisi
 machine-$(CONFIG_ARCH_INTEGRATOR)	+= integrator
 machine-$(CONFIG_ARCH_IOP13XX)		+= iop13xx
 machine-$(CONFIG_ARCH_IOP32X)		+= iop32x
diff --git a/arch/arm/mach-hi3xxx/Kconfig b/arch/arm/mach-hisi/Kconfig
similarity index 100%
rename from arch/arm/mach-hi3xxx/Kconfig
rename to arch/arm/mach-hisi/Kconfig
diff --git a/arch/arm/mach-hi3xxx/Makefile b/arch/arm/mach-hisi/Makefile
similarity index 51%
rename from arch/arm/mach-hi3xxx/Makefile
rename to arch/arm/mach-hisi/Makefile
index c9919e8..6870058 100644
--- a/arch/arm/mach-hi3xxx/Makefile
+++ b/arch/arm/mach-hisi/Makefile
@@ -1,7 +1,7 @@
 #
-# Makefile for Hisilicon Hi36xx/Hi37xx processors line
+# Makefile for Hisilicon processors family
 #
 
-obj-y	+= hi3xxx.o
+obj-y	+= hisilicon.o
 obj-$(CONFIG_SMP)		+= platsmp.o
 obj-$(CONFIG_HOTPLUG_CPU)	+= hotplug.o
diff --git a/arch/arm/mach-hi3xxx/core.h b/arch/arm/mach-hisi/core.h
similarity index 100%
rename from arch/arm/mach-hi3xxx/core.h
rename to arch/arm/mach-hisi/core.h
diff --git a/arch/arm/mach-hi3xxx/hi3xxx.c b/arch/arm/mach-hisi/hisilicon.c
similarity index 96%
rename from arch/arm/mach-hi3xxx/hi3xxx.c
rename to arch/arm/mach-hisi/hisilicon.c
index 661a912..685d9eb 100644
--- a/arch/arm/mach-hi3xxx/hi3xxx.c
+++ b/arch/arm/mach-hisi/hisilicon.c
@@ -1,5 +1,5 @@
 /*
- * (Hisilicon's Hi36xx/Hi37xx SoC based) flattened device tree enabled machine
+ * (Hisilicon's SoC based) flattened device tree enabled machine
  *
  * Copyright (c) 2012-2013 Hisilicon Ltd.
  * Copyright (c) 2012-2013 Linaro Ltd.
diff --git a/arch/arm/mach-hi3xxx/hotplug.c b/arch/arm/mach-hisi/hotplug.c
similarity index 100%
rename from arch/arm/mach-hi3xxx/hotplug.c
rename to arch/arm/mach-hisi/hotplug.c
diff --git a/arch/arm/mach-hi3xxx/platsmp.c b/arch/arm/mach-hisi/platsmp.c
similarity index 100%
rename from arch/arm/mach-hi3xxx/platsmp.c
rename to arch/arm/mach-hisi/platsmp.c
-- 
1.8.3.2
