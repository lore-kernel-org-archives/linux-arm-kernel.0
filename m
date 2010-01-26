From: ben-linux@fluff.org (Ben Dooks)
Date: Tue, 26 Jan 2010 07:58:03 +0000
Subject: [PATCH] ARM: S3C244X: Move S3C2442 code into S3C2440
In-Reply-To: <1264492686-16901-1-git-send-email-ben-linux@fluff.org>
References: <1264492686-16901-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1264492686-16901-5-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the remaining S3C2442 code into mach-s3c2440 as there is only one
file currently in there and these two SoCs are very similar.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/mach-s3c2440/Kconfig                     |   12 ++++++++++++
 arch/arm/mach-s3c2440/Makefile                    |    2 ++
 arch/arm/{mach-s3c2442 => mach-s3c2440}/s3c2442.c |    0
 arch/arm/mach-s3c2442/Kconfig                     |   11 -----------
 4 files changed, 14 insertions(+), 11 deletions(-)
 rename arch/arm/{mach-s3c2442 => mach-s3c2440}/s3c2442.c (100%)

diff --git a/arch/arm/mach-s3c2440/Kconfig b/arch/arm/mach-s3c2440/Kconfig
index 45cab7a..f496385 100644
--- a/arch/arm/mach-s3c2440/Kconfig
+++ b/arch/arm/mach-s3c2440/Kconfig
@@ -15,6 +15,18 @@ config CPU_S3C2440
 	help
 	  Support for S3C2440 Samsung Mobile CPU based systems.
 
+config CPU_S3C2442
+	bool
+	depends on ARCH_S3C2410
+	select CPU_ARM920T
+	select S3C2410_CLOCK
+	select S3C2410_GPIO
+	select S3C2410_PM if PM
+	select CPU_S3C244X
+	select CPU_LLSERIAL_S3C2440
+	help
+	  Support for S3C2442 Samsung Mobile CPU based systems.
+
 config S3C2440_DMA
 	bool
 	depends on ARCH_S3C2410 && CPU_S3C24405B
diff --git a/arch/arm/mach-s3c2440/Makefile b/arch/arm/mach-s3c2440/Makefile
index e51497c..e8412b3 100644
--- a/arch/arm/mach-s3c2440/Makefile
+++ b/arch/arm/mach-s3c2440/Makefile
@@ -10,6 +10,8 @@ obj-n				:=
 obj-				:=
 
 obj-$(CONFIG_CPU_S3C2440)	+= s3c2440.o dsc.o
+obj-$(CONFIG_CPU_S3C2442)	+= s3c2442.o
+
 obj-$(CONFIG_CPU_S3C2440)	+= irq.o
 obj-$(CONFIG_CPU_S3C2440)	+= clock.o
 obj-$(CONFIG_S3C2440_DMA)	+= dma.o
diff --git a/arch/arm/mach-s3c2442/s3c2442.c b/arch/arm/mach-s3c2440/s3c2442.c
similarity index 100%
rename from arch/arm/mach-s3c2442/s3c2442.c
rename to arch/arm/mach-s3c2440/s3c2442.c
diff --git a/arch/arm/mach-s3c2442/Kconfig b/arch/arm/mach-s3c2442/Kconfig
index 4832cd6..29ef066 100644
--- a/arch/arm/mach-s3c2442/Kconfig
+++ b/arch/arm/mach-s3c2442/Kconfig
@@ -2,14 +2,3 @@
 #
 # Licensed under GPLv2
 
-config CPU_S3C2442
-	bool
-	depends on ARCH_S3C2410
-	select CPU_ARM920T
-	select S3C2410_CLOCK
-	select S3C2410_GPIO
-	select S3C2410_PM if PM
-	select CPU_S3C244X
-	select CPU_LLSERIAL_S3C2440
-	help
-	  Support for S3C2442 Samsung Mobile CPU based systems.
-- 
1.6.0.4
