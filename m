From: augulis.darius@gmail.com (Darius Augulis)
Date: Fri, 06 Aug 2010 20:22:51 +0300
Subject: [PATCH v2 3/4] s3c: mach-real6410: add sdhc device support
In-Reply-To: <20100806172033.7695.62041.stgit@darius-desktop>
References: <20100806172033.7695.62041.stgit@darius-desktop>
Message-ID: <20100806172235.7695.74735.stgit@darius-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for hsmmc0 and hsmmc1 devices support to mach-real6410

Signed-off-by: Darius Augulis <augulis.darius@gmail.com>
---

Changelog since v1:
 - Fixed errors reported by checkpatch.pl
 - Spaces in indentation replaced by TABs

 arch/arm/mach-s3c64xx/Kconfig         |    3 +++
 arch/arm/mach-s3c64xx/mach-real6410.c |    3 +++
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/Kconfig b/arch/arm/mach-s3c64xx/Kconfig
index 0f9f2dd..f5c77e5 100644
--- a/arch/arm/mach-s3c64xx/Kconfig
+++ b/arch/arm/mach-s3c64xx/Kconfig
@@ -91,6 +91,9 @@ config MACH_ANW6410
 config MACH_REAL6410
 	bool "REAL6410"
 	select CPU_S3C6410
+	select S3C_DEV_HSMMC
+	select S3C_DEV_HSMMC1
+	select S3C64XX_SETUP_SDHCI
 	help
 	  Machine support for the CoreWind REAL6410
 
diff --git a/arch/arm/mach-s3c64xx/mach-real6410.c b/arch/arm/mach-s3c64xx/mach-real6410.c
index d4d2190..bd52605 100644
--- a/arch/arm/mach-s3c64xx/mach-real6410.c
+++ b/arch/arm/mach-s3c64xx/mach-real6410.c
@@ -27,6 +27,7 @@
 #include <mach/s3c6410.h>
 #include <mach/regs-srom.h>
 #include <plat/cpu.h>
+#include <plat/devs.h>
 #include <plat/regs-serial.h>
 
 #define UCON (S3C2410_UCON_DEFAULT | S3C2410_UCON_UCLK)
@@ -100,6 +101,8 @@ static struct platform_device real6410_device_eth = {
 
 static struct platform_device *real6410_devices[] __initdata = {
 	&real6410_device_eth,
+	&s3c_device_hsmmc0,
+	&s3c_device_hsmmc1,
 };
 
 static void __init real6410_map_io(void)
