From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sun,  3 Apr 2016 23:39:23 +0900
Subject: [RFC PATCH 5/9] ARM: socfpga: move mach-socfpga/ to platforms/socfpga/
In-Reply-To: <1459694367-18635-1-git-send-email-yamada.masahiro@socionext.com>
References: <1459694367-18635-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1459694367-18635-6-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/Kconfig                                            | 2 --
 arch/arm/Makefile                                           | 1 -
 arch/arm/platforms/Kconfig                                  | 1 +
 arch/arm/platforms/Makefile                                 | 1 +
 arch/arm/{mach-socfpga => platforms/socfpga}/Kconfig        | 0
 arch/arm/{mach-socfpga => platforms/socfpga}/Makefile       | 0
 arch/arm/{mach-socfpga => platforms/socfpga}/core.h         | 0
 arch/arm/{mach-socfpga => platforms/socfpga}/headsmp.S      | 0
 arch/arm/{mach-socfpga => platforms/socfpga}/l2_cache.c     | 0
 arch/arm/{mach-socfpga => platforms/socfpga}/ocram.c        | 0
 arch/arm/{mach-socfpga => platforms/socfpga}/platsmp.c      | 0
 arch/arm/{mach-socfpga => platforms/socfpga}/pm.c           | 0
 arch/arm/{mach-socfpga => platforms/socfpga}/self-refresh.S | 0
 arch/arm/{mach-socfpga => platforms/socfpga}/socfpga.c      | 0
 14 files changed, 2 insertions(+), 3 deletions(-)
 rename arch/arm/{mach-socfpga => platforms/socfpga}/Kconfig (100%)
 rename arch/arm/{mach-socfpga => platforms/socfpga}/Makefile (100%)
 rename arch/arm/{mach-socfpga => platforms/socfpga}/core.h (100%)
 rename arch/arm/{mach-socfpga => platforms/socfpga}/headsmp.S (100%)
 rename arch/arm/{mach-socfpga => platforms/socfpga}/l2_cache.c (100%)
 rename arch/arm/{mach-socfpga => platforms/socfpga}/ocram.c (100%)
 rename arch/arm/{mach-socfpga => platforms/socfpga}/platsmp.c (100%)
 rename arch/arm/{mach-socfpga => platforms/socfpga}/pm.c (100%)
 rename arch/arm/{mach-socfpga => platforms/socfpga}/self-refresh.S (100%)
 rename arch/arm/{mach-socfpga => platforms/socfpga}/socfpga.c (100%)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index edbbd82..ce9ba91 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -814,8 +814,6 @@ source "arch/arm/mach-rockchip/Kconfig"
 
 source "arch/arm/mach-sa1100/Kconfig"
 
-source "arch/arm/mach-socfpga/Kconfig"
-
 source "arch/arm/mach-spear/Kconfig"
 
 source "arch/arm/mach-sti/Kconfig"
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index d653b1b..9850f92 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -207,7 +207,6 @@ machine-$(CONFIG_ARCH_S5PV210)		+= s5pv210
 machine-$(CONFIG_ARCH_SA1100)		+= sa1100
 machine-$(CONFIG_ARCH_SHMOBILE) 	+= shmobile
 machine-$(CONFIG_ARCH_SIRF)		+= prima2
-machine-$(CONFIG_ARCH_SOCFPGA)		+= socfpga
 machine-$(CONFIG_ARCH_STI)		+= sti
 machine-$(CONFIG_ARCH_STM32)		+= stm32
 machine-$(CONFIG_ARCH_TANGO)		+= tango
diff --git a/arch/arm/platforms/Kconfig b/arch/arm/platforms/Kconfig
index 2614c78..18a1e85 100644
--- a/arch/arm/platforms/Kconfig
+++ b/arch/arm/platforms/Kconfig
@@ -1,5 +1,6 @@
 # This is sorted alphabetically by directory pathname.
 
+source "arch/arm/platforms/socfpga/Kconfig"
 source "arch/arm/platforms/sunxi/Kconfig"
 source "arch/arm/platforms/uniphier/Kconfig"
 source "arch/arm/platforms/zynq/Kconfig"
diff --git a/arch/arm/platforms/Makefile b/arch/arm/platforms/Makefile
index 00fd18e..e37786d 100644
--- a/arch/arm/platforms/Makefile
+++ b/arch/arm/platforms/Makefile
@@ -1,5 +1,6 @@
 # This list sorted alphanumerically by CONFIG_* macro name.
 
+obj-$(CONFIG_ARCH_SOCFPGA)		+= socfpga/
 obj-$(CONFIG_ARCH_SUNXI)		+= sunxi/
 obj-$(CONFIG_ARCH_UNIPHIER)		+= uniphier/
 obj-$(CONFIG_ARCH_ZYNQ)			+= zynq/
diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/platforms/socfpga/Kconfig
similarity index 100%
rename from arch/arm/mach-socfpga/Kconfig
rename to arch/arm/platforms/socfpga/Kconfig
diff --git a/arch/arm/mach-socfpga/Makefile b/arch/arm/platforms/socfpga/Makefile
similarity index 100%
rename from arch/arm/mach-socfpga/Makefile
rename to arch/arm/platforms/socfpga/Makefile
diff --git a/arch/arm/mach-socfpga/core.h b/arch/arm/platforms/socfpga/core.h
similarity index 100%
rename from arch/arm/mach-socfpga/core.h
rename to arch/arm/platforms/socfpga/core.h
diff --git a/arch/arm/mach-socfpga/headsmp.S b/arch/arm/platforms/socfpga/headsmp.S
similarity index 100%
rename from arch/arm/mach-socfpga/headsmp.S
rename to arch/arm/platforms/socfpga/headsmp.S
diff --git a/arch/arm/mach-socfpga/l2_cache.c b/arch/arm/platforms/socfpga/l2_cache.c
similarity index 100%
rename from arch/arm/mach-socfpga/l2_cache.c
rename to arch/arm/platforms/socfpga/l2_cache.c
diff --git a/arch/arm/mach-socfpga/ocram.c b/arch/arm/platforms/socfpga/ocram.c
similarity index 100%
rename from arch/arm/mach-socfpga/ocram.c
rename to arch/arm/platforms/socfpga/ocram.c
diff --git a/arch/arm/mach-socfpga/platsmp.c b/arch/arm/platforms/socfpga/platsmp.c
similarity index 100%
rename from arch/arm/mach-socfpga/platsmp.c
rename to arch/arm/platforms/socfpga/platsmp.c
diff --git a/arch/arm/mach-socfpga/pm.c b/arch/arm/platforms/socfpga/pm.c
similarity index 100%
rename from arch/arm/mach-socfpga/pm.c
rename to arch/arm/platforms/socfpga/pm.c
diff --git a/arch/arm/mach-socfpga/self-refresh.S b/arch/arm/platforms/socfpga/self-refresh.S
similarity index 100%
rename from arch/arm/mach-socfpga/self-refresh.S
rename to arch/arm/platforms/socfpga/self-refresh.S
diff --git a/arch/arm/mach-socfpga/socfpga.c b/arch/arm/platforms/socfpga/socfpga.c
similarity index 100%
rename from arch/arm/mach-socfpga/socfpga.c
rename to arch/arm/platforms/socfpga/socfpga.c
-- 
1.9.1
