From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 25 Jan 2013 23:35:48 +0000
Subject: [PATCH 05/13] ARM: spear: merge Kconfig files
In-Reply-To: <1359156956-32404-1-git-send-email-arnd@arndb.de>
References: <1359156956-32404-1-git-send-email-arnd@arndb.de>
Message-ID: <1359156956-32404-6-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As a preparation to merging the spear platforms into one directory, this
merges the four Kconfig files into one.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-spear13xx/Kconfig | 20 ----------------
 arch/arm/mach-spear3xx/Kconfig  | 26 ---------------------
 arch/arm/mach-spear6xx/Kconfig  | 10 --------
 arch/arm/plat-spear/Kconfig     | 51 +++++++++++++++++++++++++++++++++++++----
 4 files changed, 47 insertions(+), 60 deletions(-)
 delete mode 100644 arch/arm/mach-spear13xx/Kconfig
 delete mode 100644 arch/arm/mach-spear3xx/Kconfig
 delete mode 100644 arch/arm/mach-spear6xx/Kconfig

diff --git a/arch/arm/mach-spear13xx/Kconfig b/arch/arm/mach-spear13xx/Kconfig
deleted file mode 100644
index eaadc66..0000000
--- a/arch/arm/mach-spear13xx/Kconfig
+++ /dev/null
@@ -1,20 +0,0 @@
-#
-# SPEAr13XX Machine configuration file
-#
-
-if ARCH_SPEAR13XX
-
-menu "SPEAr13xx Implementations"
-config MACH_SPEAR1310
-	bool "SPEAr1310 Machine support with Device Tree"
-	select PINCTRL_SPEAR1310
-	help
-	  Supports ST SPEAr1310 machine configured via the device-tree
-
-config MACH_SPEAR1340
-	bool "SPEAr1340 Machine support with Device Tree"
-	select PINCTRL_SPEAR1340
-	help
-	  Supports ST SPEAr1340 machine configured via the device-tree
-endmenu
-endif #ARCH_SPEAR13XX
diff --git a/arch/arm/mach-spear3xx/Kconfig b/arch/arm/mach-spear3xx/Kconfig
deleted file mode 100644
index 8bd3729..0000000
--- a/arch/arm/mach-spear3xx/Kconfig
+++ /dev/null
@@ -1,26 +0,0 @@
-#
-# SPEAr3XX Machine configuration file
-#
-
-if ARCH_SPEAR3XX
-
-menu "SPEAr3xx Implementations"
-config MACH_SPEAR300
-	bool "SPEAr300 Machine support with Device Tree"
-	select PINCTRL_SPEAR300
-	help
-	  Supports ST SPEAr300 machine configured via the device-tree
-
-config MACH_SPEAR310
-	bool "SPEAr310 Machine support with Device Tree"
-	select PINCTRL_SPEAR310
-	help
-	  Supports ST SPEAr310 machine configured via the device-tree
-
-config MACH_SPEAR320
-	bool "SPEAr320 Machine support with Device Tree"
-	select PINCTRL_SPEAR320
-	help
-	  Supports ST SPEAr320 machine configured via the device-tree
-endmenu
-endif #ARCH_SPEAR3XX
diff --git a/arch/arm/mach-spear6xx/Kconfig b/arch/arm/mach-spear6xx/Kconfig
deleted file mode 100644
index 339f397..0000000
--- a/arch/arm/mach-spear6xx/Kconfig
+++ /dev/null
@@ -1,10 +0,0 @@
-#
-# SPEAr6XX Machine configuration file
-#
-
-config MACH_SPEAR600
-	def_bool y
-	depends on ARCH_SPEAR6XX
-	select USE_OF
-	help
-	  Supports ST SPEAr600 boards configured via the device-tree
diff --git a/arch/arm/plat-spear/Kconfig b/arch/arm/plat-spear/Kconfig
index 87dbd81..60987a3 100644
--- a/arch/arm/plat-spear/Kconfig
+++ b/arch/arm/plat-spear/Kconfig
@@ -38,9 +38,52 @@ config ARCH_SPEAR6XX
 
 endchoice
 
-# Adding SPEAr machine specific configuration files
-source "arch/arm/mach-spear13xx/Kconfig"
-source "arch/arm/mach-spear3xx/Kconfig"
-source "arch/arm/mach-spear6xx/Kconfig"
+if ARCH_SPEAR13XX
+
+menu "SPEAr13xx Implementations"
+config MACH_SPEAR1310
+	bool "SPEAr1310 Machine support with Device Tree"
+	select PINCTRL_SPEAR1310
+	help
+	  Supports ST SPEAr1310 machine configured via the device-tree
+
+config MACH_SPEAR1340
+	bool "SPEAr1340 Machine support with Device Tree"
+	select PINCTRL_SPEAR1340
+	help
+	  Supports ST SPEAr1340 machine configured via the device-tree
+endmenu
+endif #ARCH_SPEAR13XX
+
+if ARCH_SPEAR3XX
+
+menu "SPEAr3xx Implementations"
+config MACH_SPEAR300
+	bool "SPEAr300 Machine support with Device Tree"
+	select PINCTRL_SPEAR300
+	help
+	  Supports ST SPEAr300 machine configured via the device-tree
+
+config MACH_SPEAR310
+	bool "SPEAr310 Machine support with Device Tree"
+	select PINCTRL_SPEAR310
+	help
+	  Supports ST SPEAr310 machine configured via the device-tree
+
+config MACH_SPEAR320
+	bool "SPEAr320 Machine support with Device Tree"
+	select PINCTRL_SPEAR320
+	help
+	  Supports ST SPEAr320 machine configured via the device-tree
+endmenu
+
+endif
+
+config MACH_SPEAR600
+	def_bool y
+	depends on ARCH_SPEAR6XX
+	select USE_OF
+	help
+	  Supports ST SPEAr600 boards configured via the device-treesource "arch/arm/mach-spear6xx/Kconfig"
 
 endif
-- 
1.8.0
