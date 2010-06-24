From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 24 Jun 2010 19:59:02 +0200
Subject: [PATCH 14/61] ARM: imx: rename mach dir for mx21 and mx27 to mach-imx
In-Reply-To: <1277387397-3467-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1277387397-3467-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1277402342-24921-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Finally all imx code should end up there, start with mach-mx2.  While
touching all files rename some files to use a hyphen instead of an
underscore.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/Makefile                                  |    2 +-
 arch/arm/{mach-mx2 => mach-imx}/Kconfig            |    0
 arch/arm/{mach-mx2 => mach-imx}/Makefile           |    6 +++---
 arch/arm/{mach-mx2 => mach-imx}/Makefile.boot      |    0
 .../clock_imx21.c => mach-imx/clock-imx21.c}       |    0
 .../clock_imx27.c => mach-imx/clock-imx27.c}       |    0
 .../{mach-mx2/cpu_imx27.c => mach-imx/cpu-imx27.c} |    0
 arch/arm/{mach-mx2 => mach-imx}/devices.c          |    0
 arch/arm/{mach-mx2 => mach-imx}/devices.h          |    0
 .../eukrea_mbimx27-baseboard.c                     |    0
 arch/arm/{mach-mx2 => mach-imx}/mach-cpuimx27.c    |    0
 arch/arm/{mach-mx2 => mach-imx}/mach-imx27lite.c   |    0
 arch/arm/{mach-mx2 => mach-imx}/mach-mx21ads.c     |    0
 arch/arm/{mach-mx2 => mach-imx}/mach-mx27_3ds.c    |    0
 arch/arm/{mach-mx2 => mach-imx}/mach-mx27ads.c     |    0
 arch/arm/{mach-mx2 => mach-imx}/mach-mxt_td60.c    |    0
 arch/arm/{mach-mx2 => mach-imx}/mach-pca100.c      |    0
 arch/arm/{mach-mx2 => mach-imx}/mach-pcm038.c      |    0
 arch/arm/{mach-mx2 => mach-imx}/mm-imx21.c         |    2 +-
 arch/arm/{mach-mx2 => mach-imx}/mm-imx27.c         |    2 +-
 arch/arm/{mach-mx2 => mach-imx}/pcm970-baseboard.c |    0
 arch/arm/{mach-mx2 => mach-imx}/serial.c           |    0
 arch/arm/plat-mxc/Kconfig                          |    2 +-
 23 files changed, 7 insertions(+), 7 deletions(-)
 rename arch/arm/{mach-mx2 => mach-imx}/Kconfig (100%)
 rename arch/arm/{mach-mx2 => mach-imx}/Makefile (80%)
 rename arch/arm/{mach-mx2 => mach-imx}/Makefile.boot (100%)
 rename arch/arm/{mach-mx2/clock_imx21.c => mach-imx/clock-imx21.c} (100%)
 rename arch/arm/{mach-mx2/clock_imx27.c => mach-imx/clock-imx27.c} (100%)
 rename arch/arm/{mach-mx2/cpu_imx27.c => mach-imx/cpu-imx27.c} (100%)
 rename arch/arm/{mach-mx2 => mach-imx}/devices.c (100%)
 rename arch/arm/{mach-mx2 => mach-imx}/devices.h (100%)
 rename arch/arm/{mach-mx2 => mach-imx}/eukrea_mbimx27-baseboard.c (100%)
 rename arch/arm/{mach-mx2 => mach-imx}/mach-cpuimx27.c (100%)
 rename arch/arm/{mach-mx2 => mach-imx}/mach-imx27lite.c (100%)
 rename arch/arm/{mach-mx2 => mach-imx}/mach-mx21ads.c (100%)
 rename arch/arm/{mach-mx2 => mach-imx}/mach-mx27_3ds.c (100%)
 rename arch/arm/{mach-mx2 => mach-imx}/mach-mx27ads.c (100%)
 rename arch/arm/{mach-mx2 => mach-imx}/mach-mxt_td60.c (100%)
 rename arch/arm/{mach-mx2 => mach-imx}/mach-pca100.c (100%)
 rename arch/arm/{mach-mx2 => mach-imx}/mach-pcm038.c (100%)
 rename arch/arm/{mach-mx2 => mach-imx}/mm-imx21.c (98%)
 rename arch/arm/{mach-mx2 => mach-imx}/mm-imx27.c (98%)
 rename arch/arm/{mach-mx2 => mach-imx}/pcm970-baseboard.c (100%)
 rename arch/arm/{mach-mx2 => mach-imx}/serial.c (100%)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 64ba313..c60d604 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -146,7 +146,7 @@ machine-$(CONFIG_ARCH_MMP)		:= mmp
 machine-$(CONFIG_ARCH_MSM)		:= msm
 machine-$(CONFIG_ARCH_MV78XX0)		:= mv78xx0
 machine-$(CONFIG_ARCH_MX1)		:= mx1
