From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 21 Mar 2014 17:13:41 +0100
Subject: [PATCH 47/62] ARM: s3c64xx: MACH_SMDK6400 needs HSMMC1
In-Reply-To: <01ee01cf43f0$3b436bc0$b1ca4340$@samsung.com>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
 <1395257399-359545-48-git-send-email-arnd@arndb.de>
 <01ee01cf43f0$3b436bc0$b1ca4340$@samsung.com>
Message-ID: <201403211713.41901.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 20 March 2014, Kukjin Kim wrote:
> 
> Well, only HSMMC ch1 is used on smdk6400 and S3C_DEV_NAND is not needed.

Ok, changed it now as you suggested:

>From 9ec2109585b54ed8ff507e4b29c8fee7af14c70d Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 26 Feb 2014 21:31:18 +0100
Subject: [PATCH] ARM: s3c64xx: MACH_SMDK6400 needs HSMMC1

This board uses both MMC controllers, so we need to enable
the Kconfig option to define the platform data.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Ben Dooks <ben-linux@fluff.org>

diff --git a/arch/arm/mach-s3c64xx/Kconfig b/arch/arm/mach-s3c64xx/Kconfig
index 64f04e6..3136d86 100644
--- a/arch/arm/mach-s3c64xx/Kconfig
+++ b/arch/arm/mach-s3c64xx/Kconfig
@@ -86,8 +86,7 @@ config MACH_SMDK6400
        bool "SMDK6400"
 	select CPU_S3C6400
 	select S3C64XX_SETUP_SDHCI
-	select S3C_DEV_HSMMC
-	select S3C_DEV_NAND
+	select S3C_DEV_HSMMC1
 	help
 	  Machine support for the Samsung SMDK6400
 
