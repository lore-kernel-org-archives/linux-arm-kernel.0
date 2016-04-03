From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sun,  3 Apr 2016 23:39:26 +0900
Subject: [RFC PATCH 8/9] ARM: highbank: move mach-highbank/ to
 platforms/highbank/
In-Reply-To: <1459694367-18635-1-git-send-email-yamada.masahiro@socionext.com>
References: <1459694367-18635-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1459694367-18635-9-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/Kconfig                                          | 2 --
 arch/arm/Makefile                                         | 1 -
 arch/arm/platforms/Kconfig                                | 1 +
 arch/arm/platforms/Makefile                               | 1 +
 arch/arm/{mach-highbank => platforms/highbank}/Kconfig    | 0
 arch/arm/{mach-highbank => platforms/highbank}/Makefile   | 0
 arch/arm/{mach-highbank => platforms/highbank}/core.h     | 0
 arch/arm/{mach-highbank => platforms/highbank}/highbank.c | 0
 arch/arm/{mach-highbank => platforms/highbank}/pm.c       | 0
 arch/arm/{mach-highbank => platforms/highbank}/smc.S      | 0
 arch/arm/{mach-highbank => platforms/highbank}/sysregs.h  | 0
 arch/arm/{mach-highbank => platforms/highbank}/system.c   | 0
 12 files changed, 2 insertions(+), 3 deletions(-)
 rename arch/arm/{mach-highbank => platforms/highbank}/Kconfig (100%)
 rename arch/arm/{mach-highbank => platforms/highbank}/Makefile (100%)
 rename arch/arm/{mach-highbank => platforms/highbank}/core.h (100%)
 rename arch/arm/{mach-highbank => platforms/highbank}/highbank.c (100%)
 rename arch/arm/{mach-highbank => platforms/highbank}/pm.c (100%)
 rename arch/arm/{mach-highbank => platforms/highbank}/smc.S (100%)
 rename arch/arm/{mach-highbank => platforms/highbank}/sysregs.h (100%)
 rename arch/arm/{mach-highbank => platforms/highbank}/system.c (100%)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 38d9cb7..443b125 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -755,8 +755,6 @@ source "arch/arm/mach-footbridge/Kconfig"
 
 source "arch/arm/mach-gemini/Kconfig"
 
-source "arch/arm/mach-highbank/Kconfig"
-
 source "arch/arm/mach-hisi/Kconfig"
 
 source "arch/arm/mach-integrator/Kconfig"
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 17ccd3f..33d031f 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -170,7 +170,6 @@ machine-$(CONFIG_ARCH_EP93XX)		+= ep93xx
 machine-$(CONFIG_ARCH_EXYNOS)		+= exynos
 machine-$(CONFIG_ARCH_FOOTBRIDGE)	+= footbridge
 machine-$(CONFIG_ARCH_GEMINI)		+= gemini
-machine-$(CONFIG_ARCH_HIGHBANK)		+= highbank
 machine-$(CONFIG_ARCH_HISI)		+= hisi
 machine-$(CONFIG_ARCH_INTEGRATOR)	+= integrator
 machine-$(CONFIG_ARCH_IOP13XX)		+= iop13xx
diff --git a/arch/arm/platforms/Kconfig b/arch/arm/platforms/Kconfig
index 069b6a2..8b3b93a 100644
--- a/arch/arm/platforms/Kconfig
+++ b/arch/arm/platforms/Kconfig
@@ -1,5 +1,6 @@
 # This is sorted alphabetically by directory pathname.
 
+source "arch/arm/platforms/highbank/Kconfig"
 source "arch/arm/platforms/mediatek/Kconfig"
 source "arch/arm/platforms/rockchip/Kconfig"
 source "arch/arm/platforms/socfpga/Kconfig"
diff --git a/arch/arm/platforms/Makefile b/arch/arm/platforms/Makefile
index 3b0a4e7..2bb3622 100644
--- a/arch/arm/platforms/Makefile
+++ b/arch/arm/platforms/Makefile
@@ -1,5 +1,6 @@
 # This list sorted alphanumerically by CONFIG_* macro name.
 
+obj-$(CONFIG_ARCH_HIGHBANK)		+= highbank/
 obj-$(CONFIG_ARCH_MEDIATEK)		+= mediatek/
 obj-$(CONFIG_ARCH_ROCKCHIP)		+= rockchip/
 obj-$(CONFIG_ARCH_SOCFPGA)		+= socfpga/
diff --git a/arch/arm/mach-highbank/Kconfig b/arch/arm/platforms/highbank/Kconfig
similarity index 100%
rename from arch/arm/mach-highbank/Kconfig
rename to arch/arm/platforms/highbank/Kconfig
diff --git a/arch/arm/mach-highbank/Makefile b/arch/arm/platforms/highbank/Makefile
similarity index 100%
rename from arch/arm/mach-highbank/Makefile
rename to arch/arm/platforms/highbank/Makefile
diff --git a/arch/arm/mach-highbank/core.h b/arch/arm/platforms/highbank/core.h
similarity index 100%
rename from arch/arm/mach-highbank/core.h
rename to arch/arm/platforms/highbank/core.h
diff --git a/arch/arm/mach-highbank/highbank.c b/arch/arm/platforms/highbank/highbank.c
similarity index 100%
rename from arch/arm/mach-highbank/highbank.c
rename to arch/arm/platforms/highbank/highbank.c
diff --git a/arch/arm/mach-highbank/pm.c b/arch/arm/platforms/highbank/pm.c
similarity index 100%
rename from arch/arm/mach-highbank/pm.c
rename to arch/arm/platforms/highbank/pm.c
diff --git a/arch/arm/mach-highbank/smc.S b/arch/arm/platforms/highbank/smc.S
similarity index 100%
rename from arch/arm/mach-highbank/smc.S
rename to arch/arm/platforms/highbank/smc.S
diff --git a/arch/arm/mach-highbank/sysregs.h b/arch/arm/platforms/highbank/sysregs.h
similarity index 100%
rename from arch/arm/mach-highbank/sysregs.h
rename to arch/arm/platforms/highbank/sysregs.h
diff --git a/arch/arm/mach-highbank/system.c b/arch/arm/platforms/highbank/system.c
similarity index 100%
rename from arch/arm/mach-highbank/system.c
rename to arch/arm/platforms/highbank/system.c
-- 
1.9.1
