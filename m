From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Mon, 7 May 2012 19:43:17 +0200
Subject: [PATCH 4/5] ARM: S3C24XX: move common power-management code to
 mach-s3c24xx
In-Reply-To: <201205071939.37433.heiko@sntech.de>
References: <201205071939.37433.heiko@sntech.de>
Message-ID: <201205071943.17640.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the basic power-management code used by all s3c24xx machines.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/mach-s3c24xx/Makefile                   |    4 ++++
 arch/arm/{plat-s3c24xx => mach-s3c24xx}/irq-pm.c |    0
 arch/arm/{plat-s3c24xx => mach-s3c24xx}/pm.c     |    0
 arch/arm/{plat-s3c24xx => mach-s3c24xx}/sleep.S  |    0
 arch/arm/plat-s3c24xx/Makefile                   |    3 ---
 5 files changed, 4 insertions(+), 3 deletions(-)
 rename arch/arm/{plat-s3c24xx => mach-s3c24xx}/irq-pm.c (100%)
 rename arch/arm/{plat-s3c24xx => mach-s3c24xx}/pm.c (100%)
 rename arch/arm/{plat-s3c24xx => mach-s3c24xx}/sleep.S (100%)

diff --git a/arch/arm/mach-s3c24xx/Makefile b/arch/arm/mach-s3c24xx/Makefile
index d56b990..0ab6ab1 100644
--- a/arch/arm/mach-s3c24xx/Makefile
+++ b/arch/arm/mach-s3c24xx/Makefile
@@ -35,6 +35,10 @@ obj-$(CONFIG_S3C2440_DMA)	+= dma-s3c2440.o
 
 obj-$(CONFIG_CPU_S3C2443)	+= s3c2443.o irq-s3c2443.o clock-s3c2443.o
 
+# PM
+
+obj-$(CONFIG_PM)		+= pm.o irq-pm.o sleep.o
+
 # common code
 
 obj-$(CONFIG_S3C2443_COMMON)	+= common-s3c2443.o
diff --git a/arch/arm/plat-s3c24xx/irq-pm.c b/arch/arm/mach-s3c24xx/irq-pm.c
similarity index 100%
rename from arch/arm/plat-s3c24xx/irq-pm.c
rename to arch/arm/mach-s3c24xx/irq-pm.c
diff --git a/arch/arm/plat-s3c24xx/pm.c b/arch/arm/mach-s3c24xx/pm.c
similarity index 100%
rename from arch/arm/plat-s3c24xx/pm.c
rename to arch/arm/mach-s3c24xx/pm.c
diff --git a/arch/arm/plat-s3c24xx/sleep.S b/arch/arm/mach-s3c24xx/sleep.S
similarity index 100%
rename from arch/arm/plat-s3c24xx/sleep.S
rename to arch/arm/mach-s3c24xx/sleep.S
diff --git a/arch/arm/plat-s3c24xx/Makefile b/arch/arm/plat-s3c24xx/Makefile
index 3b1d7b8..937fc67 100644
--- a/arch/arm/plat-s3c24xx/Makefile
+++ b/arch/arm/plat-s3c24xx/Makefile
@@ -20,9 +20,6 @@ obj-$(CONFIG_CPU_FREQ_S3C24XX_DEBUGFS) += cpu-freq-debugfs.o
 
 # Architecture dependent builds
 
-obj-$(CONFIG_PM)		+= pm.o
-obj-$(CONFIG_PM)		+= irq-pm.o
-obj-$(CONFIG_PM)		+= sleep.o
 obj-$(CONFIG_S3C2410_CLOCK)	+= s3c2410-clock.o
 obj-$(CONFIG_S3C24XX_DMA)	+= dma.o
 obj-$(CONFIG_S3C2410_IOTIMING)	+= s3c2410-iotiming.o
-- 
1.7.5.4