-machine-$(CONFIG_ARCH_MX2)		:= mx2
+machine-$(CONFIG_ARCH_MX2)		:= imx
 machine-$(CONFIG_ARCH_MX25)		:= mx25
 machine-$(CONFIG_ARCH_MX3)		:= mx3
 machine-$(CONFIG_ARCH_MX5)		:= mx5
diff --git a/arch/arm/mach-mx2/Kconfig b/arch/arm/mach-imx/Kconfig
similarity index 100%
rename from arch/arm/mach-mx2/Kconfig
rename to arch/arm/mach-imx/Kconfig
diff --git a/arch/arm/mach-mx2/Makefile b/arch/arm/mach-imx/Makefile
similarity index 80%
rename from arch/arm/mach-mx2/Makefile
rename to arch/arm/mach-imx/Makefile
index e3254fa..068f493 100644
--- a/arch/arm/mach-mx2/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -6,10 +6,10 @@
 
 obj-y	:=  devices.o serial.o
 
-obj-$(CONFIG_MACH_MX21) += clock_imx21.o mm-imx21.o
+obj-$(CONFIG_MACH_MX21) += clock-imx21.o mm-imx21.o
 
-obj-$(CONFIG_MACH_MX27) += cpu_imx27.o
-obj-$(CONFIG_MACH_MX27) += clock_imx27.o mm-imx27.o
+obj-$(CONFIG_MACH_MX27) += cpu-imx27.o
+obj-$(CONFIG_MACH_MX27) += clock-imx27.o mm-imx27.o
 
 obj-$(CONFIG_MACH_MX21ADS) += mach-mx21ads.o
 obj-$(CONFIG_MACH_MX27ADS) += mach-mx27ads.o
