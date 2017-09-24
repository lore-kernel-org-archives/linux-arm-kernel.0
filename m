From: elscha@freenet.de (Elscha)
Date: Sun, 24 Sep 2017 17:58:48 +0200
Subject: [Patch] ARM/Mediatek SoC: Remove useless dependency from UX500_SOC_ID
 to COMPILE_TEST
Message-ID: <59C7D638.9070702@freenet.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove useless dependency from UX500_SOC_ID to COMPILE_TEST

* This dependency is ignored by the Kbuild scripts (more precisely in
   drivers/soc/Makefile, line 25). Thus, enabling COMPILE_TEST if ARCH_U8500
   is disabled has no effect.
* Further, this code file depends on an ARM specific header (e.g. cputype.h
   in line 18 is specific to the ARM and Unicore32 architectures). Thus,
   compiling this file on other architectures than ARM will result in
   compilation errors.

Signed-off-by:  Sascha El-Sharkawy<elscha@freenet.de>
---
  drivers/soc/ux500/Kconfig |    2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/ux500/Kconfig b/drivers/soc/ux500/Kconfig
index 025a44a..49ed883 100644
--- a/drivers/soc/ux500/Kconfig
+++ b/drivers/soc/ux500/Kconfig
@@ -1,6 +1,6 @@
  config UX500_SOC_ID
  	bool "SoC bus for ST-Ericsson ux500"
-	depends on ARCH_U8500 || COMPILE_TEST
+	depends on ARCH_U8500
  	default ARCH_U8500
  	help
  	  Include support for the SoC bus on the ARM RealView platforms
