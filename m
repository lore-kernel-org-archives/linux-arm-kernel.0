From: viresh.kumar@st.com (Viresh KUMAR)
Date: Mon, 30 Aug 2010 16:09:34 +0530
Subject: [PATCH 71/74] SPEAr13xx: Rework KConfig to allow all boards to be
	compiled in
In-Reply-To: <cover.1283161023.git.viresh.kumar@st.com>
References: <cover.1283161023.git.viresh.kumar@st.com>
Message-ID: <7b4d066987fd7dc857a526362cf61552515e5477.1283161024.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that all three SPEAr13xx platforms can be built into one kernel,
rework KConfig to allow this. Move everything into one KConfig file
while we are here.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
Signed-off-by: shiraz hashim <shiraz.hashim@st.com>
---
 arch/arm/mach-spear13xx/Kconfig     |   23 ++++++++++++++---------
 arch/arm/mach-spear13xx/Kconfig1300 |   17 -----------------
 arch/arm/mach-spear13xx/Kconfig1310 |   17 -----------------
 3 files changed, 14 insertions(+), 43 deletions(-)
 delete mode 100644 arch/arm/mach-spear13xx/Kconfig1300
 delete mode 100644 arch/arm/mach-spear13xx/Kconfig1310

diff --git a/arch/arm/mach-spear13xx/Kconfig b/arch/arm/mach-spear13xx/Kconfig
index cc8faa4..229ef93 100644
--- a/arch/arm/mach-spear13xx/Kconfig
+++ b/arch/arm/mach-spear13xx/Kconfig
@@ -4,9 +4,20 @@
 
 if ARCH_SPEAR13XX
 
-choice
-	prompt "SPEAr13XX Family"
-	default MACH_SPEAR1300
+menu "SPEAr13xx Implementations"
+config BOARD_SPEAR1300_EVB
+	bool "SPEAr1300 Evaluation Board"
+	select MACH_SPEAR1300
+	help
+	  Supports ST SPEAr1300 Evaluation Board
+
+config BOARD_SPEAR1310_EVB
+	bool "SPEAr1310 Evaluation Board"
+	select MACH_SPEAR1310
+	help
+	  Supports ST SPEAr1310 Evaluation Board
+
+endmenu
 
 config MACH_SPEAR1300
 	bool "SPEAr1300"
@@ -18,10 +29,4 @@ config MACH_SPEAR1310
 	help
 	  Supports ST SPEAr1310 Machine
 
-endchoice
-
-# Adding SPEAr13XX machine specific configuration files
-source "arch/arm/mach-spear13xx/Kconfig1300"
-source "arch/arm/mach-spear13xx/Kconfig1310"
-
 endif #ARCH_SPEAR13XX
diff --git a/arch/arm/mach-spear13xx/Kconfig1300 b/arch/arm/mach-spear13xx/Kconfig1300
deleted file mode 100644
index 5d6feb1..0000000
--- a/arch/arm/mach-spear13xx/Kconfig1300
+++ /dev/null
@@ -1,17 +0,0 @@
-#
-# SPEAr1300 machine configuration file
-#
-
-if MACH_SPEAR1300
-
-choice
-	prompt "SPEAr1300 Boards"
-	default BOARD_SPEAR1300_EVB
-
-config BOARD_SPEAR1300_EVB
-	bool "SPEAr1300 Evaluation Board"
-	help
-	  Supports ST SPEAr1300 Evaluation Board
-endchoice
-
-endif #MACH_SPEAR1300
diff --git a/arch/arm/mach-spear13xx/Kconfig1310 b/arch/arm/mach-spear13xx/Kconfig1310
deleted file mode 100644
index ad61820..0000000
--- a/arch/arm/mach-spear13xx/Kconfig1310
+++ /dev/null
@@ -1,17 +0,0 @@
-#
-# SPEAr1310 machine configuration file
-#
-
-if MACH_SPEAR1310
-
-choice
-	prompt "SPEAr1310 Boards"
-	default BOARD_SPEAR1310_EVB
-
-config BOARD_SPEAR1310_EVB
-	bool "SPEAr1310 Evaluation Board"
-	help
-	  Supports ST SPEAr1310 Evaluation Board
-endchoice
-
-endif #MACH_SPEAR1310
-- 
1.7.2.2
