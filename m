From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 25 Jan 2016 20:41:29 +0900
Subject: [PATCH] ARM: s3c64xx: use "depends on" instead of "if" after prompt
Message-ID: <1453722089-23101-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This platform recently moved to multi-platform, so missed the global
fixup by commit e32465429490 ("ARM: use "depends on" for SoC configs
instead of "if" after prompt").  Fix it now.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/mach-s3c64xx/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-s3c64xx/Kconfig b/arch/arm/mach-s3c64xx/Kconfig
index 7c0c420..e5c1888 100644
--- a/arch/arm/mach-s3c64xx/Kconfig
+++ b/arch/arm/mach-s3c64xx/Kconfig
@@ -3,7 +3,8 @@
 #
 # Licensed under GPLv2
 menuconfig ARCH_S3C64XX
-	bool "Samsung S3C64XX" if ARCH_MULTI_V6
+	bool "Samsung S3C64XX"
+	depends on ARCH_MULTI_V6
 	select ARCH_REQUIRE_GPIOLIB
 	select ARM_AMBA
 	select ARM_VIC
-- 
1.9.1
