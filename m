From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sun,  3 Apr 2016 23:39:22 +0900
Subject: [RFC PATCH 4/9] ARM: sunxi: move mach-sunxi/ to platforms/sunxi/
In-Reply-To: <1459694367-18635-1-git-send-email-yamada.masahiro@socionext.com>
References: <1459694367-18635-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1459694367-18635-5-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/Kconfig                                   | 2 --
 arch/arm/Makefile                                  | 1 -
 arch/arm/platforms/Kconfig                         | 1 +
 arch/arm/platforms/Makefile                        | 1 +
 arch/arm/{mach-sunxi => platforms/sunxi}/Kconfig   | 0
 arch/arm/{mach-sunxi => platforms/sunxi}/Makefile  | 0
 arch/arm/{mach-sunxi => platforms/sunxi}/platsmp.c | 0
 arch/arm/{mach-sunxi => platforms/sunxi}/sunxi.c   | 0
 8 files changed, 2 insertions(+), 3 deletions(-)
 rename arch/arm/{mach-sunxi => platforms/sunxi}/Kconfig (100%)
 rename arch/arm/{mach-sunxi => platforms/sunxi}/Makefile (100%)
 rename arch/arm/{mach-sunxi => platforms/sunxi}/platsmp.c (100%)
 rename arch/arm/{mach-sunxi => platforms/sunxi}/sunxi.c (100%)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 394c899..edbbd82 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -831,8 +831,6 @@ source "arch/arm/plat-samsung/Kconfig"
 
 source "arch/arm/mach-shmobile/Kconfig"
 
-source "arch/arm/mach-sunxi/Kconfig"
-
 source "arch/arm/mach-prima2/Kconfig"
 
 source "arch/arm/mach-tango/Kconfig"
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 884114e..d653b1b 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -210,7 +210,6 @@ machine-$(CONFIG_ARCH_SIRF)		+= prima2
 machine-$(CONFIG_ARCH_SOCFPGA)		+= socfpga
 machine-$(CONFIG_ARCH_STI)		+= sti
 machine-$(CONFIG_ARCH_STM32)		+= stm32
-machine-$(CONFIG_ARCH_SUNXI)		+= sunxi
 machine-$(CONFIG_ARCH_TANGO)		+= tango
 machine-$(CONFIG_ARCH_TEGRA)		+= tegra
 machine-$(CONFIG_ARCH_U300)		+= u300
diff --git a/arch/arm/platforms/Kconfig b/arch/arm/platforms/Kconfig
index be9e2ee..2614c78 100644
--- a/arch/arm/platforms/Kconfig
+++ b/arch/arm/platforms/Kconfig
@@ -1,4 +1,5 @@
 # This is sorted alphabetically by directory pathname.
 
+source "arch/arm/platforms/sunxi/Kconfig"
 source "arch/arm/platforms/uniphier/Kconfig"
 source "arch/arm/platforms/zynq/Kconfig"
diff --git a/arch/arm/platforms/Makefile b/arch/arm/platforms/Makefile
index 68b0127..00fd18e 100644
--- a/arch/arm/platforms/Makefile
+++ b/arch/arm/platforms/Makefile
@@ -1,4 +1,5 @@
 # This list sorted alphanumerically by CONFIG_* macro name.
 
+obj-$(CONFIG_ARCH_SUNXI)		+= sunxi/
 obj-$(CONFIG_ARCH_UNIPHIER)		+= uniphier/
 obj-$(CONFIG_ARCH_ZYNQ)			+= zynq/
diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/platforms/sunxi/Kconfig
similarity index 100%
rename from arch/arm/mach-sunxi/Kconfig
rename to arch/arm/platforms/sunxi/Kconfig
diff --git a/arch/arm/mach-sunxi/Makefile b/arch/arm/platforms/sunxi/Makefile
similarity index 100%
rename from arch/arm/mach-sunxi/Makefile
rename to arch/arm/platforms/sunxi/Makefile
diff --git a/arch/arm/mach-sunxi/platsmp.c b/arch/arm/platforms/sunxi/platsmp.c
similarity index 100%
rename from arch/arm/mach-sunxi/platsmp.c
rename to arch/arm/platforms/sunxi/platsmp.c
diff --git a/arch/arm/mach-sunxi/sunxi.c b/arch/arm/platforms/sunxi/sunxi.c
similarity index 100%
rename from arch/arm/mach-sunxi/sunxi.c
rename to arch/arm/platforms/sunxi/sunxi.c
-- 
1.9.1
