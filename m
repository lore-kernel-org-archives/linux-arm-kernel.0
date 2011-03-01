From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 1 Mar 2011 16:56:41 +0530
Subject: [PATCH V6 08/11] ST SPEAr3xx: Rework KConfig to allow all boards to
	be compiled in
In-Reply-To: <cover.1298977709.git.viresh.kumar@st.com>
References: <cover.1298977709.git.viresh.kumar@st.com>
Message-ID: <bea4b8c20dabfd4239a8f762b1a46f5c641cd465.1298977709.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ryan Mallon <ryan@bluewatersys.com>

Now that all three SPEAr3xx platforms can be built into one kernel,
rework KConfig to allow this. Move everything into one KConfig file
while we are here.

Reviewed-by: Stanley Miao <stanley.miao@windriver.com>
Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/mach-spear3xx/Kconfig    |   30 ++++++++++++++++++++----------
 arch/arm/mach-spear3xx/Kconfig300 |   17 -----------------
 arch/arm/mach-spear3xx/Kconfig310 |   17 -----------------
 arch/arm/mach-spear3xx/Kconfig320 |   17 -----------------
 4 files changed, 20 insertions(+), 61 deletions(-)
 delete mode 100644 arch/arm/mach-spear3xx/Kconfig300
 delete mode 100644 arch/arm/mach-spear3xx/Kconfig310
 delete mode 100644 arch/arm/mach-spear3xx/Kconfig320

diff --git a/arch/arm/mach-spear3xx/Kconfig b/arch/arm/mach-spear3xx/Kconfig
index 20d1317..2cee6b0 100644
--- a/arch/arm/mach-spear3xx/Kconfig
+++ b/arch/arm/mach-spear3xx/Kconfig
@@ -4,9 +4,26 @@
 
 if ARCH_SPEAR3XX
 
-choice
-	prompt "SPEAr3XX Family"
-	default MACH_SPEAR300
+menu "SPEAr3xx Implementations"
+config BOARD_SPEAR300_EVB
+	bool "SPEAr300 Evaluation Board"
+	select MACH_SPEAR300
+	help
+	  Supports ST SPEAr300 Evaluation Board
+
+config BOARD_SPEAR310_EVB
+	bool "SPEAr310 Evaluation Board"
+	select MACH_SPEAR310
+	help
+	  Supports ST SPEAr310 Evaluation Board
+
+config BOARD_SPEAR320_EVB
+	bool "SPEAr320 Evaluation Board"
+	select MACH_SPEAR320
+	help
+	  Supports ST SPEAr320 Evaluation Board
+
+endmenu
 
 config MACH_SPEAR300
 	bool "SPEAr300"
@@ -23,11 +40,4 @@ config MACH_SPEAR320
 	help
 	  Supports ST SPEAr320 Machine
 
-endchoice
-
-# Adding SPEAr3XX machine specific configuration files
-source "arch/arm/mach-spear3xx/Kconfig300"
-source "arch/arm/mach-spear3xx/Kconfig310"
-source "arch/arm/mach-spear3xx/Kconfig320"
-
 endif #ARCH_SPEAR3XX
diff --git a/arch/arm/mach-spear3xx/Kconfig300 b/arch/arm/mach-spear3xx/Kconfig300
deleted file mode 100644
index c519a05..0000000
--- a/arch/arm/mach-spear3xx/Kconfig300
+++ /dev/null
@@ -1,17 +0,0 @@
-#
-# SPEAr300 machine configuration file
-#
-
-if MACH_SPEAR300
-
-choice
-	prompt "SPEAr300 Boards"
-	default BOARD_SPEAR300_EVB
-
-config BOARD_SPEAR300_EVB
-	bool "SPEAr300 Evaluation Board"
-	help
-	  Supports ST SPEAr300 Evaluation Board
-endchoice
-
-endif	#MACH_SPEAR300
diff --git a/arch/arm/mach-spear3xx/Kconfig310 b/arch/arm/mach-spear3xx/Kconfig310
deleted file mode 100644
index 60e7442..0000000
--- a/arch/arm/mach-spear3xx/Kconfig310
+++ /dev/null
@@ -1,17 +0,0 @@
-#
-# SPEAr310 machine configuration file
-#
-
-if MACH_SPEAR310
-
-choice
-	prompt "SPEAr310 Boards"
-	default BOARD_SPEAR310_EVB
-
-config BOARD_SPEAR310_EVB
-	bool "SPEAr310 Evaluation Board"
-	help
-	  Supports ST SPEAr310 Evaluation Board
-endchoice
-
-endif	#MACH_SPEAR310
diff --git a/arch/arm/mach-spear3xx/Kconfig320 b/arch/arm/mach-spear3xx/Kconfig320
deleted file mode 100644
index 1c1d438..0000000
--- a/arch/arm/mach-spear3xx/Kconfig320
+++ /dev/null
@@ -1,17 +0,0 @@
-#
-# SPEAr320 machine configuration file
-#
-
-if MACH_SPEAR320
-
-choice
-	prompt "SPEAr320 Boards"
-	default BOARD_SPEAR320_EVB
-
-config BOARD_SPEAR320_EVB
-	bool "SPEAr320 Evaluation Board"
-	help
-	  Supports ST SPEAr320 Evaluation Board
-endchoice
-
-endif	#MACH_SPEAR320
-- 
1.7.2.2