diff --git a/arch/arm/mach-mx2/Makefile.boot b/arch/arm/mach-imx/Makefile.boot
similarity index 100%
rename from arch/arm/mach-mx2/Makefile.boot
rename to arch/arm/mach-imx/Makefile.boot
diff --git a/arch/arm/mach-mx2/clock_imx21.c b/arch/arm/mach-imx/clock-imx21.c
similarity index 100%
rename from arch/arm/mach-mx2/clock_imx21.c
rename to arch/arm/mach-imx/clock-imx21.c
diff --git a/arch/arm/mach-mx2/clock_imx27.c b/arch/arm/mach-imx/clock-imx27.c
similarity index 100%
rename from arch/arm/mach-mx2/clock_imx27.c
rename to arch/arm/mach-imx/clock-imx27.c
diff --git a/arch/arm/mach-mx2/cpu_imx27.c b/arch/arm/mach-imx/cpu-imx27.c
similarity index 100%
rename from arch/arm/mach-mx2/cpu_imx27.c
rename to arch/arm/mach-imx/cpu-imx27.c
diff --git a/arch/arm/mach-mx2/devices.c b/arch/arm/mach-imx/devices.c
similarity index 100%
rename from arch/arm/mach-mx2/devices.c
rename to arch/arm/mach-imx/devices.c
diff --git a/arch/arm/mach-mx2/devices.h b/arch/arm/mach-imx/devices.h
similarity index 100%
rename from arch/arm/mach-mx2/devices.h
rename to arch/arm/mach-imx/devices.h
diff --git a/arch/arm/mach-mx2/eukrea_mbimx27-baseboard.c b/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
similarity index 100%
rename from arch/arm/mach-mx2/eukrea_mbimx27-baseboard.c
rename to arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
diff --git a/arch/arm/mach-mx2/mach-cpuimx27.c b/arch/arm/mach-imx/mach-cpuimx27.c
similarity index 100%
rename from arch/arm/mach-mx2/mach-cpuimx27.c
rename to arch/arm/mach-imx/mach-cpuimx27.c
diff --git a/arch/arm/mach-mx2/mach-imx27lite.c b/arch/arm/mach-imx/mach-imx27lite.c
similarity index 100%
rename from arch/arm/mach-mx2/mach-imx27lite.c
rename to arch/arm/mach-imx/mach-imx27lite.c
diff --git a/arch/arm/mach-mx2/mach-mx21ads.c b/arch/arm/mach-imx/mach-mx21ads.c
similarity index 100%
rename from arch/arm/mach-mx2/mach-mx21ads.c
rename to arch/arm/mach-imx/mach-mx21ads.c
diff --git a/arch/arm/mach-mx2/mach-mx27_3ds.c b/arch/arm/mach-imx/mach-mx27_3ds.c
similarity index 100%
rename from arch/arm/mach-mx2/mach-mx27_3ds.c
rename to arch/arm/mach-imx/mach-mx27_3ds.c
diff --git a/arch/arm/mach-mx2/mach-mx27ads.c b/arch/arm/mach-imx/mach-mx27ads.c
similarity index 100%
rename from arch/arm/mach-mx2/mach-mx27ads.c
rename to arch/arm/mach-imx/mach-mx27ads.c
diff --git a/arch/arm/mach-mx2/mach-mxt_td60.c b/arch/arm/mach-imx/mach-mxt_td60.c
similarity index 100%
rename from arch/arm/mach-mx2/mach-mxt_td60.c
rename to arch/arm/mach-imx/mach-mxt_td60.c
diff --git a/arch/arm/mach-mx2/mach-pca100.c b/arch/arm/mach-imx/mach-pca100.c
similarity index 100%
rename from arch/arm/mach-mx2/mach-pca100.c
rename to arch/arm/mach-imx/mach-pca100.c
diff --git a/arch/arm/mach-mx2/mach-pcm038.c b/arch/arm/mach-imx/mach-pcm038.c
similarity index 100%
rename from arch/arm/mach-mx2/mach-pcm038.c
rename to arch/arm/mach-imx/mach-pcm038.c
diff --git a/arch/arm/mach-mx2/mm-imx21.c b/arch/arm/mach-imx/mm-imx21.c
similarity index 98%
rename from arch/arm/mach-mx2/mm-imx21.c
rename to arch/arm/mach-imx/mm-imx21.c
index 6413431..115c212 100644
--- a/arch/arm/mach-mx2/mm-imx21.c
+++ b/arch/arm/mach-imx/mm-imx21.c
@@ -1,5 +1,5 @@
 /*
- * arch/arm/mach-mx2/mm-imx21.c
+ * arch/arm/mach-imx/mm-imx21.c
  *
  * Copyright (C) 2008 Juergen Beisert (kernel at pengutronix.de)
  *
diff --git a/arch/arm/mach-mx2/mm-imx27.c b/arch/arm/mach-imx/mm-imx27.c
similarity index 98%
rename from arch/arm/mach-mx2/mm-imx27.c
rename to arch/arm/mach-imx/mm-imx27.c
index 3366ed4..89b4174 100644
--- a/arch/arm/mach-mx2/mm-imx27.c
+++ b/arch/arm/mach-imx/mm-imx27.c
@@ -1,5 +1,5 @@
 /*
- * arch/arm/mach-mx2/mm-imx27.c
+ * arch/arm/mach-imx/mm-imx27.c
  *
  * Copyright (C) 2008 Juergen Beisert (kernel at pengutronix.de)
  *
diff --git a/arch/arm/mach-mx2/pcm970-baseboard.c b/arch/arm/mach-imx/pcm970-baseboard.c
similarity index 100%
rename from arch/arm/mach-mx2/pcm970-baseboard.c
rename to arch/arm/mach-imx/pcm970-baseboard.c
diff --git a/arch/arm/mach-mx2/serial.c b/arch/arm/mach-imx/serial.c
similarity index 100%
rename from arch/arm/mach-mx2/serial.c
rename to arch/arm/mach-imx/serial.c
diff --git a/arch/arm/plat-mxc/Kconfig b/arch/arm/plat-mxc/Kconfig
index 7f7ad6f..4974fcc 100644
--- a/arch/arm/plat-mxc/Kconfig
+++ b/arch/arm/plat-mxc/Kconfig
@@ -49,7 +49,7 @@ config ARCH_MX5
 endchoice
 
 source "arch/arm/mach-mx1/Kconfig"
-source "arch/arm/mach-mx2/Kconfig"
+source "arch/arm/mach-imx/Kconfig"
 source "arch/arm/mach-mx3/Kconfig"
 source "arch/arm/mach-mx25/Kconfig"
 source "arch/arm/mach-mxc91231/Kconfig"
-- 
1.7.1
