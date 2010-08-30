From: viresh.kumar@st.com (Viresh KUMAR)
Date: Mon, 30 Aug 2010 16:09:31 +0530
Subject: [PATCH 68/74] SPEAr6xx: Rework Kconfig for single image solution
In-Reply-To: <cover.1283161023.git.viresh.kumar@st.com>
References: <cover.1283161023.git.viresh.kumar@st.com>
Message-ID: <643d2526109b8c4edfdb59f8a56300410bcb9f17.1283161024.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
Signed-off-by: Rajeev Kumar <rajeev-dlh.kumar@st.com>
---
 arch/arm/mach-spear6xx/Kconfig    |   15 ++++++++-------
 arch/arm/mach-spear6xx/Kconfig600 |   17 -----------------
 2 files changed, 8 insertions(+), 24 deletions(-)
 delete mode 100644 arch/arm/mach-spear6xx/Kconfig600

diff --git a/arch/arm/mach-spear6xx/Kconfig b/arch/arm/mach-spear6xx/Kconfig
index bddba03..ff4ae5b 100644
--- a/arch/arm/mach-spear6xx/Kconfig
+++ b/arch/arm/mach-spear6xx/Kconfig
@@ -4,17 +4,18 @@
 
 if ARCH_SPEAR6XX
 
-choice
-	prompt "SPEAr6XX Family"
-	default MACH_SPEAR600
+menu "SPEAr6xx Implementations"
+config BOARD_SPEAR600_EVB
+	bool "SPEAr600 Evaluation Board"
+	select MACH_SPEAR600
+	help
+	  Supports ST SPEAr600 Evaluation Board
+
+endmenu
 
 config MACH_SPEAR600
 	bool "SPEAr600"
 	help
 	  Supports ST SPEAr600 Machine
-endchoice
-
-# Adding SPEAr6XX machine specific configuration files
-source "arch/arm/mach-spear6xx/Kconfig600"
 
 endif #ARCH_SPEAR6XX
diff --git a/arch/arm/mach-spear6xx/Kconfig600 b/arch/arm/mach-spear6xx/Kconfig600
deleted file mode 100644
index 9e19f65..0000000
--- a/arch/arm/mach-spear6xx/Kconfig600
+++ /dev/null
@@ -1,17 +0,0 @@
-#
-# SPEAr600 machine configuration file
-#
-
-if MACH_SPEAR600
-
-choice
-	prompt "SPEAr600 Boards"
-	default BOARD_SPEAR600_EVB
-
-config	BOARD_SPEAR600_EVB
-	bool "SPEAr600 Evaluation Board"
-	help
-	  Supports ST SPEAr600 Evaluation Board
-endchoice
-
-endif	#MACH_SPEAR600
-- 
1.7.2.2
