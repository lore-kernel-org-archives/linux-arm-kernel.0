From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Thu, 20 Mar 2014 13:55:24 +0900
Subject: [PATCH v3 3/4] ARM: S3C24XX: move S3C24XX clock Kconfig options to
 Samsung clock Kconfig file
In-Reply-To: <1395291325-4043-1-git-send-email-pankaj.dubey@samsung.com>
References: <1394598781-3848-1-git-send-email-pankaj.dubey@samsung.com>
 <1395291325-4043-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <1395291325-4043-4-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch moves S3C24XX specific clock Kconfig options into
"clk/samsung/Kconfig" and also removes COMMON_CLK selection from
"mach-s3c24xx/Kconfig" as S3C24XX_COMMON_CLK is selecting it's dependency.

CC: Ben Dooks <ben-linux@fluff.org>
CC: Kukjin Kim <kgene.kim@samsung.com>
CC: Russell King <linux@arm.linux.org.uk>
CC: Mike Turquette <mturquette@linaro.org>
CC: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 arch/arm/mach-s3c24xx/Kconfig |   14 --------------
 drivers/clk/samsung/Kconfig   |    9 +++++++++
 2 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/Kconfig b/arch/arm/mach-s3c24xx/Kconfig
index 80373da..2d1232e 100644
--- a/arch/arm/mach-s3c24xx/Kconfig
+++ b/arch/arm/mach-s3c24xx/Kconfig
@@ -39,7 +39,6 @@ config CPU_S3C2410
 
 config CPU_S3C2412
 	bool "SAMSUNG S3C2412"
-	select COMMON_CLK
 	select CPU_ARM926T
 	select CPU_LLSERIAL_S3C2440
 	select S3C2412_COMMON_CLK
@@ -50,7 +49,6 @@ config CPU_S3C2412
 
 config CPU_S3C2416
 	bool "SAMSUNG S3C2416/S3C2450"
-	select COMMON_CLK
 	select CPU_ARM926T
 	select CPU_LLSERIAL_S3C2440
 	select S3C2416_PM if PM
@@ -88,7 +86,6 @@ config CPU_S3C244X
 
 config CPU_S3C2443
 	bool "SAMSUNG S3C2443"
-	select COMMON_CLK
 	select CPU_ARM920T
 	select CPU_LLSERIAL_S3C2440
 	select S3C2443_COMMON_CLK
@@ -364,11 +361,6 @@ config S3C2412_PM_SLEEP
 
 if CPU_S3C2412
 
-config S3C2412_COMMON_CLK
-	bool
-	help
-	  Build the s3c2412 clock driver based on the common clock framework.
-
 config CPU_S3C2412_ONLY
 	bool
 	depends on !CPU_S3C2410 && !CPU_S3C2416 && !CPU_S3C2440 && \
@@ -651,12 +643,6 @@ endif	# CPU_S3C2442
 
 if CPU_S3C2443 || CPU_S3C2416
 
-config S3C2443_COMMON_CLK
-	bool
-	help
-	  Temporary symbol to build the clock driver based on the common clock
-	  framework.
-
 config S3C2443_DMA
 	bool
 	help
diff --git a/drivers/clk/samsung/Kconfig b/drivers/clk/samsung/Kconfig
index fc8696b..baf28cb 100644
--- a/drivers/clk/samsung/Kconfig
+++ b/drivers/clk/samsung/Kconfig
@@ -1,3 +1,12 @@
 config COMMON_CLK_SAMSUNG
 	bool
 	select COMMON_CLK
+
+config S3C2412_COMMON_CLK
+	bool
+	select COMMON_CLK_SAMSUNG
+
+config S3C2443_COMMON_CLK
+	bool
+	select COMMON_CLK_SAMSUNG
+
-- 
1.7.10.4
