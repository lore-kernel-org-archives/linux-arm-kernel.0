From: shc_work@mail.ru (Alexander Shiyan)
Date: Wed,  6 Feb 2013 22:10:28 +0400
Subject: [PATCH] ARM: smdk2410: Fix compile breakage
Message-ID: <1360174228-29950-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Symbol S3C_DEV_USB_HOST should be defined to avoid this problem.
  LINK    vmlinux
  LD      vmlinux.o
  MODPOST vmlinux.o
WARNING: modpost: Found 2 section mismatch(es).
To see full details build your kernel with:
'make CONFIG_DEBUG_SECTION_MISMATCH=y'
  GEN     .version
  CHK     include/generated/compile.h
  UPD     include/generated/compile.h
  CC      init/version.o
  LD      init/built-in.o
arch/arm/mach-s3c24xx/built-in.o:(.init.data+0x660): undefined reference to `s3c_device_ohci'
make: *** [vmlinux] Error 1

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-s3c24xx/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-s3c24xx/Kconfig b/arch/arm/mach-s3c24xx/Kconfig
index ba6c501..8080dc1 100644
--- a/arch/arm/mach-s3c24xx/Kconfig
+++ b/arch/arm/mach-s3c24xx/Kconfig
@@ -350,6 +350,7 @@ config MACH_QT2410
 config ARCH_SMDK2410
 	bool "SMDK2410/A9M2410"
 	select S3C24XX_SMDK
+	select S3C_DEV_USB_HOST
 	help
 	  Say Y here if you are using the SMDK2410 or the derived module A9M2410
 	  <http://www.fsforth.de>
-- 
1.7.12.4
