From: jekhor@gmail.com (Yauhen Kharuzhy)
Date: Sun, 28 Nov 2010 20:30:19 +0200
Subject: [PATCH 01/10] SMDK2416: Select MACH_SMDK, S3C_DEV_NAND,
	S3C_DEV_USB_HOST
Message-ID: <1290969027-10178-1-git-send-email-jekhor@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable compilation of platform devices and initialization code used in
SMDK2416 board file.

Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
---
 arch/arm/mach-s3c2416/Kconfig |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c2416/Kconfig b/arch/arm/mach-s3c2416/Kconfig
index 87b9c9f..27b3e7c 100644
--- a/arch/arm/mach-s3c2416/Kconfig
+++ b/arch/arm/mach-s3c2416/Kconfig
@@ -35,9 +35,12 @@ menu "S3C2416 Machines"
 config MACH_SMDK2416
 	bool "SMDK2416"
 	select CPU_S3C2416
+	select MACH_SMDK
 	select S3C_DEV_FB
 	select S3C_DEV_HSMMC
 	select S3C_DEV_HSMMC1
+	select S3C_DEV_NAND
+	select S3C_DEV_USB_HOST
 	select S3C2416_PM if PM
 	help
 	  Say Y here if you are using an SMDK2416
-- 
1.7.2.3
