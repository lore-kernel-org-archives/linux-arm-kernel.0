From: shc_work@mail.ru (Alexander Shiyan)
Date: Thu,  1 Nov 2012 13:26:36 +0400
Subject: [PATCH 06/15] ARM: clps711x: Always select AUTO_ZRELADDR for a
 platform
In-Reply-To: <1351762006-27368-1-git-send-email-shc_work@mail.ru>
References: <1351762006-27368-1-git-send-email-shc_work@mail.ru>
Message-ID: <1351762006-27368-6-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/Kconfig                     |    1 +
 arch/arm/mach-clps711x/Makefile.boot |    1 -
 2 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 9f04ca6..95103a1 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -370,6 +370,7 @@ config ARCH_CNS3XXX
 config ARCH_CLPS711X
 	bool "Cirrus Logic CLPS711x/EP721x/EP731x-based"
 	select ARCH_REQUIRE_GPIOLIB
+	select AUTO_ZRELADDR
 	select CLKDEV_LOOKUP
 	select COMMON_CLK
 	select CPU_ARM720T
diff --git a/arch/arm/mach-clps711x/Makefile.boot b/arch/arm/mach-clps711x/Makefile.boot
index 9398e85..eba77d3 100644
--- a/arch/arm/mach-clps711x/Makefile.boot
+++ b/arch/arm/mach-clps711x/Makefile.boot
@@ -1,5 +1,4 @@
 # The standard locations for stuff on CLPS711x type processors
-   zreladdr-y				+= 0xc0028000
 params_phys-y				:= 0xc0000100
 # Should probably have some agreement on these...
 initrd_phys-$(CONFIG_ARCH_P720T)	:= 0xc0400000
-- 
1.7.8.6
