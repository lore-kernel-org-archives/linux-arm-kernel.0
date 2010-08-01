From: augulis.darius@gmail.com (Darius Augulis)
Date: Mon, 02 Aug 2010 01:39:25 +0300
Subject: [PATCH] s3c: mach-real6410: add sdhc device support
Message-ID: <20100801223901.27767.86550.stgit@darius-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is based on:
 * "[PATCH v2] Support for Real6410"
 * "[PATCH] s3c: add dm9000 ethernet support for mach-real6410"

Signed-off-by: Darius Augulis <augulis.darius@gmail.com>
---
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
index 1a0485a..5c07d01 100644
--- a/arch/arm/mach-s3c64xx/mach-real6410.c
+++ b/arch/arm/mach-s3c64xx/mach-real6410.c
@@ -27,6 +27,7 @@
 #include <mach/s3c6410.h>
 #include <mach/regs-srom.h>
 #include <plat/cpu.h>
+#include <plat/devs.h>
 #include <plat/regs-serial.h>
 
 #define UCON S3C2410_UCON_DEFAULT | S3C2410_UCON_UCLK
@@ -100,6 +101,8 @@ static struct platform_device real6410_device_eth = {
 
 static struct platform_device *real6410_devices[] __initdata = {
 	&real6410_device_eth,
+	&s3c_device_hsmmc0,
+	&s3c_device_hsmmc1,
 };
 
 static void __init real6410_map_io(void)
