From: Jiri.Pinkava@vscht.cz (Pinkava J.)
Date: Thu, 6 May 2010 00:06:54 +0200
Subject: [PATCH 1/9] Enable Acer n35 architecture if Acer n30 is selected
Message-ID: <4BE1EBFE.9080601@vscht.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All code already present for Acer n35 is useless unless MACH_N35 is defined.

Signed-off-by: Jiri Pinkava <jiri.pinkava@vscht.cz>
---
 arch/arm/mach-s3c2410/Kconfig |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c2410/Kconfig b/arch/arm/mach-s3c2410/Kconfig
index 5547318..2b5a33f 100644
--- a/arch/arm/mach-s3c2410/Kconfig
+++ b/arch/arm/mach-s3c2410/Kconfig
@@ -95,12 +95,19 @@ config PM_H1940
 config MACH_N30
 	bool "Acer N30 family"
 	select CPU_S3C2410
+	select MACH_N35
 	select S3C_DEV_USB_HOST
 	select S3C_DEV_NAND
 	help
 	  Say Y here if you want suppt for the Acer N30, Acer N35,
 	  Navman PiN570, Yakumo AlphaX or Airis NC05 PDAs.

+config MACH_N35
+	bool
+	help
+	  Internal node in order to enable support for Acer N35 if Acer N30 is
+	  selected.
+
 config ARCH_BAST
 	bool "Simtec Electronics BAST (EB2410ITX)"
 	select CPU_S3C2410
-- 
1.7.1
