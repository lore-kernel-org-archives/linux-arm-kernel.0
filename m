From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 18 Apr 2012 19:20:33 -0700
Subject: [PATCH 4/7] ARM: SAMSUNG: move hr timer for common s5p into
 plat-samsung
In-Reply-To: <1334802036-16768-1-git-send-email-kgene.kim@samsung.com>
References: <1334802036-16768-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1334802036-16768-5-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/plat-s5p/Kconfig                      |    6 ------
 arch/arm/plat-s5p/Makefile                     |    4 ----
 arch/arm/plat-samsung/Kconfig                  |    8 ++++++++
 arch/arm/plat-samsung/Makefile                 |    2 ++
 arch/arm/{plat-s5p => plat-samsung}/s5p-time.c |    3 +--
 5 files changed, 11 insertions(+), 12 deletions(-)
 rename arch/arm/{plat-s5p => plat-samsung}/s5p-time.c (99%)

diff --git a/arch/arm/plat-s5p/Kconfig b/arch/arm/plat-s5p/Kconfig
index 8e45c8b..795790d 100644
--- a/arch/arm/plat-s5p/Kconfig
+++ b/arch/arm/plat-s5p/Kconfig
@@ -23,12 +23,6 @@ config PLAT_S5P
 	help
 	  Base platform code for Samsung's S5P series SoC.
 
-config S5P_HRT
-	bool
-	select SAMSUNG_DEV_PWM
-	help
-	  Use the High Resolution timer support
-
 config S5P_DEV_UART
 	def_bool y
 	depends on (ARCH_S5P64X0 || ARCH_S5PC100 || ARCH_S5PV210)
diff --git a/arch/arm/plat-s5p/Makefile b/arch/arm/plat-s5p/Makefile
index c81106f..0a2ce38 100644
--- a/arch/arm/plat-s5p/Makefile
+++ b/arch/arm/plat-s5p/Makefile
@@ -10,10 +10,6 @@ obj-m				:=
 obj-n				:= dummy.o
 obj-				:=
 
-# Core files
-
-obj-$(CONFIG_S5P_HRT) 		+= s5p-time.o
-
 # devices
 
 obj-$(CONFIG_S5P_DEV_UART)	+= dev-uart.o
diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
index 56e6ae7..f27b295 100644
--- a/arch/arm/plat-samsung/Kconfig
+++ b/arch/arm/plat-samsung/Kconfig
@@ -50,6 +50,14 @@ config S3C_LOWLEVEL_UART_PORT
 	  this configuration should be between zero and two. The port
 	  must have been initialised by the boot-loader before use.
 
+# timer options
+
+config S5P_HRT
+	bool
+	select SAMSUNG_DEV_PWM
+	help
+	  Use the High Resolution timer support
+
 # clock options
 
 config SAMSUNG_CLKSRC
diff --git a/arch/arm/plat-samsung/Makefile b/arch/arm/plat-samsung/Makefile
index caa6f9a..6217c41 100644
--- a/arch/arm/plat-samsung/Makefile
+++ b/arch/arm/plat-samsung/Makefile
@@ -13,6 +13,8 @@ obj-				:=
 
 obj-y				+= init.o cpu.o
 obj-$(CONFIG_ARCH_USES_GETTIMEOFFSET)   += time.o
+obj-$(CONFIG_S5P_HRT) 		+= s5p-time.o
+
 obj-y				+= clock.o
 obj-y				+= pwm-clock.o
 
diff --git a/arch/arm/plat-s5p/s5p-time.c b/arch/arm/plat-samsung/s5p-time.c
similarity index 99%
rename from arch/arm/plat-s5p/s5p-time.c
rename to arch/arm/plat-samsung/s5p-time.c
index 17c0a2c..028b6e8 100644
--- a/arch/arm/plat-s5p/s5p-time.c
+++ b/arch/arm/plat-samsung/s5p-time.c
@@ -1,5 +1,4 @@
-/* linux/arch/arm/plat-s5p/s5p-time.c
- *
+/*
  * Copyright (c) 2011 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com/
  *
-- 
1.7.2.3
