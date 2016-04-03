From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sun,  3 Apr 2016 23:39:20 +0900
Subject: [RFC PATCH 2/9] ARM: uniphier: move mach-uniphier/ to
 platforms/uniphier/
In-Reply-To: <1459694367-18635-1-git-send-email-yamada.masahiro@socionext.com>
References: <1459694367-18635-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1459694367-18635-3-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/Kconfig                                          | 2 --
 arch/arm/Makefile                                         | 1 -
 arch/arm/platforms/Kconfig                                | 2 ++
 arch/arm/platforms/Makefile                               | 2 +-
 arch/arm/{mach-uniphier => platforms/uniphier}/Kconfig    | 0
 arch/arm/{mach-uniphier => platforms/uniphier}/Makefile   | 0
 arch/arm/{mach-uniphier => platforms/uniphier}/headsmp.S  | 0
 arch/arm/{mach-uniphier => platforms/uniphier}/platsmp.c  | 0
 arch/arm/{mach-uniphier => platforms/uniphier}/uniphier.c | 0
 9 files changed, 3 insertions(+), 4 deletions(-)
 rename arch/arm/{mach-uniphier => platforms/uniphier}/Kconfig (100%)
 rename arch/arm/{mach-uniphier => platforms/uniphier}/Makefile (100%)
 rename arch/arm/{mach-uniphier => platforms/uniphier}/headsmp.S (100%)
 rename arch/arm/{mach-uniphier => platforms/uniphier}/platsmp.c (100%)
 rename arch/arm/{mach-uniphier => platforms/uniphier}/uniphier.c (100%)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 91e62d4..f1cfb16 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -841,8 +841,6 @@ source "arch/arm/mach-tegra/Kconfig"
 
 source "arch/arm/mach-u300/Kconfig"
 
-source "arch/arm/mach-uniphier/Kconfig"
-
 source "arch/arm/mach-ux500/Kconfig"
 
 source "arch/arm/mach-versatile/Kconfig"
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 9052487..16b3eff 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -215,7 +215,6 @@ machine-$(CONFIG_ARCH_TANGO)		+= tango
 machine-$(CONFIG_ARCH_TEGRA)		+= tegra
 machine-$(CONFIG_ARCH_U300)		+= u300
 machine-$(CONFIG_ARCH_U8500)		+= ux500
-machine-$(CONFIG_ARCH_UNIPHIER)		+= uniphier
 machine-$(CONFIG_ARCH_VERSATILE)	+= versatile
 machine-$(CONFIG_ARCH_VEXPRESS)		+= vexpress
 machine-$(CONFIG_ARCH_VT8500)		+= vt8500
diff --git a/arch/arm/platforms/Kconfig b/arch/arm/platforms/Kconfig
index db3d104..5bf796f 100644
--- a/arch/arm/platforms/Kconfig
+++ b/arch/arm/platforms/Kconfig
@@ -1 +1,3 @@
 # This is sorted alphabetically by directory pathname.
+
+source "arch/arm/platforms/uniphier/Kconfig"
diff --git a/arch/arm/platforms/Makefile b/arch/arm/platforms/Makefile
index 5b2bd85..99090e8 100644
--- a/arch/arm/platforms/Makefile
+++ b/arch/arm/platforms/Makefile
@@ -1,3 +1,3 @@
 # This list sorted alphanumerically by CONFIG_* macro name.
 
-obj- += dummy.o
+obj-$(CONFIG_ARCH_UNIPHIER)		+= uniphier/
diff --git a/arch/arm/mach-uniphier/Kconfig b/arch/arm/platforms/uniphier/Kconfig
similarity index 100%
rename from arch/arm/mach-uniphier/Kconfig
rename to arch/arm/platforms/uniphier/Kconfig
diff --git a/arch/arm/mach-uniphier/Makefile b/arch/arm/platforms/uniphier/Makefile
similarity index 100%
rename from arch/arm/mach-uniphier/Makefile
rename to arch/arm/platforms/uniphier/Makefile
diff --git a/arch/arm/mach-uniphier/headsmp.S b/arch/arm/platforms/uniphier/headsmp.S
similarity index 100%
rename from arch/arm/mach-uniphier/headsmp.S
rename to arch/arm/platforms/uniphier/headsmp.S
diff --git a/arch/arm/mach-uniphier/platsmp.c b/arch/arm/platforms/uniphier/platsmp.c
similarity index 100%
rename from arch/arm/mach-uniphier/platsmp.c
rename to arch/arm/platforms/uniphier/platsmp.c
diff --git a/arch/arm/mach-uniphier/uniphier.c b/arch/arm/platforms/uniphier/uniphier.c
similarity index 100%
rename from arch/arm/mach-uniphier/uniphier.c
rename to arch/arm/platforms/uniphier/uniphier.c
-- 
1.9.1
