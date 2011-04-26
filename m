From: axel.lin@gmail.com (Axel Lin)
Date: Tue, 26 Apr 2011 23:58:33 +0800
Subject: [PATCH] ARM: ARCH_SMDK2410: add select S3C_DEV_USB_HOST to fix
	build error
Message-ID: <1303833513.24142.3.camel@phoenix>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add select S3C_DEV_USB_HOST for ARCH_SMDK2410 to fix below build error.

  LD      .tmp_vmlinux1
arch/arm/mach-s3c2410/built-in.o:(.init.data+0x30): undefined reference to `s3c_device_ohci'
make: *** [.tmp_vmlinux1] Error 1

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 arch/arm/mach-s3c2410/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c2410/Kconfig b/arch/arm/mach-s3c2410/Kconfig
index 7245a55..81b45e6 100644
--- a/arch/arm/mach-s3c2410/Kconfig
+++ b/arch/arm/mach-s3c2410/Kconfig
@@ -66,6 +66,7 @@ menu "S3C2410 Machines"
 config ARCH_SMDK2410
 	bool "SMDK2410/A9M2410"
 	select CPU_S3C2410
+	select S3C_DEV_USB_HOST
 	select MACH_SMDK
 	help
 	   Say Y here if you are using the SMDK2410 or the derived module A9M2410
-- 
1.7.1
