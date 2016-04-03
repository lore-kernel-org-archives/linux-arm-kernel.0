From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sun,  3 Apr 2016 23:39:21 +0900
Subject: [RFC PATCH 3/9] ARM: zynq: move mach-zynq/ to platforms/zynq/
In-Reply-To: <1459694367-18635-1-git-send-email-yamada.masahiro@socionext.com>
References: <1459694367-18635-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1459694367-18635-4-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/Kconfig                                 | 2 --
 arch/arm/Makefile                                | 1 -
 arch/arm/platforms/Kconfig                       | 1 +
 arch/arm/platforms/Makefile                      | 1 +
 arch/arm/{mach-zynq => platforms/zynq}/Kconfig   | 0
 arch/arm/{mach-zynq => platforms/zynq}/Makefile  | 0
 arch/arm/{mach-zynq => platforms/zynq}/common.c  | 0
 arch/arm/{mach-zynq => platforms/zynq}/common.h  | 0
 arch/arm/{mach-zynq => platforms/zynq}/headsmp.S | 0
 arch/arm/{mach-zynq => platforms/zynq}/platsmp.c | 0
 arch/arm/{mach-zynq => platforms/zynq}/pm.c      | 0
 arch/arm/{mach-zynq => platforms/zynq}/slcr.c    | 0
 12 files changed, 2 insertions(+), 3 deletions(-)
 rename arch/arm/{mach-zynq => platforms/zynq}/Kconfig (100%)
 rename arch/arm/{mach-zynq => platforms/zynq}/Makefile (100%)
 rename arch/arm/{mach-zynq => platforms/zynq}/common.c (100%)
 rename arch/arm/{mach-zynq => platforms/zynq}/common.h (100%)
 rename arch/arm/{mach-zynq => platforms/zynq}/headsmp.S (100%)
 rename arch/arm/{mach-zynq => platforms/zynq}/platsmp.c (100%)
 rename arch/arm/{mach-zynq => platforms/zynq}/pm.c (100%)
 rename arch/arm/{mach-zynq => platforms/zynq}/slcr.c (100%)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index f1cfb16..394c899 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -854,8 +854,6 @@ source "arch/arm/mach-w90x900/Kconfig"
 
 source "arch/arm/mach-zx/Kconfig"
 
-source "arch/arm/mach-zynq/Kconfig"
-
 # ARMv7-M architecture
 config ARCH_EFM32
 	bool "Energy Micro efm32"
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 16b3eff..884114e 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -220,7 +220,6 @@ machine-$(CONFIG_ARCH_VEXPRESS)		+= vexpress
 machine-$(CONFIG_ARCH_VT8500)		+= vt8500
 machine-$(CONFIG_ARCH_W90X900)		+= w90x900
 machine-$(CONFIG_ARCH_ZX)		+= zx
-machine-$(CONFIG_ARCH_ZYNQ)		+= zynq
 machine-$(CONFIG_PLAT_SPEAR)		+= spear
 
 # Platform directory name.  This list is sorted alphanumerically
diff --git a/arch/arm/platforms/Kconfig b/arch/arm/platforms/Kconfig
index 5bf796f..be9e2ee 100644
--- a/arch/arm/platforms/Kconfig
+++ b/arch/arm/platforms/Kconfig
@@ -1,3 +1,4 @@
 # This is sorted alphabetically by directory pathname.
 
 source "arch/arm/platforms/uniphier/Kconfig"
+source "arch/arm/platforms/zynq/Kconfig"
diff --git a/arch/arm/platforms/Makefile b/arch/arm/platforms/Makefile
index 99090e8..68b0127 100644
--- a/arch/arm/platforms/Makefile
+++ b/arch/arm/platforms/Makefile
@@ -1,3 +1,4 @@
 # This list sorted alphanumerically by CONFIG_* macro name.
 
 obj-$(CONFIG_ARCH_UNIPHIER)		+= uniphier/
+obj-$(CONFIG_ARCH_ZYNQ)			+= zynq/
diff --git a/arch/arm/mach-zynq/Kconfig b/arch/arm/platforms/zynq/Kconfig
similarity index 100%
rename from arch/arm/mach-zynq/Kconfig
rename to arch/arm/platforms/zynq/Kconfig
diff --git a/arch/arm/mach-zynq/Makefile b/arch/arm/platforms/zynq/Makefile
similarity index 100%
rename from arch/arm/mach-zynq/Makefile
rename to arch/arm/platforms/zynq/Makefile
diff --git a/arch/arm/mach-zynq/common.c b/arch/arm/platforms/zynq/common.c
similarity index 100%
rename from arch/arm/mach-zynq/common.c
rename to arch/arm/platforms/zynq/common.c
diff --git a/arch/arm/mach-zynq/common.h b/arch/arm/platforms/zynq/common.h
similarity index 100%
rename from arch/arm/mach-zynq/common.h
rename to arch/arm/platforms/zynq/common.h
diff --git a/arch/arm/mach-zynq/headsmp.S b/arch/arm/platforms/zynq/headsmp.S
similarity index 100%
rename from arch/arm/mach-zynq/headsmp.S
rename to arch/arm/platforms/zynq/headsmp.S
diff --git a/arch/arm/mach-zynq/platsmp.c b/arch/arm/platforms/zynq/platsmp.c
similarity index 100%
rename from arch/arm/mach-zynq/platsmp.c
rename to arch/arm/platforms/zynq/platsmp.c
diff --git a/arch/arm/mach-zynq/pm.c b/arch/arm/platforms/zynq/pm.c
similarity index 100%
rename from arch/arm/mach-zynq/pm.c
rename to arch/arm/platforms/zynq/pm.c
diff --git a/arch/arm/mach-zynq/slcr.c b/arch/arm/platforms/zynq/slcr.c
similarity index 100%
rename from arch/arm/mach-zynq/slcr.c
rename to arch/arm/platforms/zynq/slcr.c
-- 
1.9.1
